# ~/.bash/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.bash/.dircolors && eval "$(dircolors -b ~/.bash/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash/.bash_aliases ]; then
    . ~/.bash/.bash_aliases
fi

 # make bash autocomplete with up arrow 
bind '"\e[A":history-search-backward'
bind '"\e[B":history-search-forward'
 
# make tab cycle through commands instead of listing 
bind '"\t":menu-complete'

## some recommended aliases (http://wiki.archlinux.org/index.php/Core_Utilities#alias)
## modified commands
#alias diff='colordiff'              # requires colordiff package
#alias grep='grep -n --color=auto'   # added -n for line numbers
#alias more='less'
#alias df='df -h'
#alias du='du -c -h'
#alias mkdir='mkdir -p -v'
#alias nano='nano -w'
##alias ping='ping -c 5'
#alias ..='cd ..'
#
## new commands
#alias da='date "+%A, %B %d, %Y [%T]"'
#alias du1='du --max-depth=1'
#alias hist='history | grep $1'      # requires an argument
#alias openports='netstat --all --numeric --programs --inet'
#alias pg='ps -Af | grep $1'         # requires an argument
#
## privileged access
#if [ $UID -ne 0 ]; then
#  alias sudo='sudo '
#  alias scat='sudo cat'
#  alias svim='sudo vim'
#  alias root='sudo su'
#  alias reboot='sudo reboot'
#  alias update='sudo pacman -Syyu'
#  alias install='sudo pacman -S'    # My addition
#  alias netcfg='sudo netcfg2'
#fi
#
## ls
#alias ls='ls -hF --color=always'
#alias lr='ls -R'                    # recursive ls
#alias ll='ls -l'
#alias la='ll -A'
#alias lx='ll -BX'                   # sort by extension
#alias lz='ll -rS'                   # sort by size
#alias lt='ll -rt'                   # sort by date
#alias lm='la | more'
#
## safety features
#alias cp='cp -i'
#alias mv='mv -i'
#alias rm='rm -i'
#
#
## Pacman alias examples (http://wiki.archlinux.org/index.php/Pacman_Tips)
#alias pacupg='sudo pacman -Syu'        # Synchronize with repositories before upgrading packages that are out of date on the local system.
#alias pacin='sudo pacman -S'           # Install specific package(s) from the repositories
#alias pacins='sudo pacman -Up'         # Install specific package not from the repositories but from a file 
#alias pacre='sudo pacman -R'           # Remove the specified package(s), retaining its configuration(s) and required dependencies
#alias pacrem='sudo pacman -Rns'        # Remove the specified package(s), its configuration(s) and unneeded dependencies
#alias pacrep='pacman -Si'              # Display information about a given package in the repositories
#alias pacreps='pacman -Ss'             # Search for package(s) in the repositories
#alias pacloc='pacman -Qi'              # Display information about a given package in the local database
#alias paclocs='pacman -Qs'             # Search for package(s) in the local database
#
#
#
#
#
## colouring man/less (http://wiki.archlinux.org/index.php/Man_Page#Colored_man_pages)
#export LESS_TERMCAP_mb=$(printf "\e[1;37m")
#export LESS_TERMCAP_md=$(printf "\e[1;37m")
#export LESS_TERMCAP_me=$(printf "\e[0m")
#export LESS_TERMCAP_se=$(printf "\e[0m")
#export LESS_TERMCAP_so=$(printf "\e[1;47;30m")
#export LESS_TERMCAP_ue=$(printf "\e[0m")
#export LESS_TERMCAP_us=$(printf "\e[0;36m")
#function env() {
#    exec /usr/bin/env "$@" | grep -v ^LESS_TERMCAP_
#}




#PS1='[\u@\h \W]\$ '   # default value
PROMPT_COMMAND='history -a;'
PS1="\`if [ \$? = 0 ]; then if [ $UID -eq "0" ]; then echo '\[\e[1;35m\]'; else echo '\[\e[1;32m\]'; fi; else echo \[\e[31m\]; fi\`[\u@\h \w]\\$ \[\e[0m\]"

#########################
#Here are the backslash-escape special characters that have meaning to bash:
#
#       \a     an ASCII bell character (07)
#       \d     the date  in  "Weekday  Month  Date"  format
#              (e.g., "Tue May 26")
#       \e     an ASCII escape character (033)
#       \h     the hostname up to the first `.'
#       \H     the hostname
#       \j     the  number of jobs currently managed by the shell
#       \l     the basename of the shell's terminal device name
#       \n     newline
#       \r     carriage return
#       \s     the  name  of  the shell, the basename of $0
#              (the portion following the final slash)
#       \t     the current time in 24-hour HH:MM:SS format
#       \T     the current time in 12-hour HH:MM:SS format
#       \@     the current time in 12-hour am/pm format
#       \u     the username of the current user
#       \v     the version of bash (e.g., 2.00)
#       \V     the release of bash,  version  +  patchlevel
#              (e.g., 2.00.0)
#       \w     the current working directory
#       \W     the  basename  of the current working direcory
#       \!     the history number of this command
#       \#     the command number of this command
#       \$     if the effective UID is 0, a #, otherwise a $
#       \nnn   the character corresponding to the octal number nnn
#       \\     a backslash
#       \[     begin a sequence of non-printing characters,
#              which could be used to embed a terminal control
#              sequence into the prompt
#       \]     end a sequence of non-printing characters
#
#Colours In Bash:
#
#      Black       0;30     Dark Gray     1;30
#      Blue        0;34     Light Blue    1;34
#      Green       0;32     Light Green   1;32
#      Cyan        0;36     Light Cyan    1;36
#      Red         0;31     Light Red     1;31
#      Purple      0;35     Light Purple  1;35
#      Brown       0;33     Yellow        1;33
#      Light Gray  0;37     White         1;37
#
#Here is an example borrowed from the Bash-Prompt-HOWTO:
#
#      PS1="\[\033[1;30m\][\[\033[1;34m\]\u\[\033[1;30m\]@\[\033[0;35m\]\h\[\033[1;30m\]] \[\033[0;37m\]\W \[\033[1;30m\]\$\[\033[0m\] "
#
#This one sets up a prompt like this: 
#      [user@host] directory $
#
#Break down:
#
#      \[\033[1;30m\] - Sets the color for the characters that follow it. Here 1;30 will set them to Dark Gray.
#      \u \h \W \$ - Look to the table above
#      \[\033[0m\] - Sets the colours back to how they were originally.
#########################

export PATH=$PATH:/usr/share/perl5/vendor_perl/auto/share/dist/Cope
export PATH=$PATH:~/.bin
export PATH=$PATH:~/git/git-hooks

# My custom additions
if [ -f ~/.bash/.bashrc_custom ]; then
  . ~/.bash/.bashrc_custom
fi

echo $HOSTNAME | toilet -f future --metal
export EDITOR=vim

# http://gmarik.info/blog/2010/05/02/tracking-dotfiles-with-git
alias .G="git --work-tree=$HOME --git-dir=$HOME/.dotfiles.git"
complete -o default -o nospace -F _git .G # allow git-completion to work with alias aswell
