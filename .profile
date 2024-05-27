#!/bin/sh

# profile file. Runs on login. Environmental variables are set here.

# Adds `~/.local/bin` to $PATH
export PATH="$PATH:${$(find ~/.local/bin -type d -printf %p:)%%:}"
export PATH="$PATH:/home/mati/Documents/clion-2021.2/bin"
unsetopt PROMPT_SP
# Default programs:
export EDITOR="nvim"
export TERMINAL="st"
export BROWSER="firefox"

# ~/ Clean-up:
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CACHE_HOME="$HOME/.cache"
export XINITRC="${XDG_CONFIG_HOME:-$HOME/.config}/x11/xinitrc"
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority
export GTK2_RC_FILES="${XDG_CONFIG_HOME:-$HOME/.config}/gtk-2.0/gtkrc-2.0"
export ZDOTDIR="${XDG_CONFIG_HOME:-$HOME/.config}/zsh"
export SSB_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zoom"
# How i ensure that it exist?
export BIB="$HOME/Documents/Doctorado/doc.bib"

#programs
export IPYTHONDIR="$XDG_CONFIG_HOME"/jupyter
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export WGETRC="$XDG_CONFIG_HOME"/wget/wgetrc
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java

export LF_ICONS="di=:\
fi=:\
tw=:\
ow=:\
ln=:\
or=ﲅ:\
ex=🎯:\
*.txt=✍:\
*.mom=✍:\
*.me=✍:\
*.ms=✍:\
*.png=:\
*.webp=:\
*.ico=:\
*.jpg=:\
*.jpe=:\
*.jpeg=:\
*.gif==::\
*.svg=:\
*.tif==::\
*.tiff=::\
*.xcf=:\
*.html=爵:\
*.xml=:\
*.gpg=🔒:\
*.css=🎨:\
*.pdf=:\
*.djvu=:\
*.epub=:\
*.csv=:\
*.xlsx=:\
*.tex=📜:\
*.md=📘:\
*.r=📊:\
*.R=📊:\
*.rmd=📊:\
*.Rmd=📊:\
*.m=📊:\
*.mp3=🎵:\
*.opus=🎵:\
*.ogg=🎵:\
*.m4a=🎵:\
*.flac=🎼:\
*.wav=:\
*.mkv=:\
*.mp4=:\
*.webm=:\
*.mpeg=:\
*.avi=:\
*.mov=:\
*.mpg=:\
*.wmv=:\
*.m4b=:\
*.flv=:\
*.zip=:\
*.rar=:\
*.7z=:\
*.tar.gz=:\
*.z64=🎮:\
*.v64=🎮:\
*.n64=🎮:\
*.gba=🎮:\
*.nes=🎮:\
*.gdi=🎮:\
*.1=ℹ:\
*.nfo=ℹ:\
*.info=ℹ:\
*.log=:\
*.iso=﫭:\
*.img=﫭:\
*.bib=:\
*.ged=👪:\
*.part=:\
*.torrent=:\
*.jar=♨:\
*.java=♨:\
"
[[ -z $DISPLAY && $xDG_VTNR -eq 1 ]] && exec startx
