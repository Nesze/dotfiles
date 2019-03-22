#Golang variables
export GOPATH="$HOME/Dev/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

#Other vars
export EDITOR="vim"

#brew --prefix is painfully slow, use absolute paths instead:
if [ -f /usr/local/share/bash-completion/bash_completion ]; then
    . /usr/local/share/bash-completion/bash_completion
fi

#brew doctor suggestion: brew installs executables under this path as well"
export PATH="/usr/local/sbin:$PATH"

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

export PATH="node_modules/.bin:$PATH"

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

alias ll="exa -l"
alias ld="ls -ld */"
alias digg='dig +noall +answer'

# dotfiles cfg
alias dots='/usr/bin/git --git-dir=$HOME/.dots/ --work-tree=$HOME'

#kubernetes
# source <(kubectl completion bash)
alias k="kubectl"
complete -o default -F __start_kubectl k

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}
source "/usr/local/opt/kube-ps1/share/kube-ps1.sh"
export KUBE_PS1_SYMBOL_COLOR="green"
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\]\$(kube_ps1)\$ "

# Bash 4.x features
shopt -s globstar

# Source envs
source $HOME/.envs

export HOMEBREW_GITHUB_API_TOKEN=$GITHUB_TOKEN_NO_SCOPE
# hub
export GITHUB_TOKEN=$GITHUB_TOKEN_REPO_SCOPE

eval "$(hub alias -s)"

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

# git helpers
alias gitclean="git br --merged | grep -v master | xargs git br -d"
alias githead="git log | head -1 | awk '{print \$2}'"
alias ghcp="githead | tr -d '\n' | pbcopy"

export CLICOLOR=1

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
export FZF_DEFAULT_COMMAND='fd --type f'
export FZF_TMUX=1
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
