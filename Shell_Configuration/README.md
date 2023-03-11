# Shell 脚本配置
### Bash 
1.快捷键映射`alias`

举例
```
alias vpnclash='cd /home/up/softwares/clash && chmod +x clash && ./clash -d .'
```

2.PX4仿真环境变量添加
```
export PX4_DIR=~/softwares/PX4-Autopilot   // path to PX4
source $PX4_DIR/Tools/setup_gazebo.bash $PX4_DIR $PX4_DIR/build/px4_sitl_default
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$PX4_DIR
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$PX4_DIR/Tools/sitl_gazebo

```

### Zsh
#### Zsh安装
```
sudo apt-get install zsh    //下载
chsh -s /bin/zsh      //将zsh设置为系统默认shell，新开一个 Shell Session，开始使用zsh，如果不行就重启动
```
第一次打开后，需要自行配置，可按`Q`键直接退出，下载oh-my-zsh来修改 zsh 的主题和安装常用的插件

使用`curl`下载脚本并安装:
```
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```
或者使用`wget`下载脚本并安装:
```
sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"
```
#### Zsh主题
推荐主题`powerlevel10k`
```
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
```
编辑`~/.zshrc`，键入以下内容并保存：
```
ZSH_THEME="powerlevel10k/powerlevel10k"
```
#### Zsh插件
重新开一个`shell`方可生效
##### zsh-autosuggestions,命令提示插件,必装
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```
在`.zshrc`中，把`zsh-autosuggestions`加入插件列表：
```
plugins=(
    # other plugins...
    zsh-autosuggestions  # 插件之间使用空格隔开
)
```
##### zsh-syntax-highlighting,命令语法校验插件,必装
```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting 
```
加入插件列表
```
plugins=(
    # other plugins...
    zsh-autosuggestions
    zsh-syntax-highlighting
)
```

##### Z,文件夹快捷跳转
对于曾经跳转过的目录，只需要输入最终目标文件夹名称，就可以快速跳转，避免再输入长串路径，提高切换文件夹的效率
内置，只需要加入插件列表即可





























