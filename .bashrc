#jenv
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"


#Golang variables
export GOPATH="$HOME/Dev/go"
export GOBIN="$GOPATH/bin"
export PATH="$GOBIN:$PATH"

#Brew stuff >>>
if [ -f `brew --prefix`/etc/bash_completion ]; then
   . `brew --prefix`/etc/bash_completion
fi

#prefer GNU cmds upon BSD implementations
export PATH="$(brew --prefix grep)/bin:$(brew --prefix coreutils)/libexec/gnubin:$PATH"

#brew doctor suggestion: brew installs executables under this path as well"
export PATH="/usr/local/sbin:$PATH"


# Short of learning how to actually configure OSX, here's a hacky way to use
# GNU manpages for programs that are GNU ones, and fallback to OSX manpages otherwise
alias man='_() { echo $1; man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1 1>/dev/null 2>&1;  if [ "$?" -eq 0 ]; then man -M $(brew --prefix)/opt/coreutils/libexec/gnuman $1; else man $1; fi }; _'

# <<<

alias ..='cd ..'
alias ...='cd ../..'

#ssh
ssh-add ~/.ssh/id_rsa ~/.ssh/ft_AD

# History stuff
HISTSIZE=50000
HISTFILESIZE=50000
export HISTTIMEFORMAT="%d/%m/%y %T "

# FT stuff
export FLEETCTL_TUNNEL=xp-tunnel-up.ft.com

alias prod-uk='export FLEETCTL_TUNNEL=prod-uk-tunnel-up.ft.com' 
alias prod-us='export FLEETCTL_TUNNEL=prod-us-tunnel-up.ft.com' 
alias pre-prod='export FLEETCTL_TUNNEL=pre-prod-uk-tunnel-up.ft.com'
alias pre-prod-us='export FLEETCTL_TUNNEL=pre-prod-us-tunnel-up.ft.com'
alias dynpub='export FLEETCTL_TUNNEL=dynpub-uk-tunnel-up.ft.com'
alias xp='export FLEETCTL_TUNNEL=xp-tunnel-up.ft.com'
alias rj='export FLEETCTL_TUNNEL=rj-tunnel-up.ft.com'
alias semantic='export FLEETCTL_TUNNEL=semantic-tunnel-up.ft.com'
alias pub-xp='export FLEETCTL_TUNNEL=pub-xp-tunnel-up.ft.com'
alias pub-pre-prod='export FLEETCTL_TUNNEL=pub-pre-prod-uk-tunnel-up.ft.com'
alias pub-pre-prod-us='export FLEETCTL_TUNNEL=pub-pre-prod-us-tunnel-up.ft.com'
alias pub-prod-uk='export FLEETCTL_TUNNEL=pub-prod-uk-tunnel-up.ft.com'
alias pub-prod-us='export FLEETCTL_TUNNEL=pub-prod-us-tunnel-up.ft.com'
alias pub-dynpub='export FLEETCTL_TUNNEL=pub-dynpub-uk-tunnel-up.ft.com'
alias pub-semantic='export FLEETCTL_TUNNEL=pub-semantic-tunnel-up.ft.com'
alias registry='export FLEETCTL_TUNNEL=up-registry-tunnel-up.ft.com'

alias fc='fleetctl'
alias fclm='fleetctl list-machines'
alias fclu='fleetctl list-units'
alias fcluf='fleetctl list-unit-files'
alias fccat='fleetctl cat'
alias fcssh='fleetctl ssh -A'
alias etcdctl='fleetctl ssh kafka etcdctl'

alias diggF="digg $FLEETCTL_TUNNEL | cut -f5"

function fclmg() { fleetctl list-machines | grep  $@ ;}
function fclug() { fleetctl list-units | grep  $@ ;}
function fcssh() { fleetctl ssh $@ ;}
function fcjfl() { fleetctl journal -f --lines=$@ ; }
function fcres() { fleetctl ssh $@ sudo systemctl restart $@ ; }

function auth {
  local credentials=$(fleetctl ssh deployer etcdctl get /ft/_credentials/varnish/htpasswd 2> /dev/null | sed -n 1'p' | tr ',' '\n')
  for credential in ${credentials}; do
    local username=$(echo ${credential} | cut -d: -f1)
    local password=$(echo ${credential} | cut -d: -f2)
    break
  done

  echo ${username}:${password}
}

function tunnel {
    if [ -n "$FLEETCTL_TUNNEL" ]; then
        echo "Activating tunnel on port 8080 to $FLEETCTL_TUNNEL..."
        ssh -L 8080:localhost:8080 core@$FLEETCTL_TUNNEL
    fi
}

function fcip { fleetctl ssh $@ "curl 169.254.169.254/latest/meta-data/public-ipv4"; }

# Color improvement
export LSCOLORS=GxFxCxDxBxegedabagaced

# Git branch in prompt.
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

#export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

#next stuff
## bower registry
[ -e ~/.bowerrc ] || echo '{ "registry": { "search": [ "http://registry.origami.ft.com", "https://bower.herokuapp.com" ] } }' > ~/.bowerrc

export PATH="node_modules/.bin:$PATH"

# ruby stuff
if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi

MANPATH="/usr/local/opt/coreutils/libexec/gnuman:$MANPATH"

alias digg='dig +noall +answer'

# dotfiles cfg
alias config='/usr/bin/git --git-dir=/Users/zoltan/.cfg/ --work-tree=/Users/zoltan'
