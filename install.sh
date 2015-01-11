#!/usr/bin/env bash

# Variables
dotfile_path=$HOME/.dotfiles
current_pwd=$PWD

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

  cd "$dotfile_path"
  git_remote=$(git config --get branch.master.remote)
  git_url=$(git config --get remote."$git_remote".url)

  if [[ $git_url == *"infinityrobot/dotfiles"* ]]; then
    echo "Infinity Robot's dotfiles already installed. Updating..."
    git -C "$dotfile_path" pull
  else
    echo "Existing dotfiles found. Backing up to ~/.dotfiles-old"
    mv "$dotfile_path" "$dotfile_path"-old
    install_infinity_dotfiles
  fi

  cd "$current_pwd"

else
  install_infinity_dotfiles
fi

# Add oh-my-zsh customizations
echo "Adding oh-my-zsh customizations from Infinity Robot's dotfiles...";
theme_name="infinityrobot"
ln -s "$dotfile_path"/oh-my-zsh/custom/themes/"$theme_name".zsh-theme "$HOME"/.oh-my-zsh/custom/themes/"$theme_name".zsh-theme 2> /dev/null

# Set up symlinks
echo "Adding required symlinks...";
for f in $(find "$dotfile_path" -name '*.symlink'); do
    file_name="${f##*/}"
    file_path="$HOME"/."${file_name%.*}"
    cp "$file_path" "$file_path"-old 2> /dev/null
    unlink "$file_path" 2> /dev/null
    rm "$file_path" 2> /dev/null
    ln -s "$f" "$file_path"
done

# Create .zshrc.local
if [ ! -f "$HOME/.zshrc.local" ]; then
  touch "$HOME/.zshrc.local"
fi

echo "Installation complete!"