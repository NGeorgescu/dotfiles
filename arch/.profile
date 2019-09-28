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

# enable the keyring

if [ -n "$DESKTOP_SESSION" ];then
	    eval $(gnome-keyring-daemon --start)
	        export SSH_AUTH_SOCK
fi



# Adds `~/.scripts` and all subdirectories to $PATH
export PATH="$PATH:$(du "$HOME/.scripts/" | cut -f2 | tr '\n' ':' | sed 's/:*$//')"
export EDITOR="vim"
export TERMINAL="gnome-terminal"
export BROWSER="firefox"
export READER="mupdf"
export FILE="vifm"
export BIB="$HOME/Documents/LaTeX/uni.bib"
export REFER="$HOME/Documents/referbib"
export SUDO_ASKPASS="$HOME/.scripts/tools/dmenupass"
export NOTMUCH_CONFIG="$HOME/.config/notmuch-config"
export GTK2_RC_FILES="$HOME/.config/gtk-2.0/gtkrc-2.0"
export RANGER_LOAD_DEFAULT_RC=FALSE

# less/man colors
#export LESS=-R
#export LESS_TERMCAP_mb="$(printf '%b' '[1;31m')"; a="${a%_}"
#export LESS_TERMCAP_md="$(printf '%b' '[1;36m')"; a="${a%_}"
#export LESS_TERMCAP_me="$(printf '%b' '[0m')"; a="${a%_}"
#export LESS_TERMCAP_so="$(printf '%b' '[01;44;33m')"; a="${a%_}"
#export LESS_TERMCAP_se="$(printf '%b' '[0m')"; a="${a%_}"
#export LESS_TERMCAP_us="$(printf '%b' '[1;32m')"; a="${a%_}"
#export LESS_TERMCAP_ue="$(printf '%b' '[0m')"; a="${a%_}"

[ ! -f ~/.config/shortcutrc ] && shortcuts >/dev/null 2>&1

echo "$0" | grep "bash$" >/dev/null && [ -f ~/.bashrc ] && source "$HOME/.bashrc"

# Start graphical server if i3 not already running.
#[ "$(tty)" = "/dev/tty1" ] && ! pgrep -x i3 >/dev/null && exec startx

# Switch escape and caps if tty:
#sudo -n loadkeys ~/.scripts/ttymaps.kmap 2>/dev/null
