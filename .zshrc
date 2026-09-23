# Personal zsh settings shared across Macs.
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS

if [[ -d "$HOME/.local/bin" ]]; then
  path=("$HOME/.local/bin" $path)
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

# A compact prompt with the current directory and Git state.
if (( $+commands[starship] )); then
  eval "$(starship init zsh)"
fi

# Learn frequently visited directories for `z name` and interactive `zi`.
if (( $+commands[zoxide] )); then
  eval "$(zoxide init zsh)"
fi
