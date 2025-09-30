#!/bin/bash

# git-mzy.sh - 增强版 Git 分支管理工具（支持彩色输出）
# 用法：source git-mzy.sh  或  . git-mzy.sh
# 提供命令：mzy_git_pull <branch>  和  mzy_git_delete <branch>

# ANSI 颜色定义（仅在支持颜色的终端中启用）
if [[ -t 1 ]]; then
    # 终端是交互式的，启用颜色
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    BLUE='\033[0;34m'
    CYAN='\033[0;36m'
    NC='\033[0m' # No Color
else
    # 非交互式环境（如 CI），禁用颜色
    RED=''
    GREEN=''
    YELLOW=''
    BLUE=''
    CYAN=''
    NC=''
fi

# 函数：拉取指定分支（自动配置 fetch 规则）
mzy_git_pull() {
    local BRANCH="$1"

    if [ -z "$BRANCH" ]; then
        echo -e "${RED}错误：请指定分支名。${NC}"
        echo -e "用法: ${CYAN}mzy_git_pull <分支名>${NC}"
        return 1
    fi

    local FETCH_REF="+refs/heads/${BRANCH}:refs/remotes/origin/$BRANCH"
    local CONFIG_KEY="remote.origin.fetch"

    if ! git config --get-all "$CONFIG_KEY" | grep -Fqx "$FETCH_REF"; then
        git config --add "$CONFIG_KEY" "$FETCH_REF"
        echo -e "${GREEN}已添加 fetch 配置:${NC} $FETCH_REF"
    else
        echo -e "${BLUE}fetch 配置已存在，跳过添加:${NC} $FETCH_REF"
    fi

    echo -e "${CYAN}正在执行 git fetch...${NC}"
    if ! git fetch origin "$BRANCH"; then
        echo -e "${RED}❌ git fetch 失败，请检查网络或分支名。${NC}"
        return 1
    fi

    if git show-ref --verify --quiet "refs/heads/$BRANCH"; then
        echo -e "${GREEN}本地分支 '${BRANCH}' 已存在，切换并拉取更新...${NC}"
        git checkout "$BRANCH" && git pull origin "$BRANCH"
    else
        echo -e "${GREEN}创建并切换到本地分支 '${BRANCH}'（基于 origin/${BRANCH}）...${NC}"
        git checkout -b "$BRANCH" "origin/$BRANCH"
    fi
}

# 函数：彻底清理指定分支（本地 + 远程跟踪 + fetch 配置）
mzy_git_delete() {
    local branch_name="$1"
    local remote_name="origin"

    if [[ -z "$branch_name" ]]; then
        echo -e "${RED}❌ 错误: 请提供分支名（例如: main_dev/hnp）${NC}" >&2
        return 1
    fi

    local remote_ref="refs/remotes/$remote_name/$branch_name"
    local local_remote_branch="$remote_name/$branch_name"
    local fetch_line="fetch = +refs/heads/${branch_name}:refs/remotes/$remote_name/$branch_name"

    # 1. 删除本地分支
    if git show-ref --verify -q "refs/heads/$branch_name"; then
        echo -e "${RED}🗑️  正在删除本地分支:${NC} $branch_name"
        if ! git branch -D "$branch_name" >/dev/null 2>&1; then
            echo -e "${YELLOW}⚠️  警告: 无法强制删除本地分支 '$branch_name'（可能正被使用）${NC}"
        fi
    else
        echo -e "${BLUE}ℹ️  本地分支 '$branch_name' 不存在，跳过删除。${NC}"
    fi

    # 2. 删除远程跟踪分支
    if git show-ref --verify -q "$remote_ref"; then
        echo -e "${RED}🗑️  正在删除远程跟踪分支:${NC} $local_remote_branch"
        if ! git branch -d -r "$local_remote_branch" >/dev/null 2>&1; then
            echo -e "${YELLOW}⚠️  警告: 无法删除远程跟踪分支 '$local_remote_branch'${NC}"
        fi
    else
        echo -e "${BLUE}ℹ️  远程跟踪分支 '$local_remote_branch' 不存在，跳过删除。${NC}"
    fi

    # 3. 清理 .git/config 中的 fetch 规则
    local config_file=".git/config"
    if [[ ! -f "$config_file" ]]; then
        echo -e "${RED}❌ 错误: 未找到 Git 配置文件 '$config_file'${NC}" >&2
        return 1
    fi

    if grep -Fq "$fetch_line" "$config_file"; then
        echo -e "${CYAN}🧹 正在从 .git/config 中移除 fetch 规则:${NC} $branch_name"
        # 兼容 macOS 和 Linux 的 sed（使用备份扩展名为空）
        if [[ "$OSTYPE" == "darwin"* ]]; then
            sed -i '' "\|$fetch_line|d" "$config_file"
        else
            sed -i "\|$fetch_line|d" "$config_file"
        fi
    else
        echo -e "${BLUE}ℹ️  .git/config 中未找到对应的 fetch 规则，跳过。${NC}"
    fi

    echo -e "${GREEN}✅ 完成: 分支 '$branch_name' 的本地分支、远程跟踪分支及 fetch 配置已清理。${NC}"
}

# Bash 补全函数
_mzy_git_delete_completion_bash() {
    local cur prev words cword
    _init_completion || return

    cur="${COMP_WORDS[COMP_CWORD]}"

    local local_branches
    local_branches=$(git branch 2>/dev/null | sed 's/^[* ] *//')

    local remote_branches
    remote_branches=$(git branch -r 2>/dev/null | grep "^  origin/" | sed 's/^  origin\///')

    local all_branches
    all_branches=$(echo "$local_branches"; echo "$remote_branches" | grep -v '^$')

    COMPREPLY=($(compgen -W "$all_branches" -- "$cur"))
}

# Zsh 补全函数
_mzy_git_delete_completion_zsh() {
    local -a branches
    # 获取本地分支（去掉 *）
    local local_branches=("${(@f)$(git branch 2>/dev/null | sed 's/^[* ] *//')}")
    # 获取 origin/ 远程分支（去掉前缀）
    local remote_branches=("${(@f)$(git branch -r 2>/dev/null | awk '/^  origin\// {print substr($0, 10)}')}")
    # 合并并去重
    branches=("${(@u)local_branches[@]}" "${(@u)remote_branches[@]}")
    # 补全
    _describe 'branch' branches
}

# 自动判断 shell 并注册补全
if [[ -n "${BASH_VERSION:-}" ]]; then
    # Bash
    complete -F _mzy_git_delete_completion_bash mzy_git_delete
elif [[ -n "${ZSH_VERSION:-}" ]]; then
    # Zsh
    compdef _mzy_git_delete_completion_zsh mzy_git_delete
fi

# 可选：打印加载成功信息（仅在交互式 shell 中）
# if [[ "${BASH_SOURCE[0]}" != "${0}" ]] && [[ -t 1 ]]; then
#     echo -e "${GREEN}✅ 已加载 mzy Git 工具：mzy_git_pull / mzy_git_delete${NC}"
# fi
