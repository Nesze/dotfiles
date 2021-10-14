if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
export PATH="/usr/local/opt/openjdk/bin:$PATH"
complete -C /usr/local/bin/bit bit
