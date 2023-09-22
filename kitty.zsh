### Kitty notes
# ls --hyperlink=auto for remote editing in ssh
#
# ctrl+shift+U for unicode insertion
#
# ctrl+shift+[ for links
# ctrl+shift+f for files

alias icat="kitty +kitten icat"
alias icat-clip="kitty +kitten clipboard -g -m 'image/*' /dev/stdout | kitty +kitten icat --stdin yes --transfer-mode stream"
alias clip='kitty +kitten clipboard'

function kitty-cat() {
  if [[ $# != 1 ]]; then
    return bat $@
  fi
  if [[ "$1" = "-clip" ]]; then
    mime=$(kitty +kitten clipboard -g -m . /dev/stdout | head -1)
    if [[ "$mime" = image/* ]]; then
      kitty +kitten clipboard -g -m 'image/*' /dev/stdout | kitty +kitten icat --stdin yes --transfer-mode stream
      return
    fi
    kitty +kitten clipboard -g | bat
    return
  fi
  mime=$(xdg-mime query filetype "$1")
  if [[ "$mime" = image/* ]]; then
    kitty +kitten icat "$1"
    return
  fi
  if [[ "$mime" = video/* ]]; then
    echo "video"
    mpv --vo=kitty "$1"
    return
  fi
  bat $1
}

alias cat=kitty-cat

