#!/bin/bash
declare -a enemies_x=('5' '15' '20' '40')
declare -a enemies_y=('1' '2' '3' '4')

craft_x=5
craft_y=20

function render () {
	count=${#enemies_x[@]}
	let "count--"
	for i in `seq 0 $count`
	do
		tput cup ${enemies_y[$i]} ${enemies_x[$i]}
		printf "X"
	done

	tput cup $craft_y $craft_x
	printf "O"
}

function update_enemies () {
	count=${#enemies_x[@]}
	let "count--"
	for i in `seq 0 $count`
	do
		if [ ${enemies_y[$i]} -lt $craft_y ]
		then
			let "enemies_y[$i]+=$RANDOM%2"
		else
			let "enemies_y[$i]-=$RANDOM%2"
		fi

		if [ ${enemies_x[$i]} -lt $craft_x ]
		then
			let "enemies_x[$i]+=$RANDOM%2"
		else
			let "enemies_x[$i]-=$RANDOM%2"
		fi
	done
}



tput civis -- invisible
#tput cnorm -- normal
while true
do
	read -s -t 1 -n 1 key
	case $key in
		w)
			let "craft_y--"
			;;
		a)
			let "craft_x--"
			;;
		s)
			let "craft_y++"
			;;
		d)
			let "craft_x++"
			;;
	esac

	tput clear
	update_enemies
	render
done
exit
