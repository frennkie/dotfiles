#!/usr/bin/env bash
git clone https://github.com/vim/vim.git $HOME/vim
cd $HOME/vim/src
./configure --enable-pythoninterp --with-features=huge -prefix=$HOME/opt/vim
make
make install
mkdir -p $HOME/bin
cd $HOME/bin
ln -s $HOME/opt/vim/bin/vim
