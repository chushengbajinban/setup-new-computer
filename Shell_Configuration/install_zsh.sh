#!/bin/bash

# 更新系统源并安装依赖
sudo apt-get update
sudo apt-get install -y zsh git

# 清理旧的 Oh My Zsh 安装（如果存在）
echo "清理旧的 Oh My Zsh 安装..."
sudo rm -rf ~/.oh-my-zsh

# 安装 Oh My Zsh（静默模式）
echo "开始安装 Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 设置默认 Shell 为 Zsh
echo "设置默认 Shell 为 Zsh..."
sudo chsh -s $(which zsh) $USER  # 确保指定用户（避免 root）

# 安装 Powerlevel10k 主题和插件
echo "安装 Powerlevel10k 主题..."
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo "安装插件..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 配置 Zsh 设置
echo "配置 Zsh 主题和插件..."
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/g' ~/.zshrc
sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k/powerlevel10k"/g' ~/.zshrc

# 重启 Shell
echo "完成！现在启动 Zsh..."
exec zsh
