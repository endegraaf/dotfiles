#!/bin/bash
echo Make Symlinks to ~/git/dotfiles/ ... 
if [[ -d ~/git/dotfiles ]]; 
then
ln -s ~/git/dotfiles/Xresources ~/.Xresources
ln -s ~/git/dotfiles/bashrc ~/.bashrc
ln -s ~/git/dotfiles/config/autorandr/ ~/.config/autorandr
ln -s ~/git/dotfiles/config/copyq/copyq.conf ~/.config/copyq/copyq.conf
ln -s ~/git/dotfiles/config/fontconfig/fonts.conf ~/.config/fontconfig/fonts.conf
ln -s ~/git/dotfiles/config/i3/config ~/.config/i3/config
ln -s ~/git/dotfiles/config/picom ~/.config/picom
ln -s ~/git/dotfiles/config/polybar ~/.config/polybar
ln -s ~/git/dotfiles/config/compton.conf ~/.config/compton.conf
ln -s ~/git/dotfiles/xfiles/ ~/.xfiles
ln -s ~/git/dotfiles/vimrc ~/.vimrc
ln -s ~/git/dotfiles/Xmodmap ~/.Xmodmap 
else
        echo Missing the dotfiles dir in the git folder!
fi
echo Plug for Vim plugin management

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
