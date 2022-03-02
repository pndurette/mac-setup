# Based on:
# https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/
# https://danielmiessler.com/blog/first-10-things-new-mac/
# https://hackercodex.com/guide/python-development-environment-on-mac-osx/
# See homebrew-bundle:
# https://github.com/Homebrew/homebrew-bundle

# Command-Line Mac App Store
# NB: Sign in the macOS App Store beforehand
brew 'mas'
mas '1Password 7', id: 1333542190
mas 'Slack', id: 803453959
# mas 'Telegram', id: 747648890
mas 'Bear', id: 1091189122
mas 'Monodraw', id: 920404675
mas 'Pages', id: 409201541
mas 'Numbers', id: 409203825
mas 'Keynote', id: 409183694
mas 'Parcel', id: 639968404
mas 'Microsoft Remote Desktop 10', id: 1295203466
mas 'Moom', id: 419330170
# mas 'Affinity Designer', id: 824171161
# mas 'Affinity Photo', id: 824183456

# Cask macOS apps
cask 'iterm2'
cask 'typora'
cask 'chromium'
cask 'firefox'
cask 'authy'
# cask 'prusaslicer'
cask 'microsoft-teams'
cask 'zoom'

# Cask macOS utils
cask 'appcleaner'
cask 'balenaetcher'
cask 'the-unarchiver'
cask 'geekbench'

# Make macOS more linux-y
brew 'findutils'
brew 'gnu-sed'
brew 'gnu-tar'
brew 'gnu-which'
brew 'gnutls'
brew 'grep'
brew 'coreutils'
brew 'binutils'
brew 'diffutils'
brew 'gzip'
brew 'watch'
brew 'tmux'
brew 'wget'

# More utils
brew 'nmap'
brew 'gpg'
brew 'htop'
brew 'tree'
brew 'fzf'
brew 'bat'
brew 'exa'

# Zsh
brew 'zsh'
brew 'antibody'
tap 'homebrew/cask-fonts'
cask 'font-meslo-lg-nerd-font'

# Dev
brew 'git'
brew 'jq'

# Dev/Cloud
brew 'awscli'
cask 'google-cloud-sdk'
brew 'azure-cli'

# HashiCorp
tap 'hashicorp/tap'
brew 'hashicorp/tap/terraform'
brew 'hashicorp/tap/vault'
brew 'hashicorp/tap/consul'
brew 'hashicorp/tap/nomad'

# Dev/Apps
cask 'visual-studio-code'

# Dev/Containers
brew 'kubernetes-cli' # i.e. kubectl
brew 'kubernetes-helm'
cask 'docker'

# Dev/Vagrant/Virtualization
# cask 'vagrant'
# Virtualization will trigger a macOS security alert
# as they often add their own network interfaces.
# Will have to be allowed (in System Preferences) and re-run.
# cask 'virtualbox'
# cask 'multipass'

# Dev/Python
# a) virtualenv way:
# PIP_REQUIRE_VIRTUALENV="false" pip install virtualenv
# PIP_REQUIRE_VIRTUALENV="false" pip3 install virtualenv
# virtualenv -p python <name> # or:
# virtualenv -p python3 <name>
# b) pyenv way:
# pyenv install <python version>
# pyenv virtualenv <python version> <name>
brew 'python'
brew 'pyenv'
brew 'pyenv-virtualenv'

# Dev/Ruby
# https://github.com/rbenv/rbenv#command-reference
# rbenv init
# rbenv install <version>
# echo '<version>' > .ruby-version
# gem install bundler
brew 'rbenv'

# Java 8 (JRE)
# cask 'homebrew/cask-versions/java8'

# Misc
brew 'screenfetch'
brew 'peco'
