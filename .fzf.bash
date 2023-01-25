# Setup fzf
# ---------
if [[ ! "$PATH" == */home/jfelmeden/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/jfelmeden/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/jfelmeden/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/jfelmeden/.fzf/shell/key-bindings.bash"
