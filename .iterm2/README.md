# .iterm2

Custom preferences directory for iTerm2.

Configure iTerm2 to use it (done in `~/.config/yadm/bootstrap`):

```bash
defaults write com.googlecode.iterm2 PrefsCustomFolder "$HOME/.iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true
```

