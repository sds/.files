# Disable activating fzf autocompletion via TAB since in some contexts (e.g.
# completing a file name in the current directory) it is overkill. Explicit
# Ctrl-T is our preferred activation mechanism.
# https://github.com/junegunn/fzf/wiki/Configuring-fuzzy-completion#caveats
setopt vi

source "/opt/homebrew/opt/fzf/shell/completion.zsh"
source "/opt/homebrew/opt/fzf/shell/key-bindings.zsh"

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}
