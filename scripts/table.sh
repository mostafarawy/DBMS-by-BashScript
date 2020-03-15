#!/bin/bash

while [ true ]
do 

echo -n "$name:-> "
read var
sentence=($var) 
#echo ${sentence[0]} ${sentence[1]}
if [[ ${sentence[0]} = "create" && ${sentence[1]} = "table" && ${sentence[3]} = "(" && ${sentence[-1]} = ")" ]]
then

	if [[ -f  ${sentence[2]}.csv ]]
	then
		echo "Table is already existing"
	else
		touch ${sentence[2]}.csv
		touch ${sentence[2]}.metadata
		. ../../scripts/word.sh
		echo "Table is Created" 
	fi

elif [[ ${sentence[0]} = "insert" && ${sentence[1]} = "into" && ${sentence[3]} = "values" && ${sentence[4]} = "(" && ${sentence[-1]} = ")" ]]
then
	if [[ -f  ${sentence[2]}.csv ]]
	then
		. ../../scripts/insertcut.sh
		echo "Data is Inserted" 
	else
		echo "**Table ${sentence[2]} is not found**"
	fi

elif [[ ${sentence[0]} = "select" && ${sentence[1]} = "all" && ${sentence[2]} = "from" ]]
then
	if [[ -f  ${sentence[3]}.csv ]]
	then
		. ../../scripts/select.sh
	else
		echo "**Table ${sentence[3]} is not found**"
	fi


elif [[ ${sentence[0]} = "drop" && ${sentence[1]} = "table" ]]
then
	if [[ -f  ${sentence[2]}.csv ]]
	then
		rm ${sentence[2]}.csv
		rm ${sentence[2]}.metadata
	else
		echo "**Table ${sentence[2]} is not found**"
	fi
elif [ ${sentence[0]} = "back" ]
then
	$clear

elif [ ${sentence[0]} = "back" ]
then
	`cd $currnet`
	. ./main.sh

else
	echo "**You entered invalid command**"
fi
done 
