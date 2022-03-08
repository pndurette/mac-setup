# macOS setup

>  My macOS setup from scratch using [yadm](https://yadm.io).
> `GNU` utils, dev setup, app, configs & Mac App Store installs.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## Pre-setup

### Install `homebrew`

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### Install `yadm`

```bash
brew install yadm
# brew might not be in the path yet, in this case:
# /opt/homebrew/bin/brew install yadm # macOS Apple Silicon
# /usr/local/bin/brew install yadm    # macOS Intel
```

### Log into the Mac App Store

(for `mas`) via `App Store > Preferences > Sign in`

## Setup

### Clone and bootstrap

```bash
yadm clone https://github.com/pndurette/mac-setup.git --bootstrap # https!
```

**NB:** Bootstraping updates the remote url to ssh, so an ssh key will have to be configured after this (see below).

**NB:** There might be some need to enter the sudo password.

**NB:** Mac App Store installs will ask for a login.

## Done!

----

## Extra

### Add ssh key

Configure (new or existing) [ssh key and add it to GitHub](https://help.github.com/articles/connecting-to-github-with-ssh/), then [add key to ssh-agent and `~/.ssh/config`](https://help.github.com/articles/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent/#adding-your-ssh-key-to-the-ssh-agent). Then test:

```
ssh -T git@github.com
```

### Cheat sheet

```bash
# yadm wraps git, e.g.:
yadm status
yadm add <file>
yadm commit
yadm push
# etc

# List files under yadm control:
yadm list -a
```

See: https://yadm.io/docs/common_commands
