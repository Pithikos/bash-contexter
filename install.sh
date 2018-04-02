#! /bin/bash

BC_INSTALL_DIR=~/.bash_contexter
BC_GIT_URL="git@github.com:Pithikos/bash-contexter.git"
BC_SOURCED=~/.bash_contexter/bash_contexter.sh


# Copy source code into home directory
mkdir "$BC_INSTALL_DIR"
git clone "$BC_GIT_URL" "$BC_INSTALL_DIR"


# Add source entry
if [ -f ~/.bash_profile ]; then
  echo "source $BC_SOURCED" >> ~/.bash_profile
elif [ -f ~/.profile ]; then
  echo "source $BC_SOURCED" >> ~/.profile
else
  echo "Could not find .bash_profile or .profile"
  echo "Please source $BC_SOURCED"
fi
