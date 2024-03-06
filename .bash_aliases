alias v='nvim'
alias src='source ~/.bashrc'
alias cfg='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias sshpi='ssh pi@80.5.39.27'
# alias python=python3
alias open=xdg-open
alias x=exit
alias tmux='tmux -2'
#alias v='vim'
# alias f=''
alias home='cd ~'
alias g='git'
alias chrome="/opt/google/chrome/google-chrome &"
alias st='git status'
alias com='git commit -a'
alias origin='git remote add origin'
alias aliases='nvim $HOME/.bash_aliases'
alias clone='git clone'
alias sth='git stash'
alias lg='git log'
alias u='git push -u origin --all'
alias push='git push -u origin master'
alias tags='git push -u origin --tags'
alias bashrc='nvim $HOME/.bashrc'
alias eclim='~/eclipse/java-2018-12/eclipse/eclimd'
alias o='xdg-open'
alias all='git add .'
alias vimrc='nvim $HOME/.config/nvim/init.vim'
alias clr='clear'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias container='make -C ~/docker/seL4-CAmkES-L4v-dockerfiles user HOST_DIR=$(pwd)'
alias buildenv='docker run -it --rm -v /scratch/seL4:/host:z \
    ghcr.io/sel4devkit/maaxboard:latest'
alias vimdiff='nvim -d'

getdate() {
    sudo date -s "$(wget --method=HEAD -qSO- --max-redirect=0 google.com 2>&1 | sed -n 's/^ *Date: *//p')"
}
# alias r='repo'
# up a directory up to 100 dirs
alias_str=".."
cmd_str="cd .."
for i in $(seq 1 100);
do
    alias ${alias_str}="$cmd_str"
    alias_str="$alias_str."
    cmd_str="$cmd_str/.."
done
