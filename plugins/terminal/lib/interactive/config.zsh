bindkey -e # Use emacs key bindings

bindkey ' ' magic-space # Expands "!!" and other such shortcuts on space

# Allow searching through previous commands that match the current prefix
bindkey -M emacs '^P' history-substring-search-up
bindkey -M emacs '^N' history-substring-search-down

# Customize appearance
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2 eval "$(/opt/homebrew/bin/gdircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false # Disable old completion system

# Initialize syntax highlighting
source $DOT_PLUGIN_DIR/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# Allow for searching through previous commands matching a given substring
# (i.e. you type a bit of the command and then cycle with Ctrl-P/N)
source $DOT_PLUGIN_DIR/zsh-history-substring-search/zsh-history-substring-search.zsh

# Add a large library of completions that aren't in upstream zsh completions yet
fpath=($DOT_PLUGIN_DIR/zsh-completions/src $fpath)

# Initialize completion system now that all completions are in $fpath
autoload -U compinit
compinit -u
