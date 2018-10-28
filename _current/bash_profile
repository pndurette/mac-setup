# PATH for brew coreutils & co.
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"

# PATH for pipsi
# https://github.com/mitsuhiko/pipsi
export PATH="$HOME/.local/bin:$PATH"

# PATH etc. for rbenv
# brew install rbenv
eval "$(rbenv init -)"

# Paths for GO
export GOPATH="${HOME}/.go"

# bash completion
# brew install bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
    source $(brew --prefix)/etc/bash_completion
fi

# .bashrc
if [ -f $HOME/.bashrc ]; then
    source $HOME/.bashrc
fi
