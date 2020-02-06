#!/bin/bash 
#constant
X=1
O=1
ALL_CELL_OCCUPIED=9
#variable
player="O"
flag=0
move=0
echo "Welcome to Tic tac toe"
declare -A board
function initializeBoard()
{
	for((row=0;row<3;row++))
	do
		for((column=0;column<3;column++))
		do
			board[$row,$column]="-"
		done
	done
}
function displayBoard()
{
	for((row=0;row<3;row++))
	do
		for((column=0;column<3;column++))
		do
			echo -n ${board[$row,$column]} " "
		done
		echo -e
	done
}
function toss()
{
	if(( $((RANDOM %2)) == 1))
	then
		player="X"
		echo "player will play first"
	else
		player="O"
	fi
}
function isEmpty()
{
	if [[ ${board[$1,$2]} == "-" ]]
	then
		flag=1
	fi
}
function playerMove()
{
		while (( $flag != 1))
		do
			read -p "provide  row no like 0,1,2" row
			read -p "provide  col no like 0,1,2" column
			if(( $row > 2 && $column > 2))
			then
				echo "Not a valid row or column"
			else
				isEmpty $row $column
			fi
			if (($flag == 1 ))
			then
				board[$row,$column]=$player
				((move++))
				flag=0
			else
				echo "NOT A EMPTY CELL"
				flag=0
			fi

			displayBoard

			if(($ALL_CELL_OCCUPIED == $move))
			then
				exit
			fi
		done
}
initializeBoard
displayBoard
toss
playerMove
