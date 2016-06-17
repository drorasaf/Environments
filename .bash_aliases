# some more ls aliases
alias ll='ls -l'
alias la='ls -A'
# alias l='ls -CF'
alias cvs='cvs -q'
alias jgrep='jcvs grep --color=auto'
alias commit='export COMMIT=1'
alias uncommit='export COMMIT=0'
alias cif='cvsdiff'
alias ls='ls --color=auto'
alias o='xdg-open'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'

#alias grep='grep --color=auto'
#alias fgrep='fgrep --color=auto'
#alias egrep='egrep --color=auto'
#auto profile alias in windows
alias wdiff='g -df'
alias up='cvs -q up -dP'
alias jup='jcvs up'
alias c='clear'
# alias rd='review data'
# alias rf='review from_me'
# alias re='review edit'
# alias wd='cd $HOME/src/$UW'
# alias dc='cd $HOME/src/$DC'
alias difflist='up | grep -v \? | grep -v dirs | sed "s/[MUA ]//g" > q'
alias vdiff='cat q | xargs -n1 cvsdiff'

alias linux='cd /usr/src/linux'
# easy disp
#alias disp='export DISPLAY=10.71.2.41:0.0'

#for easier cfg manipulation
alias cfg="cat config/.archconfig | awk -F= '{print \$2}'"
