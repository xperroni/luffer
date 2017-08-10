source "$HOME/.bashrc"

# Change the terminal prompt
export PS1='(lcad:tf) '$PS1

# Java
export JAVA_HOME=/usr/lib/jvm/java-7-oracle

# CARMEN
export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/local/lib/pkgconfig
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/lib:/usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu/:/usr/lib/libkml
export CARMEN_HOME=$HOME/LCAD/src/carmen_lcad
export QT_X11_NO_MITSHM=1

# MAE
export MAEHOME=$HOME/LCAD/src/MAE
export PATH=$PATH:$MAEHOME/bin

# Change into base directory for LCAD projects
cd "$HOME/LCAD"

export LD_LIBRARY_PATH="/usr/local/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH"
