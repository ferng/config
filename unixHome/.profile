# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# Maven
export M2_HOME=$HOME/bin/apache-maven-3.5.0
export M2=$M2_HOME/bin
export PATH=$M2:$PATH:

# Nodejs
export PATH=~/.npm-packages/bin:$PATH

# c
export CFLAGS='-std=gnu89 -Wall -Wextra -Wfloat-equal -Wformat-security -Wformat-overflow -Wformat-truncation -Wdouble-promotion -Wimplicit-fallthrough -Wmissing-include-dirs -Wswitch-enum -Wswitch-default -Wunused -Wuninitialized -Wduplicated-branches -Wduplicated-cond -Wpointer-arith -Wbad-function-cast -Wcast-qual -Wcast-align -Wjump-misses-init -Wconversion -Wmissing-prototypes -Wmissing-declarations -Wmissing-field-initializers -Wpadded -Wredundant-decls -Wint-in-bool-context -g -ggdb -pg -fprofile-arcs -ftest-coverage -fsanitize=address -fsanitize=undefined -fsanitize-address-use-after-scope -fsanitize-undefined-trap-on-error -fstack-protector-all -fstack-check'
