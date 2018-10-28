#!/bin/bash
set -e

# Make symlinks to the dotfiles I currently use (default: _current).
# Makes symlinks for all <item>s in _current to ~/.<item>
# Run from 'mac-setup'. Doesn't do anything unless run with --yes.

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
SRC_DIR="${DIR}/_current"
SRC_DOTFILES=$(find ${SRC_DIR}/ -mindepth 1 -maxdepth 1)

# Preview symlinks creation
for ITEM in ${SRC_DOTFILES}; do
  echo "Will do 'ln -sTf ${ITEM} ~/.$(basename $ITEM)'"
done

if [[ "$1" != "--yes" ]] ; then
  # Preview
  echo "Re-run '$0' with '--yes' to confirm."
else
  # Execute if '--yes'
  set -x
  for ITEM in ${SRC_DOTFILES}; do
    ln -sTf ${ITEM} ~/.$(basename $ITEM)
  done
  echo "Done."
fi

exit 0
