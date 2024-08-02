# If you come from bash you might have to change your $PATH.
export RUSTUP_HOME='/opt/rust'
export PATH="$PATH:/opt/rust/bin"
export PATH=$HOME/bin:/usr/local/bin:$HOME/.local/bin$PATH
export PATH=/home/linuxbrew/.linuxbrew/bin:$PATH
export PATH=$HOME/.cargo/bin:$PATH
export PATH="$HOME/.local/share/nvim/distant.nvim/bin/:$PATH"
export PATH="/opt/nvim-linux64/bin:$PATH"
export DENO_INSTALL="/home/jfelmeden/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"
export FZF_BASE="$HOME/.fzf"
export TERM=screen-256color

nerdfetch

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# nvidia
# export WLR_DRM_DEVICES=/dev/dri/card0:/dev/dri/card1
# export WLR_RENDERER=vulkan

# yocto variables
SSH_AUTH_SOCK=/ssh.socket
TEGRA_KEYDIR=/build/ornx-keys
BB_NUMBER_THREADS=8
PARALLEL_MAKE=\ -j\ 10


# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

# list of plugins
plugins=(
  dotenv
  fd
  fzf
  git
  ripgrep
  ssh-agent
  tmux
  z
  zsh-autosuggestions
  zsh-syntax-highlighting
)

# add ssh to path
zstyle :omz:plugins:ssh-agent quiet yes
zstyle :omz:plugins:ssh-agent lazy yes
zstyle :omz:plugins:ssh-agent helper ksshaskpass
zstyle :omz:plugins:ssh-agent identities github-office

# autosuggestion settings
ZSH_AUTOSUGGEST_STRATEGY="history"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
# ZSH_THEME="gruvbox"
ZSH_THEME="powerlevel10k/powerlevel10k"
SOLARIZED_THEME="dark"
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk||kj

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="dd.mm.yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=$ZSH/custom

# source aliases and oh my zsh
[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh
[ -f ~/.aliases ] && source $HOME/.aliases
[ -f ~/.bash_aliases ] && source $HOME/.bash_aliases


# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# Don't allow tmux to share history
setopt nosharehistory

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='nvim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Enable custom fzf zsh commands
source $HOME/.fzf_zsh

alias zshrc="nvim $HOME/.zshrc"
alias ohmyzsh="cd ~/.oh-my-zsh"
alias src="source $HOME/.zshrc"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
