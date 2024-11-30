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

set -gx PATH /opt/homebrew/bin $PATH

set fish_greeting

alias vim="nvim"
alias g="git"

# Highlight matches if output to shell
alias grep="grep --color=auto"
# Better match highlight color
set -x GREP_COLOR "0;30;43"

set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"

# Use `less` as the default viewer for multi-page output
set -x PAGER "less"

# Output ANSI control/color sequences
set -x LESS "--RAW-CONTROL-CHARS"

set -x EDITOR "nvim"

set -U __done_min_cmd_duration 20000

# Use current terminal to request password for GPG key
set -x PINENTRY_USER_DATA "USE_CURSES=1"
# Ensure pinentry program displays to the correct terminal
set -x GPG_TTY "$(tty)"
set -x GNUPGHOME "$HOME/.gnupg"

set -x FZF_DEFAULT_COMMAND "fd --hidden --no-ignore --exclude .git --exclude node_modules --type file"

if which gpgconf >/dev/null 2>&1
  if not pgrep gpg-agent >/dev/null
    gpgconf --launch gpg-agent
  end

  set -x SSH_AUTH_SOCK "$(gpgconf --list-dirs agent-ssh-socket)"
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

fish_add_path /opt/homebrew/opt/curl/bin
fish_add_path /opt/homebrew/opt/coreutils/libexec/gnubin
fish_add_path "$HOME/.files/git-helpers"

# Load any local configuration, if any
if test -e "$HOME/.config/fish/local.fish"
  source "$HOME/.config/fish/local.fish"
end
