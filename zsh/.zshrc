# Lines configured by zsh-newuser-install
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/tofweod/.zshrc'


if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export TERM=xterm-256color

export LANG=en_US.UTF-8

export BOOST_ROOT=/usr/local/boost_1_84_0/

export EDITOR=nvim

export PATH="$PATH:/home/tofweod/pintos/src/utils:/home/tofweod/.local/bin"

export BAT_THEME="ansi"


# alias
alias clc='clear -x'

alias d='dirs -v'

alias date='date +%Y-%m-%d\ %H:%M:%S'

alias v='nvim'

alias tl='trash-list'

alias te='trash-empty'

alias trs='trash-restore'

alias ytdlp='yt-dlp --cookies-from-browser firefox'

alias j='z'

alias du='dust'

alias fetch='fastfetch'

alias l='ls -l'


# ranger settings
ranger_cd() {
    temp_file="$(mktemp -t "ranger_cd.XXXXXXXXXX")"
    ranger --choosedir="$temp_file" -- "${@:-$PWD}"
    if chosen_dir="$(cat -- "$temp_file")" && [ -n "$chosen_dir" ] && [ "$chosen_dir" != "$PWD" ]; then
        cd -- "$chosen_dir"
    fi
    rm -f -- "$temp_file"
}

alias rr='ranger_cd'

open_file() {
  res=$1
  type=$(file -b $res)
  if [[ $type =~ "text" ]];then
    v $res
  elif [[ $type =~ "PNG|JPEG|JPG" ]]; then
    ristretto $res
  elif [[ $type =~ "PDF" ]]; then
    zathura --fork $res
  elif [[ $type =~ "symbolic link" ]];then
    res=$(readlink -f $res)
    open_file $res
  fi
}

# fzf search
fzf_select() {
  res=$(fd --hidden --follow --exclude={.wine,.git,.idea,.vscode,node_modules,build,ssd} | fzf --preview='bat --color=always {}')

  if [[ -z $res ]];then
    return
  elif [[ -d $res ]]; then
    cd $res
  fi

  open_file $res
}

alias ff='fzf_select'

get_md5() {
  if [[ -z "$1" ]];then
    echo "No arguments..."
    return 2
  fi
  md5=$(echo $1 | md5sum | awk '{print $1}')
  echo $md5
}

alias md5='get_md5'

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zdharma-continuum/zinit-annex-as-monitor \
    zdharma-continuum/zinit-annex-bin-gem-node \
    zdharma-continuum/zinit-annex-patch-dl \
    zdharma-continuum/zinit-annex-rust

### End of Zinit's installer chunk

zinit ice lucid wait='1'
zinit light skywind3000/z.lua

# 语法高亮
zinit ice lucid wait='0' atinit='zpcompinit'
zinit light zdharma/fast-syntax-highlighting

# 自动建议
zinit ice lucid wait="0" atload='_zsh_autosuggest_start'
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-autosuggestions

# 补全
zinit ice lucid wait='0'
zinit light zsh-users/zsh-completions

# vi-mode
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# 加载 OMZ 框架及部分插件
zinit snippet OMZ::lib/completion.zsh
zinit snippet OMZ::lib/history.zsh
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh
zinit snippet OMZ::plugins/sudo/sudo.plugin.zsh

zinit snippet OMZ::plugins/extract

zinit ice lucid wait='1'
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit load 'zsh-users/zsh-history-substring-search'
zinit ice wait atload'_history_substring_search_config'

# 主题
zinit ice depth=1; zinit light romkatv/powerlevel10k

# optional
zinit as="null" wait="1" lucid from="gh-r" for \
    mv="*/rg -> rg"  sbin		BurntSushi/ripgrep \
    mv="fd* -> fd"   sbin="fd/fd"  @sharkdp/fd \
    sbin="fzf"       junegunn/fzf-bin

# 加载它们的补全等
zinit ice mv="*.zsh -> _fzf" as="completion"
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/completion.zsh'
zinit snippet 'https://github.com/junegunn/fzf/blob/master/shell/key-bindings.zsh'

#mcfly
zinit ice lucid wait"0a" from"gh-r" as"program" atload'eval "$(mcfly init zsh)"'
zinit light cantino/mcfly
export MCFLY_KEY_SCHEME=vim

DISABLE_LS_COLORS=true
alias ls=eza
# 配置 fzf 使用 fd
export FZF_DEFAULT_COMMAND='fd --type f'
# ---- 加载完了 ----

bindkey -M vicmd '^P' history-substring-search-up
bindkey -M vicmd '^N' history-substring-search-down
