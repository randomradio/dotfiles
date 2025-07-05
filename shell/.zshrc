# Start configuration added by Zim install {{{
#
# User configuration sourced by interactive shells
#

# -----------------
# Zsh configuration
# -----------------
#
export ZSH_COMPDUMP="$HOME/.zcompdump"
mkdir -p "${ZSH_COMPDUMP%/*}"

#
# History
#

# Remove older command from the history if a duplicate is to be added.
setopt HIST_IGNORE_ALL_DUPS

#
# Input/output
#

# Set editor default keymap to emacs (`-e`) or vi (`-v`)
bindkey -e

# Prompt for spelling correction of commands.
#setopt CORRECT

# Customize spelling correction prompt.
#SPROMPT='zsh: correct %F{red}%R%f to %F{green}%r%f [nyae]? '

# Remove path separator from WORDCHARS.
WORDCHARS=${WORDCHARS//[\/]}


# Source .zprofile if it exists
if [ -f "$HOME/.zprofile" ]; then
    source "$HOME/.zprofile"
fi

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"
