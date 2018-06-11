#!/usr/bin/env bash

# ---------------------------------------------------------------------------- #
# Variables
# ---------------------------------------------------------------------------- #
dotfile_path=$HOME/.dotfiles
platform="$(uname -s)"

# Set default shell to zsh
if [[ $SHELL == *"zsh"* ]]; then
  echo "Shell already set to zsh.";
else
  echo "Setting shell to zsh...";
  chsh -s "$(which zsh)"
fi

# Install / update oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]; then
  echo "oh-my-zsh is already installed, updating...";
  git -C "$HOME"/.oh-my-zsh pull
else
  echo "Installing oh-my-zsh in ~/.oh-my-zsh...";
  git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME"/.oh-my-zsh
fi

# Install / update Infinty Robot's dotfiles
install_infinity_dotfiles() {
  echo "Cloning Infinity Robot's dotfiles to ~/.dotfiles...";
  git clone git://github.com/infinityrobot/dotfiles.git "$dotfile_path"
}

if [[ -d $dotfile_path ]]; then

  git_remote=$(git -C "$dotfile_path" config --get branch.master.remote)
  git_url=$(git -C "$dotfile_path" config --get remote."$git_remote".url)

  if [[ $git_url == *"infinityrobot/dotfiles"* ]]; then
    echo "Infinity Robot's dotfiles already installed. Updating..."
    git -C "$dotfile_path" pull
  else
    echo "Existing dotfiles found. Backing up to ~/.dotfiles-old"
    mv "$dotfile_path" "$dotfile_path"-old
    install_infinity_dotfiles
  fi

else
  install_infinity_dotfiles
fi

# Add oh-my-zsh customizations
echo "Adding oh-my-zsh customizations from Infinity Robot's dotfiles...";
theme_name="infinityrobot"
mkdir -p "$dotfile_path"/oh-my-zsh/custom/themes/
mkdir -p "$HOME"/.oh-my-zsh/custom/themes/
ln -s "$dotfile_path"/oh-my-zsh/custom/themes/"$theme_name".zsh-theme "$HOME"/.oh-my-zsh/custom/themes/"$theme_name".zsh-theme 2> /dev/null

# Set up symlinks
echo "Adding required symlinks...";
for f in $(find "$dotfile_path" -name '*.symlink'); do
  file_name="${f##*/}"
  file_path="$HOME"/."${file_name%.*}"

  if ! diff "$f" "$file_path" >/dev/null ; then
    echo "Existing $file_name found – copying backup to $file_name-old"
    cp "$file_path" "$file_path"-old 2> /dev/null
  fi

  unlink "$file_path" 2> /dev/null
  rm "$file_path" 2> /dev/null
  ln -s "$f" "$file_path"
done

# Create .zshrc.local
if [ ! -f "$HOME/.zshrc.local" ]; then
  touch "$HOME/.zshrc.local"
fi

# Install Xcode dev tools
xcode-select --install

# Install Homebrew (https://github.com/Homebrew/brew)
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew update
brew doctor

# Install Homebrew services & bundle
brew tap homebrew/services
brew tap homebrew/bundle

# Install and configure awesome apps & dev tools.
read -p "Do you want to install infinityrobot's apps & set up dev environment? <y/n> " brew_prompt
if [[ $brew_prompt =~ [yY](es)* ]]; then
  # Install Brewfile
  brew bundle --file="$dotfile_path"/packages/Brewfile -v
  brew cleanup --force
  rm -f -r /Library/Caches/Homebrew/*

  # Set up rbenv & Ruby (https://github.com/rbenv/rbenv)
  rbenv init
  latest_ruby_version="$(rbenv install -l | grep -v - | tail -1)"
  rbenv install $latest_ruby_version
  rbenv --global $latest_ruby_version
  gem install bundler
  bundle install --gemfile="$dotfile_path"/packages/Gemfile
  rm -f "$dotfile_path"/packages/Gemfile.lock

  # Install Atom packages
  apm install --packages-file "$dotfile_path"/packages/Atomfile
  apm cleanup

  # Configure git
  git config --global core.editor atom
  git config --global core.excludesfile ~/.gitignore_global
fi

echo "Installation complete!"
