# macOS setup

My macOS setup from scratch (clean install). My `dotfiles`, `GNU` utils, dev setup, apps and Mac App Store installs.

## Pre-setup

### Install `homebrew`

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Install iTerm2

```
brew cask install iterm2
# Then switch to it!
```

### Install git (and configure)

```bash
brew install git
git config --global user.name "<name as it appears on GitHub>"
git config --global user.email "<email as it appears on GitHub>"
```

Configure (new or existing) [ssh key and add it to GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/), then [add key to ssh-agent and `~/.ssh/config`](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent). Then test:

```
ssh -T git@github.com
```

### Clone

```bash
mkdir ~/repos/ && cd ~/repos/
git clone git@github.com:pndurette/mac-setup.git
cd mac-setup
```

### Install Mac App Store (`mas`) cli (and login)

```bash
brew install mas
mas signin --dialog <Apple ID email>
# ^ Broken in 10.13+. Will say to sign in to App Store the standard way
```

## Setup

### Install tools & apps

```
brew bundle install
```

**NB:** There might be some need to enter the sudo password at some point
**NB:** Some installs might require some approvals in `System Preferences → Security & Privacy → General`. They will fail at first. Approve them, then rerun `brew bundle install`

### Symlink `dotfiles`

```bash
# make_links.sh uses gnu ln which is not yet in the PATH
export PATH="$(brew --prefix coreutils)/libexec/gnubin:/usr/local/bin:$PATH"
# Creates a ~/.<item> symlink to every <item> in _current
./make_links.sh # re-run with --yes to confirm
```

Then start a new terminal window to load everything. Voilà!