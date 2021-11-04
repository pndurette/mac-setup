#!/usr/bin/env zsh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#-----------------------------------------
# ** Environment variables
#-----------------------------------------

# History
export SAVEHIST=10000 # Entries to save
export HISTSIZE=10000 # Size in Bytes
export HISTFILE=~/.zsh_history

# PATH
BREW_PREFIX=$(/usr/local/bin/brew --prefix)
PATHS=(
    # PATHs for gnu brew binaries
    $BREW_PREFIX/opt/coreutils/libexec/gnubin
    $BREW_PREFIX/opt/findutils/libexec/gnubin
    $BREW_PREFIX/opt/gnu-sed/libexec/gnubin
    $BREW_PREFIX/opt/gnu-tar/libexec/gnubin
    $BREW_PREFIX/opt/gnu-which/libexec/gnubin
    $BREW_PREFIX/opt/grep/libexec/gnubin
    # PATH for other brew binaries
    $BREW_PREFIX/bin
    $BREW_PREFIX/sbin
    # PATH for pipsi
    # https://github.com/mitsuhiko/pipsi
    $HOME/.local/bin
)
# NB: 'j' flag: join PATHS by ':'' (see: man zshexpn)
export PATH=${(j[:])PATHS}:$PATH 

# gpg
# https://github.com/Homebrew/homebrew-core/issues/14737#issuecomment-309848851
export GPG_TTY=$(tty)

# Go
export GOPATH="${HOME}/.go"

# Pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# Google Cloud SDK (to force Python 3)
# https://cloud.google.com/sdk/gcloud/reference/topic/startup
# 'python3' is a shim created by Pyenv
if type python3 > /dev/null; then
    export CLOUDSDK_PYTHON=python3
    export CLOUDSDK_GSUTIL_PYTHON=python3
    export CLOUDSDK_BQ_PYTHON=python3
fi

#-----------------------------------------
# ** Zsh options
#-----------------------------------------

# http://zsh.sourceforge.net/Doc/Release/Options.html
setopt AUTO_CD
# setopt CORRECT_ALL
setopt APPEND_HISTORY
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt NOTIFY
setopt CHECK_JOBS
setopt INTERACTIVE_COMMENTS
setopt ALWAYS_TO_END

#-----------------------------------------
# ** Completion styling
#-----------------------------------------

# https://unix.stackexchange.com/a/214699
# Do menu-driven completion.
zstyle ':completion:*' menu select
# Color completion for some things.
# http://linuxshellaccount.blogspot.com/2008/12/color-completion-using-zsh-modules-on.html
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# Formatting and messages
# http://www.masterzen.fr/2009/04/19/in-love-with-zsh-part-one/
zstyle ':completion:*' verbose yes
zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''
# Enable approximate matches for completion
# https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
zstyle ':completion:::::' completer _expand _complete _ignored _approximate 

#-----------------------------------------
# ** Pyenv init
#-----------------------------------------

# This is plain faster than most pyenv plugins..
eval "$(pyenv init -)"

#-----------------------------------------
# ** Zsh plugins
#-----------------------------------------

# 1. Antibody plugin manager init (dynamic loading)
# https://getantibody.github.io/usage/
source <(antibody init)
# 1.1. OMZ sets ZSH_CACHE and some of its plugins expect it
# (set it to Antibody's home which is a cache)
export ZSH_CACHE_DIR="$(antibody home)"

# 2. Plugin: zsh-lux. Provides 'macos_is_dark', 'lux'
antibody bundle pndurette/zsh-lux
# antibody bundle pndurette/zsh-lux branch:v0.0.1 # specify ref
# antibody bundle /Users/pndurette/repos/zsh-lux kind:zsh # dev

# 3. Theme: PowerLevel9k
# 3.1. Font pre-config ('brew cask install font-hack-nerd-font')
# 3.2. Color/theme pre-config
# TODO: color schemes don't seem to exist in PowerLevel10k
if macos_is_dark; then
    POWERLEVEL9K_COLOR_SCHEME="dark"
    lux iterm dark
else
    POWERLEVEL9K_COLOR_SCHEME="light"
    lux iterm light
fi
# 3.3. Load PowerLevel10k
antibody bundle romkatv/powerlevel10k

# 4. Load remaining plugins
antibody bundle < ~/.zsh_plugins.txt

#-----------------------------------------
# ** Init completion
#-----------------------------------------

# (After plugins to load their completion functions in the $fpath)
# http://zsh.sourceforge.net/Doc/Release/Functions.html
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html
autoload -U compinit
compinit

#-----------------------------------------
# ** Zsh plugins (that require compinit)
#-----------------------------------------

# In awscli's 'aws_zsh_completer.sh', compinit is assumed
antibody bundle robbyrussell/oh-my-zsh path:plugins/aws
antibody bundle robbyrussell/oh-my-zsh path:plugins/kubectl

#-----------------------------------------
# ** Extra autocomplete & misc. sourcing
#-----------------------------------------

# azure-cli auto-complete via bash compatibility
# https://github.com/Azure/azure-cli/issues/1722
if [ -f "$BREW_PREFIX/etc/bash_completion.d/az" ]; then
    source $BREW_PREFIX/etc/bash_completion.d/az
fi

# google-cloud-sdk auto-complete from brew cask
# https://formulae.brew.sh/cask/google-cloud-sdk (caveats)
if [ -d "$BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/" ]; then
    # export CLOUDSDK_PYTHON=$BREW_PREFIX/opt/python@3.8/libexec/bin/python
    source $BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/path.zsh.inc
    source $BREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# terraform auto-complete
# https://www.terraform.io/docs/commands/index.html#shell-tab-completion
if [ -f "$BREW_PREFIX/bin/terraform" ]; then
    autoload -U +X bashcompinit && bashcompinit
    complete -o nospace -C /usr/local/bin/terraform terraform
fi

#-----------------------------------------
# ** Key bindings
#-----------------------------------------

# # Up/down bindings for zsh-history-substring-search plugin
# # https://github.com/zsh-users/zsh-history-substring-search#usage
# bindkey '^[[A' history-substring-search-up      # Arrow up
# bindkey '^[[B' history-substring-search-down    # Arrow down

#-----------------------------------------
# ** Aliases
#-----------------------------------------

# Disable autocorrect
alias mv='nocorrect mv'
alias cp='nocorrect cp'
alias rm='nocorrect rm'
alias mkdir='nocorrect mkdir'
# Colour!
alias ls='ls --color=auto'
alias ll='ls --color=auto -lah'
alias grep='grep --colour=auto'
# Human readable
alias df='df -h'
alias du='du -h'
# Apps
alias typora='open -a typora'
# Lux
alias lumos='lux all light'
alias nox='lux all dark'
# Other
alias r='cd ~/repos'

#-----------------------------------------
# ** PowerLevel10k theme config
#-----------------------------------------

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Prompts
# (see .p10k.zsh)

# Segment: command_execution_time
# NB: $DEFAULT_COLOR depends from $POWERLEVEL9K_COLOR_SCHEME
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='grey50'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$DEFAULT_COLOR