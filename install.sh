#!/usr/bin/env bash

# Variables
dotfile_path=$HOME/.dotfiles

# Install / update oh-my-zsh
if [[ -d $HOME/.oh-my-zsh ]]; then
  echo "oh-my-zsh is already installed, updating...";
  git -C "$HOME"/.oh-my-zsh pull
else
  echo "Installing oh-my-zsh in ~/.oh-my-zsh...";
  git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME"/.oh-my-zsh
fi

# Set default shell to zsh
if [[ $SHELL == *"zsh"* ]]; then
  echo "Shell already set to zsh.";
else
  echo "Setting shell to zsh...";
  chsh -s /bin/zsh
fi

# Install / updated dotfiles
if [[ -d $dotfile_path ]]; then
  echo "Updating Infinity Robot's dotfiles...";
  git -C "$dotfile_path" pull
else
  echo "Cloning Infinity Robot's dotfiles to ~/.dotfiles...";
  git clone git://github.com/infinityrobot/dotfiles.git "$dotfile_path"
fi

# Add oh-my-zsh customizations
echo "Adding oh-my-zsh customizations from Infinity Robot's dotfiles...";
theme_name="infinityrobot"
ln -s "$dotfile_path"/oh-my-zsh/custom/themes/"$theme_name".zsh-theme "$HOME"/.oh-my-zsh/custom/themes/"$theme_name".zsh-theme 2> /dev/null

# Set up symlinks
echo "Adding required symlinks...";
for f in $(find "$dotfile_path" -name '*.symlink'); do
    file_path="$HOME"/.${${f##*/}%.*}
    cp "$file_path" "$file_path"-old 2> /dev/null
    unlink "$file_path" 2> /dev/null
    rm "$file_path" 2> /dev/null
    ln -s "$f" "$file_path"
done

echo "Installation complete!"