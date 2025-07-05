. "$HOME/.local/bin/env"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# direnv
eval "$(direnv hook zsh)"
function gignr() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

# The next line updates PATH for the Google Cloud SDK.
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi

# The next line enables shell command completion for gcloud.
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi

[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"

# Added by LM Studio CLI (lms)
export PATH="$PATH:$HOME/.lmstudio/bin"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# starship command
eval "$(starship init zsh)"

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('$HOME/miniforge3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "$HOME/miniforge3/etc/profile.d/conda.sh" ]; then
        . "$HOME/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="$HOME/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "$HOME/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "$HOME/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<

# Aliases
alias vim=nvim
alias cs=cursor

# for go people
export GOROOT=/usr/local/go
export GOHOME=$HOME/go
export PATH=$GOHOME:$GOHOME/bin:$GOROOT/bin:$PATH 

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# nodejs manager but in rust
eval "$(fnm env --use-on-cd --shell zsh)"

source "$HOME/.rye/env"
