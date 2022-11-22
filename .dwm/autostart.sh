#!/bin/bash
systemctl --user start sxhkd &
~/.fehbg &

debug=-1
launcher='st -e tmux new & qutebrowser & nextcloud --background &'

cmatrixcolor=("green" "red" "blue" "white" "yellow" "cyan" "magenta" "black")

screen=(
#0
"st -e cmatrix -C  ${cmatrixcolor[$(($RANDOM % ${#cmatrixcolor[@]}))]} -s  " 
#1
"st -e tty-clock -c -S -C $(( $RANDOM % 8 )) -b " 	
#2
"st -e tmux new 'fortune | cowsay -f $(ls /usr/share/cowsay/cows/ | shuf -n1) | lolcat  && read ' "
#3
"st -e aafire "
#4
"st -e tmux new 'neofetch && read ' "
#5
"st -e tmux new 'curl -H \"Accept-Language: fr\" wttr.in/$(sh ~/.location.sh) && read ' "
#6
"st -e tmux new 'cbonsai --live && read ' "
)

if [[ "$debug" !=  -1 ]];
then
	if [[ "$debug" == 99 ]];
	then
		debug=$(( $RANDOM % ${#screen[@]} ))
	fi
	
	notify-send "Screen" "${screen[$debug]}" -t 5000 &
	eval "${screen[$debug]} && (eval $launcher ) "
else

	eval "${screen[$(( $RANDOM % ${#screen[@]} ))]} && (eval $launcher ) "
fi

