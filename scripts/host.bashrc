source "$HOME/.bashrc"

# Change the terminal prompt.
export PS1="($LUFFER_IMAGE) $PS1"

scr_cd() {
    cd $1
    screen -X chdir $PWD
}

# Make cd update the screen default directory, so that new tabs are created on
# the last accessed directory.
alias cd='scr_cd'

# Import Luffer utility functions.
source "$LUFFER_HOME/luffer-utils.sh"

# Run image host config, if it exists.
HOST_BASHRC=$(pathto "host.bashrc")
if [ -e "$HOST_BASHRC" ]
then
    source $HOST_BASHRC
fi
