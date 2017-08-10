source "$HOME/.bashrc"

# Change the terminal prompt
export PS1="($DOKKA_IMAGE) $PS1"

HOST_BASHRC="$DOKKA_PLUGGED_DIR/host.bashrc"

if [ -e "$HOST_BASHRC" ]
then
    source $HOST_BASHRC
fi
