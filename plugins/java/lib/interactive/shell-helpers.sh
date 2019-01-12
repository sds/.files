# Excerpt taken from the output of `jenv init -`
# We explicitly define this so the rehash/shell commands work, while at the same
# time avoiding:
# - Adding the shims directory to the PATH again (it was already added on login)
# - Sourcing completions
# - Performing a rehash
jenv() {
  local command
  command="$1"
  if [ "$#" -gt 0 ]; then
    shift
  fi

  case "$command" in
  enable-plugin|rehash|shell|shell-options)
    eval "$(jenv "sh-$command" "$@")";;
  *)
    command jenv "$command" "$@";;
  esac
}
