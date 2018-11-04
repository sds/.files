tmux () {
  # Symlink auth socket so that when we reconnect we can point to the newer
  # socket by just updating the symlink. Saves us from having to manually reset
  # SSH_AUTH_SOCK using `ssh-reagent` or similar.
  SOCK_SYMLINK=~/.ssh/tmux_ssh_auth_sock
  if [ -r "$SSH_AUTH_SOCK" ]; then
    rm -f $SOCK_SYMLINK && ln -s $SSH_AUTH_SOCK $SOCK_SYMLINK
    tmux_env="SSH_AUTH_SOCK=$SOCK_SYMLINK"
  else
    tmux_env=""
  fi

  if [ -z "$@" ]; then
    session_name="$(basename $(pwd))"
    session_name="${session_name//./-}" # Periods aren't allowed as of tmux1.9a

    # Attach to session with the current directory name if one exists,
    # otherwise automatically create a session with the current directory name
    tmux_cmd="-f $XDG_CONFIG_HOME/tmux/tmux.conf new -A -s $session_name"
  else
    # Otherwise just forward along the arguments given
    tmux_cmd="$@"
  fi

  env ${(z)tmux_env} "$(whence -p tmux)" ${(z)tmux_cmd}
}
