# Initialise exenv.
if [[ -d "$HOME/.exenv" ]]; then
  export PATH="$HOME/.exenv/bin:$PATH"
  eval "$(exenv init - --no-rehash zsh)"
fi
