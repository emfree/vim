#!/bin/bash

cd ctags
./configure --prefix=`pwd`
make install
cd ~
cp .vimrc .vimrc.backup
echo runtime vimrc > .vimrc


