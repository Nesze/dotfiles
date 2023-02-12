#Golang variables
export GOPATH="$HOME/Dev/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

#Other vars
export EDITOR="vim"

# brew
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"

export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_TOKEN_NO_SCOPE

export BREW_PREFIX=`brew --prefix`

if [ -f $BREW_PREFIX/share/bash-completion/bash_completion ]; then . $BREW_PREFIX/share/bash-completion/bash_completion
fi

#dev binaries
export PATH="$HOME/Dev/bin:$PATH"

# Short of learning how to actually configure OSX, here's a hacky way to use
# GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'

alias ..='cd ..'

ssh-add ~/.ssh/id_rsa 2>/dev/null

# History stuff
HISTSIZE=50000
HISTFILESIZE=50000
export HISTCONTROL=ignoreboth:erasedups
export HISTTIMEFORMAT="%d/%m/%y %T "

# Color improvement
export LSCOLORS=GxFxCxDxBxegedabagaced

# node
export PATH="node_modules/.bin:$PATH"

MANPATH="$BREW_PREFIX/opt/coreutils/libexec/gnuman:$MANPATH"

alias ll="exa -l"
alias ld="ls -ld */"
alias digg='dig +noall +answer'

# dotfiles cfg
alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'

#kubernetes
# source <(kubectl completion bash)
alias k="kubectl"
# complete -o default -F __start_kubectl k
# complete -F _complete_alias k

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
source "$BREW_PREFIX/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_SYMBOL_COLOR="green"
export KUBE_PS1_SYMBOL_ENABLE="false"
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$(kube_ps1)\$ "

# Git autocomplete
if [ -f $BREW_PREFIX/etc/bash_completion.d/git-completion.bash ]; then
  . $BREW_PREFIX/etc/bash_completion.d/git-completion.bash
fi

# Bash 4.x features
shopt -s globstar

# Source envs
source $HOME/.envs

# gh
export GITHUB_TOKEN=$GITHUB_TOKEN_REPO_READORG

# git helpers
gitclean() {
  git br --merged | grep -v -E "master|main|$(git branch --show-current)" | xargs git br -d
}

gitcoma() {
  git checkout $(git branch | cut -c 3- | grep -E '^master$|^main$')
}

gitfresh() {
  gitcoma && git pull && gitclean
}

alias githead="git log | head -1 | awk '{print \$2}'"
alias ghcp="githead | tr -d '\n' | pbcopy"

# ??
export CLICOLOR=1

# autojump
[ -f $BREW_PREFIX/etc/profile.d/autojump.sh ] && . $BREW_PREFIX/etc/profile.d/autojump.sh

# fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_DEFAULT_OPTS='--height 40% --border'
export FZF_TMUX=1
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

# uw
export GOOGLE_CREDENTIALS=/root/.config/gcloud/uw-terraform-sa.json

# ??
source $HOME/Library/Preferences/org.dystroy.broot/launcher/bash/br

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# ssl helper
function certg() {
  printf "openssl s_client -showcerts -servername $1 -connect ${1}:443 </dev/null"
  openssl s_client -showcerts -servername $1 -connect ${1}:443 </dev/null
}
