alias n='nvim'
alias src='source ~/.zshrc'
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias cfglazy='lazygit --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias open=xdg-open
alias x=exit
alias tmux='tmux -2'
alias t='tmux -2'
alias v='vim'
alias f='fdfind'
alias home='cd ~'
alias bashrc='nvim $HOME/.bashrc'
alias o='xdg-open'
alias all='git add .'
alias vimrc='nvim $HOME/.config/nvim'
alias clr='clear'
alias c='clear'

# exa
alias ll='exa -lF'
alias la='exa -aF'
alias lal='exa -alF'
alias l='exa -uF'
alias vimdiff='nvim -d'
alias aliases='nvim $HOME/.bash_aliases'

# git
alias g='git'
alias st='git status'
alias com='git commit -a'
alias origin='git remote add origin'
alias clone='git clone'
alias sth='git stash'
alias lg='lazygit'
alias u='git push -u origin --all'
alias push='git push -u origin master'
alias tags='git push -u origin --tags'

# note taking
alias oo="cd $HOME/notes"
alias or="nvim $HOME/notes/inbox/*.md"
alias ot="nvim $HOME/notes/todos/$(date +%d-%m-%Y).md"

getdate() {
    sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | sed -n 's/^ *Date: *//p')"
}

# up a directory up to 100 dirs
alias_str=".."
cmd_str="cd .."
for i in $(seq 1 100);
do
    alias ${alias_str}="$cmd_str"
    alias_str="$alias_str."
    cmd_str="$cmd_str/.."
done
