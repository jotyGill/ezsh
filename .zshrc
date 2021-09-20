################ DO NOT MODIFY THIS FILE #######################

################################################################


# This file is created by ezsh setup.
# Place all your .zshrc configurations / overrides in a single or multiple files under ~/.config/ezsh/zshrc/ folder
# Your original .zshrc is backed up at ~/.zshrc-backup-%y-%m-%d


# Load ezsh configurations
source "$HOME/.config/ezsh/ezshrc.zsh"


# Any zshrc configurations under the folder ~/.config/ezsh/zshrc/ will override the default ezsh configs.
# Place all of your personal configurations over there
ZDOTDIR="$HOME/.config/ezsh/zshrc"

if [ "$(ls -A $ZDOTDIR)" ]; then
    for file in "$ZDOTDIR"/*; do
        source "$file"
    done
fi
