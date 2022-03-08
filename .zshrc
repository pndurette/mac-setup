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

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# PATH
PATHS=(
    # PATHs for gnu brew binaries
    # $HOMEBREW_PREFIX is set by the above eval
    $HOMEBREW_PREFIX/opt/coreutils/libexec/gnubin
    $HOMEBREW_PREFIX/opt/findutils/libexec/gnubin
    $HOMEBREW_PREFIX/opt/gnu-sed/libexec/gnubin
    $HOMEBREW_PREFIX/opt/gnu-tar/libexec/gnubin
    $HOMEBREW_PREFIX/opt/gnu-which/libexec/gnubin
    $HOMEBREW_PREFIX/opt/grep/libexec/gnubin
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
# Disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false
# Enable approximate matches for completion
# https://blog.callstack.io/supercharge-your-terminal-with-zsh-8b369d689770
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

#-----------------------------------------
# ** Zsh plugins
#-----------------------------------------

# Install zgenom (plugin manager)
# https://github.com/jandamm/zgenom
if [[ ! -f "${HOME}/.zgenom/zgenom.zsh" ]]; then
  git clone https://github.com/jandamm/zgenom.git "${HOME}/.zgenom"
fi

# Load zgenom
source "${HOME}/.zgenom/zgenom.zsh"

# Check for plugin and zgenom updates every 7 days
# This does not increase the startup time.
zgenom autoupdate

# if the init script doesn't exist
if ! zgenom saved; then
    # Plugin: zsh-lux. Provides 'macos_is_dark', 'lux'
    zgenom load pndurette/zsh-lux
    # zgenom load ~/repos/zsh-lux # dev

    # Theme: PowerLevel10k
    # https://github.com/romkatv/powerlevel10k
    # (see 'zgen' install)
    zgenom load romkatv/powerlevel10k powerlevel10k

    # General plugins
    zgenom load greymd/docker-zsh-completion

    # Save all to init script
    zgenom save

    # Compile your zsh files
    zgenom compile "$HOME/.zshrc"
fi

# Re-style iTerm to match macOS appearance
if macos_is_dark; then
    lux iterm dark
else
    lux iterm light
fi

#-----------------------------------------
# ** Init completion
#-----------------------------------------

# Add Homebrew-installed completions to the $fpath
FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

# (After plugins to load their completion functions in the $fpath)
# http://zsh.sourceforge.net/Doc/Release/Functions.html
# http://zsh.sourceforge.net/Doc/Release/Completion-System.html
autoload -U compinit
compinit

#-----------------------------------------
# ** Zsh plugins (that require compinit)
#-----------------------------------------

zgenom load Aloxaf/fzf-tab # Need to be after compinit but before wrap widgets
zgenom load joshskidmore/zsh-fzf-history-search
zgenom load zdharma-continuum/fast-syntax-highlighting
zgenom load zsh-users/zsh-autosuggestions

#-----------------------------------------
# ** Extra autocomplete & misc. sourcing
#-----------------------------------------

# Enable bash completion in zsh (az, gcloud, ...)
autoload -U +X bashcompinit && bashcompinit

# azure-cli auto-complete via bash compatibility
# https://github.com/Azure/azure-cli/issues/1722
if [ -f "$HOMEBREW_PREFIX/etc/bash_completion.d/az" ]; then
    source $HOMEBREW_PREFIX/etc/bash_completion.d/az
fi

# google-cloud-sdk auto-complete from brew cask
# https://formulae.brew.sh/cask/google-cloud-sdk (caveats)
if [ -d "$HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/" ]; then
    source $HOMEBREW_PREFIX/Caskroom/google-cloud-sdk/latest/google-cloud-sdk/completion.zsh.inc
fi

# terraform auto-complete
# https://www.terraform.io/docs/commands/index.html#shell-tab-completion
if [ -f "$HOMEBREW_PREFIX/bin/terraform" ]; then
    # What the output of 'terraform -install-autocomplete' adds to .zshrc
    complete -o nospace -C /opt/homebrew/bin/terraform terraform
fi

# pyenv
# https://github.com/pyenv/pyenv#advanced-configuration
eval "$(pyenv init -)"
eval "$(pyenv init --path)"

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
# alias ll='ls --color=auto -lah'
alias grep='grep --colour=auto'
# Exa
alias ll='exa -l -g -h --icons --all --all --octal-permissions --time-style long-iso'
# Human readable
alias df='df -h'
alias du='du -h'
# Apps
alias typora='open -a typora'
# Lux
alias lumos='lux all light'
alias nox='lux all dark'
# Other
if [ -d "$HOME/repos/work" ]; then
    alias r='cd ~/repos/work'
else
    alias r='cd ~/repos'
fi

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
