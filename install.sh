#!/bin/sh
set -eu

repo_dir=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

link_file() {
  source_file=$1
  target_file=$2

  if [ -L "$target_file" ] && [ "$(readlink "$target_file")" = "$source_file" ]; then
    printf '%s is already linked\n' "$target_file"
    return 0
  fi

  if [ -e "$target_file" ] || [ -L "$target_file" ]; then
    backup_file="$target_file.backup.$(date +%Y%m%d%H%M%S)"
    mv "$target_file" "$backup_file"
    printf 'Backed up %s to %s\n' "$target_file" "$backup_file"
  fi

  ln -s "$source_file" "$target_file"
  printf 'Linked %s to %s\n' "$target_file" "$source_file"
}

link_file "$repo_dir/.zshrc" "$HOME/.zshrc"
link_file "$repo_dir/.gitconfig" "$HOME/.gitconfig"
link_file "$repo_dir/.vimrc" "$HOME/.vimrc"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
  git clone --depth 1 https://github.com/ohmyzsh/ohmyzsh.git "$HOME/.oh-my-zsh"
fi

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

if [ ! -x "$HOME/.local/bin/zoxide" ]; then
  mkdir -p "$HOME/.local/bin"
  case $(uname -m) in
    arm64)
      zoxide_arch=aarch64-apple-darwin
      zoxide_sha=b55ae6f2f5f23d0a6ccb3bd4eeb2af9c7e0a6556e5255c82100e40305129bbb0
      ;;
    x86_64)
      zoxide_arch=x86_64-apple-darwin
      zoxide_sha=18ab7ae2633ad6e2ab79a4e665cbba1e95b7c872d44523326efb793202451dad
      ;;
    *)
      printf 'Unsupported Mac architecture for zoxide: %s\n' "$(uname -m)" >&2
      exit 1
      ;;
  esac
  archive=$(mktemp)
  curl -fsSL "https://github.com/ajeetdsouza/zoxide/releases/download/v0.10.0/zoxide-0.10.0-$zoxide_arch.tar.gz" -o "$archive"
  actual_sha=$(shasum -a 256 "$archive" | awk '{print $1}')
  if [ "$actual_sha" != "$zoxide_sha" ]; then
    printf 'zoxide download checksum did not match\n' >&2
    exit 1
  fi
  tar -xzf "$archive" -C "$HOME/.local/bin" zoxide
  rm -f "$archive"
fi
