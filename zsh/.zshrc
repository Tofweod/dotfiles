# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tofweod/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
#

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM=xterm-256color


# plugins
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
source /usr/share/autojump/autojump.zsh
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh


export LANG=en_US.UTF-8

export BOOST_ROOT=/usr/local/boost_1_84_0/

export EDITOR=nvim

export PATH="$PATH:/home/tofweod/pintos/src/utils:/home/tofweod/.local/bin"

export LSCOLORS="exfxcxdxbxexexabagacad"


# alias
# color output
alias ls='ls --color=tty'
alias grep='grep --color=auto'

alias clc='clear -x'

alias v='nvim'

alias tl='trash-list'

alias te='trash-empty'

alias trs='trash-restore'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
