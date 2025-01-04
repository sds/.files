###############################################################################
# Initialize XDG base directory environment variables as defined in:
# https://specifications.freedesktop.org/basedir-spec/basedir-spec-0.6.html.
#
# Explicitly define them here so we don't need to add the additional code of
# handling the case where they are not explicitly defined, simplifying the code
# in the rest of our configurations which use XDG.

# Directory where user-specific data files should be stored.
export XDG_DATA_HOME="$HOME/.local/share"
# Preference-ordered set of base directories to search for data files in
# addition to the $XDG_DATA_HOME base directory.
export XDG_DATA_DIRS="/usr/local/share/:/usr/share/"
# Directory where user-specific configuration files should be stored.
export XDG_CONFIG_HOME="$HOME/.config"
# Preference-ordered set of base directories to search for configuration files
# in addition to the $XDG_CONFIG_HOME base directory.
export XDG_CONFIG_DIRS="/etc/xdg"
# Directory where user-specific non-essential data files should be stored.
export XDG_CACHE_HOME="$HOME/.cache"

###############################################################################
# Update PATH with helpful utilities

fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/opt/curl/bin # Not installed in default brew bin dir

fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin # Use GNU core utils (`ls` etc) instead of macOS ones
fish_add_path "$HOME/.files/git-helpers"

fish_add_path "$HOME/.asdf/shims" # Ensure this gets preference

###############################################################################

set fish_greeting

alias vim="nvim"
alias g="git"

alias grep="grep --color=auto"  # Highlight matches if output to shell
set -x GREP_COLOR "0;30;43"     # Better match highlight color

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Use `less` as the default viewer for multi-page output
set -x PAGER "less"

# Output ANSI control/color sequences
set -x LESS "--RAW-CONTROL-CHARS"

set -x EDITOR "nvim"

set -x FZF_DEFAULT_COMMAND "fd --no-ignore --hidden --exclude node_modules"

if which gpgconf >/dev/null 2>&1
  if not pgrep gpg-agent >/dev/null
    gpgconf --launch gpg-agent
  end

  set -x SSH_AUTH_SOCK "$(gpgconf --list-dirs agent-ssh-socket)"

  # Ensure pinentry program displays to the correct terminal
  set -x GPG_TTY "$(tty)"
  set -x GNUPGHOME "$HOME/.gnupg"
  gpg-connect-agent updatestartuptty /bye >/dev/null
else
  echo "Skipping GPG setup since it is not yet installed."
end

function tmux -d "Start tmux session or connect to an existing session based on the current working directory"
  if test $(count "$argv") -le 1
    set session_name "$(basename $(pwd))"

    # Attach to session with the current directory name if one exists,
    # otherwise automatically create a session with the current directory name
    command tmux new -A -s $session_name
  else
    # Otherwise just forward along the arguments given
    command tmux $argv
  end
end

# Load any local configuration, if any
if test -e "$HOME/.config/fish/local.fish"
  source "$HOME/.config/fish/local.fish"
end
