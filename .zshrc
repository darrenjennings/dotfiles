# Personal zsh settings shared across Macs.
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS

if [[ -d "$HOME/.local/bin" ]]; then
  path=("$HOME/.local/bin" $path)
fi

# The classic Oh My Zsh prompt, with Git branch information.
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"
plugins=(git)
zstyle ':omz:update' mode disabled
if [[ -r "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi

# fzf: fuzzy file selection, history search, and directory navigation.
fzf_dir="${XDG_DATA_HOME:-$HOME/.local/share}/fzf"
if [[ -x "$fzf_dir/bin/fzf" ]]; then
  path=("$fzf_dir/bin" $path)
  source <(fzf --zsh)
fi
unset fzf_dir

# Suggest commands from history as you type.
autosuggestions="${XDG_DATA_HOME:-$HOME/.local/share}/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh"
if [[ -r "$autosuggestions" ]]; then
  source "$autosuggestions"
fi
unset autosuggestions

# Learn frequently visited directories for `z name` and interactive `zi`.
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
