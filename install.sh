#!/bin/bash

# Get the current directory
DIR="$( cd "$(dirname "$0" )" && pwd )"

# Link dot files to $HOME
for dotfile in $(find $DIR -maxdepth 1 -type f -name ".*"); do
  if [[ $(uname) == 'Linux' && "$(basename $dotfile)" == '.tmux.linux.conf' ]]; then
    ln -fs $dotfile "${HOME}/.tmux.conf"
  elif [[ $(uname) == 'Linux' && "$(basename $dotfile)" == '.bashrc-ubuntu' ]]; then
    ln -fs $dotfile "${HOME}/.bashrc"
  elif [[ $(uname) == 'Darwin' && "$(basename $dotfile)" == '.tmux.osx.conf' ]]; then
    ln -fs $dotfile "${HOME}/.tmux.conf"
  elif [[ $(uname) == 'Darwin' && "$(basename $dotfile)" == '.bashrc-osx' ]]; then
    ln -fs $dotfile "${HOME}/.bashrc"
  elif [[ ! "$(basename $dotfile)" =~ ^.tmux && ! "$(basename $dotfile)" =~ ^.bashrc- ]]; then
    ln -fs $dotfile "${HOME}/$(basename $dotfile)"
  fi
done

# Link rc files in .bashrc.d
[ -d "${HOME}/.bashrc.d" ] || mkdir "${HOME}/.bashrc.d"
for dotfile in ${DIR}/.bashrc.d/*; do
    ln -fs $dotfile "${HOME}/.bashrc.d/$(basename $dotfile)"
done

# Link files in bin
[ -d "${HOME}/bin" ] || mkdir "${HOME}/bin"
for program in ${DIR}/bin/*; do
    [ -x $program ] || continue
    [[ $(uname) == 'Linux' && $(basename $program) == 'reattach-to-user-namespace' ]] && continue
    ln -fs $program "${HOME}/bin/$(basename $program)"
done

# Link files in lib
[ -d "${HOME}/lib" ] || mkdir "${HOME}/lib"
for file in ${DIR}/lib/*; do
    [ -x $file ] || continue
    ln -fs $file "${HOME}/lib/$(basename $file)"
done

[ -d "${HOME}/.vim/pack" ]    || mkdir -p "${HOME}/.vim/pack/"
[ -d "${HOME}/.vim/backups" ] || mkdir -p "${HOME}/.vim/backups"
[ -d "${HOME}/.vim/swaps" ]   || mkdir -p "${HOME}/.vim/swaps"
[ -d "${HOME}/.vim/undo" ]    || mkdir -p "${HOME}/.vim/undo"

# Link rbenv default-gems
[ -d "${HOME}/.rbenv" ] || mkdir "${HOME}/.rbenv"
ln -fs ${DIR}/default-gems "${HOME}/.rbenv/default-gems"

# Remove broken symlinks
find -L "${HOME}" "${HOME}/.bashrc.d" "${HOME}/bin" "${HOME}/lib" -maxdepth 1 -type l | xargs rm 2>/dev/null

# execute scripts on install
(exec "${DIR}/bin/setup-gitconfig")
(exec "${DIR}/bin/vim-minpac")

echo "Installation was successful! 🎉"
