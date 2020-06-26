# Override default ~/.gemrc location
export GEMRC="$XDG_CONFIG_HOME/gem/gemrc"

# Load additional gemrc configuration from ~/.gemrc.local.
local_gemrc_file="$XDG_CONFIG_HOME/gem/gemrc.local"
if [ -f "$local_gemrc_file" ]; then
  export GEMRC="$GEMRC:$local_gemrc_file"
fi
