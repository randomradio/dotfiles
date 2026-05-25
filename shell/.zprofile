# source all local binary (uv etc.)
. "$HOME/.local/bin/env"
# source local env variables
. "$HOME/.local/bin/env_var"

# homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# zoxide
eval "$(zoxide init zsh)"

# rust cargo
. "$HOME/.cargo/env"

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

. "$HOME/.atuin/bin/env"

eval "$(atuin init zsh)"

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
eval "$(fnm env --use-on-cd --shell zsh)"

export PATH="/opt/homebrew/opt/mysql@8.4/bin:$HOME/bin:$PATH"
eval "$(~/.local/bin/mise activate zsh)"

export JAVA_HOME=$(/usr/libexec/java_home -v 17)
export PATH="$JAVA_HOME/bin:$PATH"
export GITHUB_PERSONAL_ACCESS_TOKEN=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
export KUBECONFIG=~/.kube/config:~/.kube/config-dev-ctl:~/.kube/config-dev-unit:~/.kube/config-qa-ctl:~/.kube/config-qa-unit

unset ANTHROPIC_AUTH_TOKEN

export WORKTREE_ROOT="./.worktree"
