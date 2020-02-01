#!bin/bash/

if test -f ".vimrc"; then
  cp .vimrc ~/.vimrc
fi

if test -f ".zshrc"; then
  cp .zshrc ~/.zshrc
fi


