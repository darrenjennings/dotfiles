# Dotfiles

Small, portable settings for a new Mac.

## Install

Run `./install.sh` from this directory. The script links `.zshrc` and
`.gitconfig` into your home directory and backs up any existing files first.
It does not touch `.zprofile`, which this Mac uses to add Codex to `PATH`.

After installing, set your Git identity in a separate, untracked file:

```sh
git config --file "$HOME/.gitconfig.local" user.name "Your Name"
git config --file "$HOME/.gitconfig.local" user.email "you@example.com"
```

Keep passwords, tokens, SSH keys, and machine-specific settings out of this
repository.
