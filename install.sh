#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

for name in .zshrc .gitconfig; do
  source_file="$repo_dir/$name"
  target_file="$HOME/$name"

  if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
    printf '%s is already linked\n' "$target_file"
    continue
  fi

  if [ -e "$target_file" ] || [ -L "$target_file" ]; then
    backup_file="$target_file.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_file" "$backup_file"
    printf 'Backed up %s to %s\n' "$target_file" "$backup_file"
  fi

  ln -s "$source_file" "$target_file"
  printf 'Linked %s to %s\n' "$target_file" "$source_file"
done

data_dir=${XDG_DATA_HOME:-$HOME/.local/share}
fzf_dir="$data_dir/fzf"
autosuggestions_dir="$data_dir/zsh/plugins/zsh-autosuggestions"

mkdir -p "$data_dir/zsh/plugins"
if [ ! -d "$fzf_dir" ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git "$fzf_dir"
fi
if [ ! -x "$fzf_dir/bin/fzf" ]; then
  "$fzf_dir/install" --bin
fi

if [ ! -d "$autosuggestions_dir" ]; then
  git clone --depth 1 https://github.com/zsh-users/zsh-autosuggestions.git "$autosuggestions_dir"
fi
