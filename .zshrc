# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git
         zsh-autosuggestions
         zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# ros
source /opt/ros/melodic/setup.zsh
source ~/workspaces/catkin_ws/devel/setup.zsh
#source ~/workspaces/ws_2022/devel/setup.zsh
#source ~/workspaces/ws_temp/devel/setup.zsh
#source ~/workspaces/ws_swarm/devel/setup.zsh
source ~/workspaces/ss_ws/devel/setup.zsh

# px4
export PX4_DIR=~/softwares/PX4-Autopilot
# export PX4_DIR=~/PX4-Autopilot
source $PX4_DIR/Tools/setup_gazebo.bash $PX4_DIR $PX4_DIR/build/px4_sitl_default
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$PX4_DIR
export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$PX4_DIR/Tools/sitl_gazebo

# alias
# vpn
alias vpnclash='cd /home/up/softwares/clash && chmod +x clash && ./clash -d .'
# ssh
#ssh
alias pssh=parallel-ssh
alias pscp=parallel-scp
alias prsync=parallel-rsync
alias pnuke=parallel-nuke
alias pslurp=parallel-slurp
alias mzypssh='pssh -h swarmIP.txt -i'
alias pssh-git='parallel-ssh -p 10 -h ~/projects/swarm_control/swarmIP.txt -P -i "zsh ~/swarm_script/git_update.sh"'
alias pssh-catkin='parallel-ssh -p 10 -h ~/projects/swarm_control/swarmIP.txt -P -i "zsh ~/swarm_script/catkin_make.sh"'
alias pssh-start-bag='parallel-ssh -p 10 -h ~/swarm+viconIP.txt -P -i "~/swarm_script/para_rosbag.sh"'
alias pssh-get-up-bag='parallel-slurp -p 10 -h ~/projects/swarm_control/swarmIP.txt -L ~/Documents/rosbag/ -r /home/up/rosbag/ ./'
alias pssh-clear-bag='parallel-ssh -p 10 -h ~/swarm+viconIP.txt -P -i "rm -rf ~/rosbag/*"'

alias pssh-launch='parallel-ssh -p 10 -h ~/dwip.txt -P -i "bash ~/bag/tmux_launch.sh"'
alias pssh-record='parallel-ssh -p 10 -h ~/dwip.txt -P -i "bash ~/bag/tmux_record.sh"'
alias pssh-stop='parallel-ssh -p 10 -h ~/dwip.txt -P -i "bash ~/bag/tmux_stop.sh"'

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/up/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/up/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/home/up/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/up/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

