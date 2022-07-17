# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

## custom variables to determine which settings to use (defaults presume we're using homebrew on Linux)
__ZSH="$HOME/.oh-my-zsh/"
__ZSH_SYNTAX_HIGHLIGHTING="/home/linuxbrew/.linuxbrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Change config for macOS.
if [[ "$(uname)" == "Darwin" ]]; then
	# Custom definitions.
	__ZSH="/Users/$(whoami)/.oh-my-zsh"
	__ZSH_SYNTAX_HIGHLIGHTING="/opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

	# OS definitions.
	# Use gnu utils instead of macOS/BSD.
	PATH="/opt/homebrew/opt/coreutils/libexec/gnubin:$PATH"
	# Add grc.
	FPATH="/opt/homebrew/share/zsh/site-functions/_grc:/opt/homebrew/share/zsh/site-functions/_gh:$FPATH"
fi

# Path to your oh-my-zsh installation.
export ZSH="${__ZSH}"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
	mkdir $ZSH_CACHE_DIR
fi

# default os exports
export TERM=xterm
export EDITOR=nvim
export CLICOLOR=1

## fzf
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_SAVE_NO_DUPS
export FZF_BASE="$(which fzf)"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	dircycle
	colored-man-pages
	extract
	fzf
	grc
	git
	npm
	yarn
)

source $ZSH/oh-my-zsh.sh
source $__ZSH_SYNTAX_HIGHLIGHTING

## aliases and environment variables
[[ -f "${HOME}/.config/aliases" ]] && source "${HOME}/.config/aliases"
[[ -f "${HOME}/.config/aliases.private" ]] && source "${HOME}/.config/aliases.private"
[[ -f "${HOME}/.config/env.private" ]] && source "${HOME}/.config/env.private"

## grc
# ls alias needed for grc to highlight dir listings correctly https://github.com/garabik/grc/issues/36
alias ls="grc --colour=auto ls --color=always"

## Hooks
autoload -U add-zsh-hook
autoload bashcompinit
bashcompinit

## Starship
export STARSHIP_CONFIG=~/.config/starship/starship.toml
export STARSHIP_SHELL=zsh

## autocompletion
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

eval "$(starship init zsh)"

# fnm
export PATH=/home/me/.fnm:$PATH
eval "$(fnm env --use-on-cd)"
