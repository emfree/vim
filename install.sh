#!/bin/bash

cd ~
git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
cp .vimrc .vimrc.backup
echo runtime vimrc > .vimrc


