#!/bin/bash

# 更新软件包列表
sudo apt-get update

# 安装必要软件
sudo apt-get install -y zsh git

# 非交互式安装oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# 更改默认shell为zsh
chsh -s $(which zsh)

# 安装Powerlevel10k主题
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

# 安装插件
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# 添加插件到配置
sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting zsh-autosuggestions)/g' ~/.zshrc

# 配置.zshrc文件
sed -i 's/ZSH_THEME="[^"]*"/ZSH_THEME="powerlevel10k/powerlevel10k"/g' ~/.zshrc

# 重新加载配置并切换到新zsh环境
exec zsh