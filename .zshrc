# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/vince/.zshrc'

autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# End of lines added by compinstall
alias vim='nvim'
export EDITOR=vim
export VISUAL=vim
PROMPT="[%n@%m%~]$ "

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/lib64/qt5/bin:$PATH


pokefetch # show a random pokemon using fastfetch
alias bat=batcat
