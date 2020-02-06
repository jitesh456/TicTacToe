#!/bin/bash  
#constant
X=1
O=1
ROW=3
COLUMN=3
ALL_CELL_OCCUPIED=9
#variable
player="O"
computer="O"
flag=0
move=0
turn=0
echo "Welcome to Tic tac toe"
#Initialize Board
declare -A board
function initializeBoard()
{
	for((row=0;row<$ROW;row++))
	do
		for((column=0;column<$COLUMN;column++))
		do
			board[$row,$column]="-"
		done
	done
}
#displayBoard
function displayBoard()
{
	for((row=0;row<$ROW;row++))
	do
		for((column=0;column<$COLUMN;column++))
		do
			echo -n ${board[$row,$column]} " "
		done
		echo -e
	done
}
#Assign letter and decide who will play first
function toss()
{
	if(( $((RANDOM %2)) == $X ))
	then
		player="X"
		echo "player will play first"
	else
		computer="X"
		echo "computer will play first"
	fi
}
#check Empty cell
function isEmpty()
{
	if [[ ${board[$1,$2]} == "-" ]]
	then
		flag=1
		((move++))
	fi
}
#check winner
function checkWinner()
{
	leftDiagonal=0
	rightDiagonal=0
	sign=$1
	for((row=0;row<ROW;row++))
	do
		rowCount=0
		columnCount=0
		for((column=0;column<COLUMN;column++))
		do
#row check
			if [[ ${board[$row,$column]} == $sign ]]
			then
				((rowCount++))
			fi
#col check
			if [[ ${board[$column,$row]} == $sign ]]
			then
				((columnCount++))
			fi
#rightDiagonal
         if [[ $row == $column && ${board[$row,$column]} == $sign ]]
         then
            ((rightDiagonal++))
			fi
#left Diagonal
			if [[ $(($row + $column))==$ROW && ${board[$row,$column]} == $sign ]]
			then
				((leftDiagonal++))
			fi
			if [[ $rowCount -eq $COLUMN || $columnCount -eq $COLUMN || $rightDiagonal -eq $COLUMN || $leftDiagonal -eq $COLUMN ]]
			then
				echo $sign :"Winner"
				exit
			fi
		done
	done
}
# for player  move
function playMove()
{
#check  is empty
	isEmpty $1 $2
	if [[ $flag == 1 ]]
	then
		board[$row,$column]=$3
	fi
}
function playFirst()
{
	if [[ $player == "X" ]]
	then
		playerMove
		turn=$computer
	else
		computerMove
		turn=$player
	fi
	displayBoard
}
function playerMove()
{
	read -p "provide  row no like 0,1,2" row
	read -p "provide  col no like 0,1,2" column
	#check for valid condiation
	if (( $row > $ROW && $column > $COLUMN ))
	then
		echo "Not a valid row or column"
	fi
		playMove $row $column $player
}
function computerMove()
{

	row=$((RANDOM%3))
	column=$((RANDOM%3))
	isEmpty $row $column
	if [[ $flag == 1 ]]
	then
		playMove $row $column $computer
	fi
}
function playFirst()
{
	if [[ $player == "X" ]]
	then
		playerMove
		turn=$computer
	else
		computerMove
		turn=$player
	fi
}
initializeBoard
toss
playFirst
while (( $move != $ALL_CELL_OCCUPIED ))
do
	if [[ $turn == $player ]]
	then
		playerMove
		turn=$computer
	else
		echo "Computer Played"
		computerMove
		turn=$player
	fi
	displayBoard
	checkWinner $computer
	checkWinner $player
	if (($ALL_CELL_OCCUPIED == $move))
	then
		echo "tie"
		exit
	fi
done
