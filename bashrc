# .bashrc
[[ $- == *i* ]] || return
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

if [ -f $HOME/.bash-secrets ]; then
  echo ... 
  . $HOME/.bash-secrets
fi
JAVA_HOME=$HOME/JAVA/jdk11/
PATH="/opt/Citrix/ICAClient/:$HOME/Apps:$HOME/.local/bin:$HOME/bin:$JAVA_HOME/bin:$HOME/scripts:$PATH"
export PATH
export ANDROID_HOME=~/Android/Sdk
export HISTCONTROL=ignoredups:ignorespace
export XDG_DATA_DIRS="/usr/share:$HOME/.local/share/flatpak/exports/share/applications:/var/lib/flatpak/exports/share/applications"
# https://wiki.archlinux.org/index.php/Uniform_look_for_Qt_and_GTK_applications#Styles_for_both_Qt_and_GTK
export QT_QPA_PLATFORMTHEME=qt5ct
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
alias psef='ps -ef | grep -i '
alias subl='flatpak run com.sublimetext.three'
release=$(sed -n 1p  /etc/os-release)
if [[ $release == *"Fedora"* ]]; then
  echo "Running on Fedora " $HOSTNAME
if [[ $HOSTNAME == "host_with_flatpak" ]]; then
  echo "... set flatpak specific aliases"
  alias gedit='flatpak run org.gnome.gedit'
  alias code='flatpak run com.visualstudio.code'
  alias vim='flatpak run org.vim.Vim'
  alias ros='rpm-ostree status'
  alias roi='rpm-ostree install'
  alias rou='rpm-ostree update'
  alias docker='podman'
fi
fi
# Only run Dropbox on one OS
if [[ $release == *"Arch Linux"* ]]; then
  echo "Arch Linux specific bash"
  if pgrep -x "dropbox" >/dev/null 
  then 
      echo "Dropbox is running" 
  else 
      echo "Dropbox not running, starting"
      $HOME/.dropbox-dist/dropboxd &  >/dev/null 2>&1 
  fi
fi
# If running in TTY mode, increase the font size
if [[ 'tty' =~ ^/dev/tty[0-9]+ ]]
    then setfont /usr/share/kbd/consolefonts/iso02-12x22.psfu.gz &
fi
#Prompt
#PS1="\n\[\e[30;1m\]\[\016\]l\[\017\](\[\e[34;1m\]\u@\h\[\e[30;1m\])-(\[\e[34;1m\]\j\[\e[30;1m\])-(\[\e[34;1m\]\@ \d\[\e[30;1m\])->\[\e[30;1m\]\n\[\016\]m\[\017\]-(\[\[\e[32;1m\]\w\[\e[30;1m\])-(\[\e[32;1m\]\$(/bin/ls -1 | /usr/bin/wc -l | /bin/sed 's: ::g') files, \$(/bin/ls -lah | /bin/grep -m 1 total | /bin/sed 's/total //')b\[\e[30;1m\])--> \[\e[0m\]"
function prompt() {
Black="\e[30m"
Red="\e[31m"
Green="\e[32m"
LightGreen="\e[32;1m"
Blue="\e[34m"
LightBlue="\e[34;1m"
NC="\e[0m" # No Color
PS1="\[$LightGreen\033(0\154\033(B\][\[\033(0\161\161\033(B$Green\][\[$Red\]\u@\h\[$Green\]]\[\033(0\161\033(B\][\[$Red\]\w\[$Green\]]\[\033(0\161\033(B\][\[$Red\]\!\[$Green\]]\[\033(0\161\161\033(B\]]\n\[$LightGreen\033(0\155\161\033(B$Green\][\[$Red\]\#\[$Green\]]\[\033(0\161\033(B\][\[$Red\]\$\[$Green\]]\[\033(0\161\161\033(B\][\[$NC\]"
PS2="> "
}
#prompt

 if [[ "${DISPLAY%%:0*}" != "" ]]; then
    HILIT=${red}   # remote machine: prompt will be partly red
 else
    HILIT=${cyan}  # local machine: prompt will be partly cyan
 fi
#   --> Replace instances of \W with \w in prompt functions below
# + --> to get display of full path name.
 function fastprompt()
 {
    unset PROMPT_COMMAND
    case $TERM in
        *term | rxvt )
            PS1="${HILIT}[\h]$NC \W > \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${HILIT}[\h]$NC \W > " ;;
        *)
            PS1="[\h] \W > " ;;
    esac
 }
 function _powerprompt()
 {
    LOAD=$(uptime|sed -e "s/.*: \([^,]*\).*/\1/" -e "s/ //g")
 }

 function powerprompt()
 {
    PROMPT_COMMAND=_powerprompt
    case $TERM in
        *term | rxvt  )
            PS1="${HILIT}[\A - \$LOAD]$NC\n[\u@\h \#] \W > \
                 \[\033]0;\${TERM} [\u@\h] \w\007\]" ;;
        linux )
            PS1="${HILIT}[\A - \$LOAD]$NC\n[\u@\h \#] \W > " ;;
        * )
            PS1="[\A - \$LOAD]\n[\u@\h \#] \W > " ;;
    esac
 }
 powerprompt     # This is the default prompt -- might be slow.


#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. $HOME/.local/lib/python3.8/site-packages/powerline/bindings/bash/powerline.sh
#

#CopyQ
pkill copyq 
echo Starting CopyQ
copyq & 
#echo Start Windows VM in background 
#vboxmanage startvm "Win 8.1 ENG" --type headless

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
