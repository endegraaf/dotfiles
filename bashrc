# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f $HOME/.bash-secrets ]; then
  echo ... 
  . $HOME/.bash-secrets
fi
JAVA_HOME=$HOME/JAVA/jdk11/
PATH="$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$HOME/scripts:$PATH"
export PATH
export ANDROID_HOME=~/Android/Sdk
export HISTCONTROL=ignoredups:ignorespace
export XDG_DATA_DIRS="/usr/share:$HOME/.local/share/flatpak/exports/share/applications:/var/lib/flatpak/exports/share/applications"
# https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications#Styles_for_both_Qt_and_GTK
export QT_QPA_PLATFORMTHEME=gnome
# User specific aliases and functions
alias nan='netstat -an |grep LISTEN | grep tcp'
alias monmock='netstat -an |grep tcp |grep :::8'
alias gst='git status'
alias gpl='git pull'
alias gca='git add . && git commit -a && git push'
alias dockerstop='docker stop $(docker ps -a -q)'
alias dockerrm='docker rm ${docker ps -a -q)'
alias ls='ls --color'
alias ll='ls -lhtr'
alias l='ls -lh'
alias la='ls -lhatr'
alias py='python'
alias kw='kwrite'
alias ge='gedit'
alias vi='vim'
alias rexvt='xrdb ~/.Xresources && pkill urxvt'
alias rxconf='vim ~/.Xresources'
alias vimrc='vim ~/.vimrc'
alias i3conf='vim ~/.config/i3/config'
alias bashrc='vim ~/.bashrc'
alias polyconf='vim ~/.config/polybar/config'
alias killteams='pkill teams'
release=$(sed -n 1p  /etc/os-release)
if [[ $release == *"Fedora"* ]]; then
  echo "Set the Silverblue specific aliases"
  alias gedit='flatpak run org.gnome.gedit'
  alias code='flatpak run com.visualstudio.code'
  alias vim='flatpak run org.vim.Vim'
  alias ros='rpm-ostree status'
  alias roi='rpm-ostree install'
  alias rou='rpm-ostree update'
  alias docker='podman'
fi
# Only run Dropbox on one OS
if [[ $release == *"Arch Linux"* ]]; then
  echo "Arch Linux specific bash"
  if pgrep -x "dropbox" >/dev/null 
  then 
      echo "Dropbox is running" 
  else 
      echo "Dropbox not running, starting"
      $HOME/.dropbox-dist/dropboxd & 
  fi
fi
# If running in TTY mode, increase the font size
if [[ 'tty' =~ ^/dev/tty[0-9]+ ]]
    then setfont /usr/share/kbd/consolefonts/iso02-12x22.psfu.gz &
fi

powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
 

