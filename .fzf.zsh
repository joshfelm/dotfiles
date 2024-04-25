# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jfelmeden/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/jfelmeden/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jfelmeden/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.fzf/shell/key-bindings.zsh"
