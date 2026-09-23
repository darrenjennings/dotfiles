# Dotfiles

Small, portable settings for a new Mac.

## Install

Run `./install.sh` from this directory. The script links `.zshrc` and
`.gitconfig` into your home directory, backs up any existing files first, and
installs fzf and zsh-autosuggestions. It requires Git and an internet connection.
It does not touch `.zprofile`, which this Mac uses to add Codex to `PATH`.

fzf adds `Ctrl-R` history search, `Ctrl-T` file selection, and `Alt-C` directory
navigation. Autosuggestions appear as you type; press the right arrow to accept
one. Open a new terminal after installation.

After installing, set your Git identity in a separate, untracked file:

```sh
git config --file "$HOME/.gitconfig.local" user.name "Your Name"
git config --file "$HOME/.gitconfig.local" user.email "you@example.com"
```

Keep passwords, tokens, SSH keys, and machine-specific settings out of this
repository.
