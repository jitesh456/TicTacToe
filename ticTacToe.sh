#!/bin/bash  -x
#constant
X=1
O=1
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
initializeBoard
displayBoard
toss

