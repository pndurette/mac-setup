# Based on:
# https://www.taniarascia.com/setting-up-a-brand-new-mac-for-development/
# https://danielmiessler.com/blog/first-10-things-new-mac/
# https://hackercodex.com/guide/python-development-environment-on-mac-osx/
# See homebrew-bundle:
# https://github.com/Homebrew/homebrew-bundle

# Command-Line Mac App Store
# NB: 'brew install mas && mas signin <email>'
mas '1Password 7', id: 1333542190
mas 'Slack', id: 803453959
mas 'Bear', id: 1091189122
mas 'Monodraw', id: 920404675
mas 'Pages', id: 409201541
mas 'Numbers', id: 409203825
mas 'Keynote', id: 409183694

# Cask macOS apps
cask 'typora'
cask 'google-chrome'
cask 'firefox'
cask 'authy'

# Make macOS more linux-y
brew 'findutils', args: ['default-names']
brew 'gnu-sed', args: ['default-names']
brew 'gnu-tar', args: ['default-names']
brew 'gnu-which', args: ['default-names']
brew 'gnutls', args: ['default-names']
brew 'grep', args: ['default-names']
brew 'coreutils'
brew 'binutils'
brew 'diffutils'
brew 'gzip'
brew 'watch'
brew 'tmux'
brew 'wget'
brew 'nmap'
brew 'gpg'
brew 'htop'

# Dev
brew 'git'
brew 'jq'

# Dev/Cloud
brew 'awscli'

# Dev/Apps
cask 'visual-studio-code'

# Dev/Docker
cask 'docker'

# Dev/Vagrant/VirtualBox
cask 'vagrant'
# This might trigger a macOS security alert.
# Will have to be allowed (in System Preferences)
# and re-run. Virtualbox adds its network interface.
cask 'virtualbox'

# Dev/Python
# a) virtualenv way:
# PIP_REQUIRE_VIRTUALENV="false" pip install virtualenv
# PIP_REQUIRE_VIRTUALENV="false" pip3 install virtualenv
# virtualenv -p python <name> # or:
# virtualenv -p python3 <name>
# b) pyenv way:
# pyenv install <python version>
# pyenv virtualenv <python version> <name>
brew 'python@2' # 2.7
brew 'python' # 3
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
cask 'homebrew/cask-versions/java8'
