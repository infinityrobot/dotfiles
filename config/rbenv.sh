# Initialise rbenv.
if [[ -d "$HOME/.rbenv" ]]; then
  # Add rbenv to PATH & initialize.
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init - --no-rehash zsh)"
  # Export helpful ruby related env variables.
  export RUBY_GLOBAL_VERSION="$(rbenv global)"
fi
