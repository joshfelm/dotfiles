# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jfelmeden/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/jfelmeden/.fzf/bin"
fi

source <(fzf --zsh)
