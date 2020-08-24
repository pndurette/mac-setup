# .vscode-conf

Directory I use to keep the VSCode configs in dotfile reach.

### User settings

The following symlinks are required (done in `~/.config/yadm/bootstrap`):
```bash
ln -s $HOME/.vscode-conf/settings.json    "$HOME/Library/Application Support/Code/User/settings.json"
ln -s $HOME/.vscode-conf/keybindings.json "$HOME/Library/Application Support/Code/User/keybindings.json"
ln -s $HOME/.vscode-conf/snippets/        "$HOME/Library/Application Support/Code/User/snippets"
```

See:
* https://code.visualstudio.com/docs/getstarted/settings
* https://pawelgrzybek.com/sync-vscode-settings-and-snippets-via-dotfiles-on-github/

### Extensions

Generate extension list:

```bash
code --list-extensions > $HOME/.vscode-conf/vscode-extensions.txt
```

Install extensions  (done in `~/.config/yadm/bootstrap`):

```bash
for ext in $(cat $HOME/.vscode-conf/vscode-extensions.txt); do
  code --install-extension "$ext"
done
```
