# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/home/anderstf/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(git)

source $ZSH/oh-my-zsh.sh

alias ra="ranger"
alias za="zathura"
alias vim="nvim"
alias zshconfig="nvim ~/.zshrc"
alias i3config="nvim ~/.config/i3/config"
alias settings="env XDG_CURRENT_DESKTOP=GNOME gnome-control-center"
alias vimconfig="cd ~/.config/nvim/ && ls"
alias python="python3"
alias pip="pip3"
