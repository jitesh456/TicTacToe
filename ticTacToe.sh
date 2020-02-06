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
#Initialize Board
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
#displayBoard
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
#Assign letter and decide who will play first
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
#check Empty cell
function isEmpty()
{
	if [[ ${board[$1,$2]} == "-" ]]
	then
		flag=1
	fi
}
#check winner
function checkWinner()
{
	leftDiagonal=0
	rightDiagonal=0
	for((row=0;row<3;row++))
	do
		rowCount=0
		columnCount=0
		for((column=0;column<3;column++))
		do
#row check
			if [[ ${board[$row,$column]} == $player ]]
			then
				((rowCount++))
			fi
#col check
			if [[ ${board[$column,$row]} == $player ]]
			then
				((columnCount++))
			fi
#rightDiagonal
         if [[ $row == $column && ${board[$row,$column]} == $player ]]
         then
            ((rightDiagonal++))
			fi
#left Diagonal
		   if [[ $(($row + $column))==2 && ${board[$row,$column]} == $player ]]
         then
            ((leftDiagonal++))
         fi
			if [[ $rowCount -eq 3 || $columnCount -eq 3 || $rightDiagonal -eq 3 || $leftDiagonal -eq 3 ]]
			then
				echo "Winner"
				exit
			fi
		done
	done
}
# for player  move
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
#check empty  cell
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
			checkWinner
			if (($ALL_CELL_OCCUPIED == $move))
			then
				echo "tie"
				exit
			fi
		done
}

initializeBoard
displayBoard
toss
playerMove
