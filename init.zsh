#!/usr/bin/env zsh

######
# This file is stored in .config/.zsh
# for this to work properly, session needs to have the environment variable
# ZDOTDIR=${HOME}/.config/zsh
######

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

source '/usr/share/zsh-antidote/antidote.zsh'
antidote load

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /home/clint/src/github.com/lincheney/fzf-tab-completion/zsh/fzf-zsh-completion.sh

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
bindkey -v
# Using joshskidmore/zsh-fzf-history-search instead
#bindkey "^P" history-beginning-search-backward
#bindkey "^N" history-beginning-search-forward
#bindkey "^R" history-incremental-search-backward

# COLORS!
export BAT_THEME="Dracula"
export BAT_STYLE="plain"

alias ip='ip -color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'

function sbg() {
  nohup "$@" &>/dev/null & disown %%
}

alias l='ls'
alias cat=bat

# fzf cd
function d() {
  cd $(fd --type directory "$@" | fzf)
}

function c() {
  echo "$@" | bc -l
}

# history load from other shells
alias hl='fc -R'

# alias .. to cd ../ and ... to cd ../.. all the way to 32 parent directories
for i in {2..32}; do
s=$(for j in {1..${i}}; do echo -n '.'; done)
d=$(for j in {1..$((${i}-1))}; do echo -n '../'; done)
alias ${s}="cd ${d}"  
done

alias f='fzf'

function file-open() {
  f=$(fzf $@)
  sbg xdg-open "$f"
}

alias fo=file-open

# fzf ripgrep and find
alias g='rfv'

# fzf edit
function e() {
  ${EDITOR} $(fzf --multi)
}

if [[ "$TERM" == "xterm-kitty" ]] {
  source "$ZDOTDIR/kitty.zsh"
}

#__fsel() {
#  local cmd="${FZF_CTRL_T_COMMAND:-"command find -L . -mindepth 1 \\( -path '*/\\.*' -o -fstype 'sysfs' -o -fstype 'devfs' -o -fstype 'devtmpfs' -o -fstype 'proc' \\) -prune \
#    -o -type f -print \
#    -o -type d -print \
#    -o -type l -print 2> /dev/null | cut -b3-"}"
#  setopt localoptions pipefail no_aliases 2> /dev/null
#  local item
#  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore ${FZF_DEFAULT_OPTS-} ${FZF_CTRL_T_OPTS-}" $(__fzfcmd) -m "$@" | while read item; do
#    echo -n "${(qq)item} "
#  done
#  local ret=$?
#  echo
#  return $ret
#}


#autoload -U split-shell-arguments
#autoload -U modify-current-argument

#function fzf-arg() {
#  if [[ -z $BUFFER ]]; then
#    fzf_completion
#    # Empty buffer, try finding an executable to run
#    #LBUFFER=$(/usr/bin/cat <(hash | awk -F '=' '{print $1}') <(fd -t x -d1 | sed 's#^#./#') | fzf)
#    #modify-current-argument '$(FZF_CTRL_T_COMMAND="~/src/github.com/Valodim/zsh-capture-completion/capture.zsh ${BUFFER}" __fsel)'
#  elif [[ "$BUFFER[$CURSOR]" == " " && "$BUFFER[$CURSOR-1]" != "\\" ]]; then
#    # New argument don't set query
#    LBUFFER="${LBUFFER}$(__fsel)"
#  else
#    # Use the existing partial argument as the query
#    modify-current-argument '$(FZF_CTRL_T_OPTS="${FZF_CTRL_T_OPTS} -q ${ARG}" __fsel)'
#  fi
#  zle reset-prompt
#}
#
#zle -N fzf-arg
#bindkey '^T' fzf-arg

zstyle ':completion:*' insert-tab false
function toggle_empty_tab() {
  if zstyle -t ':completion:*' insert-tab; then
    zstyle ':completion:*' insert-tab false
  else
    zstyle ':completion:*' insert-tab true
  fi
}

zle -N toggle_empty_tab
bindkey '^T' toggle_empty_tab
