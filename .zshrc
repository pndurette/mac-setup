#!/usr/bin/env zsh

# ** Environment variables
# History
export SAVEHIST=1000 # Entries to save
export HISTSIZE=1000 # Size in Bytes
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

# Go
export GOPATH="${HOME}/.go"

# Pyenv
export PYENV_VIRTUALENV_DISABLE_PROMPT=1

# ** Init completion
# http://zsh.sourceforge.net/Doc/Release/Functions.html
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html
autoload -U compinit
compinit

# ** Completion styling
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

# ** Options
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

# ** Pyenv init
# This is plain faster than most pyenv plugins..
eval "$(pyenv init -)"

# ** PowerLevel9k theme config (font)
# Glyph font ('brew cask install font-hack-nerd-font')
# Must be set before loading PowerLevel9k
POWERLEVEL9K_MODE='nerdfont-complete'
# POWERLEVEL9K_COLOR_SCHEME="light"

# ** Antibody plugin manager (dynamic loading)
# https://getantibody.github.io/usage/
source <(antibody init)
antibody bundle < ~/.zsh_plugins.txt

# ** PowerLevel9k theme config
# Prompts
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
    context
    dir
    dir_writable
    vcs
)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
    status
    root_indicator
    background_jobs
    aws
    command_execution_time
    time
    # pyenv # too slow! see: pyup()/pydown() (below)
)

# Segment: context
# (Assume current session is of login user if $HOME ends with $USER)
if [[ $HOME =~ $USER$ ]]; then DEFAULT_USER=$USER; fi

# Segment: dir_writable
# NB: $DEFAULT_COLOR depends from $POWERLEVEL9K_COLOR_SCHEME
POWERLEVEL9K_DIR_WRITABLE_FORBIDDEN_FOREGROUND=$DEFAULT_COLOR

# Segment: command_execution_time
# NB: $DEFAULT_COLOR depends from $POWERLEVEL9K_COLOR_SCHEME
POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=3
POWERLEVEL9K_COMMAND_EXECUTION_TIME_BACKGROUND='grey50'
POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=$DEFAULT_COLOR

# # ** Key bindings
# # Up/down bindings for zsh-history-substring-search plugin
# # https://github.com/zsh-users/zsh-history-substring-search#usage
# bindkey '^[[A' history-substring-search-up      # Arrow up
# bindkey '^[[B' history-substring-search-down    # Arrow down

# ** Aliases
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
alias typora="open -a typora"
# Other
alias r="cd ~/repos"

# pyenv virtualenv-init & the penv 
# PowerLevek9k segment both slow down the shell..
# Function to enable/disable both when required.
function pyup() {
    eval "$(pyenv virtualenv-init -)"
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS+=( pyenv )
}
function pydown() {
    # 'Undo' pyenv virtualenv-init -
    export PYENV_VIRTUALENV_INIT=0
    unset _pyenv_virtualenv_hook
    unset precmd_functions
    # Remove 'pyenv' from PowerLevel9k prompt
    # 1. Clear last element (pyenv)
    # 2. Rebuild as array
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS[-1]=( '' )
    POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=( 
        $(echo $POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS)
    )
}
