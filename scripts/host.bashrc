source "$HOME/.bashrc"

# Change the terminal prompt.
export PS1="($DOKKA_IMAGE) $PS1"

scr_cd() {
    cd $1
    screen -X chdir $PWD
}

# Make cd update the screen default directory, so that new tabs are created on
# the last accessed directory.
alias cd='scr_cd'

# Run image host config, if it exists.
HOST_BASHRC="$DOKKA_IMAGE_DIR/host.bashrc"
if [ -e "$HOST_BASHRC" ]
then
    source $HOST_BASHRC
fi
