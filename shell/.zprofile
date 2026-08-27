# source all local binary (uv etc.)
[[ -f "$HOME/.local/bin/env" ]] && . "$HOME/.local/bin/env"
# source local env variables
[[ -f "$HOME/.local/bin/env_var" ]] && . "$HOME/.local/bin/env_var"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"

# rust cargo
[[ -f "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# direnv
command -v direnv >/dev/null 2>&1 && eval "$(direnv hook zsh)"
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

[[ -f "$HOME/.atuin/bin/env" ]] && . "$HOME/.atuin/bin/env"

command -v atuin >/dev/null 2>&1 && eval "$(atuin init zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/randomradio/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/randomradio/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/randomradio/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/randomradio/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# Aliases
alias vim=nvim
alias typora="open -a typora"
alias dps='docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Status}}\t{{.Ports}}"'

# for go people
export GOROOT=/usr/local/go
export GOHOME=$HOME/go
export PATH=$GOHOME:$GOHOME/bin:$GOROOT/bin:$PATH 

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# nodejs manager but in rust
command -v fnm >/dev/null 2>&1 && eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="/opt/homebrew/opt/mysql@8.4/bin:$HOME/bin:$PATH"
command -v mise >/dev/null 2>&1 && eval "$(mise activate zsh)"

if JAVA_HOME_17=$(/usr/libexec/java_home -v 17 2>/dev/null); then
  export JAVA_HOME="$JAVA_HOME_17"
  export PATH="$JAVA_HOME/bin:$PATH"
fi
unset JAVA_HOME_17
export KUBECONFIG=~/.kube/config:~/.kube/config-dev-ctl:~/.kube/config-dev-unit:~/.kube/config-qa-ctl:~/.kube/config-qa-unit

export WORKTREE_ROOT="./.worktree"

