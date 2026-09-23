# Personal zsh settings shared across Macs.
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS

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
