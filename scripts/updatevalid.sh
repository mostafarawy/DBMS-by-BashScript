#!/bin/bash

input=${sentence[@]}
all=`awk -F " " '{if ($2 != ""){print $1}}' ${sentence[1]}.metadata`
Data=($all)

in=`echo $input | awk -F "set" '{print $2}' | awk -F "where" '{print $1}' | awk -F "=" '{print $1}'`
inputData=($in)

in=`echo $input | awk -F "set" '{print $2}' | awk -F "where" '{print $1}' | awk -F "=" '{print $2}'`
inputData2=($in)

flag2="false"
flag="false"
if [[ "${sentence[-3]}" == "${Data[0]}"  ]] 
then
	for ((i=0; i<=${#Data[@]};i++))
	do

			if [[ "${inputData[0]}" == "${Data[i]}" ]]
			then
				m=$(($i+1))
				flag="true"
			fi
		done
else
printf "there is no column with name  ${sentence[-3]} \n"
fi

con=`awk -v ve="$m" -F " " ' NR==ve {if ($2 != ""){print $2}}' ${sentence[1]}.metadata`
val=($con)

printf ${val[0]}
printf $flag


	if [[ ${val[0]} == "text" && $flag == "true" ]]
		then
			    
			if [[ ${inputData2[0]} =~ ^[a-zA-Z0-9]+$ && ${inputData2[0]} != '' ]]
			then
				
				flag2="true"
			else
				flag2="false"
				flag="false"
			fi
		elif [[ ${val[0]} == "int"  && $flag == "true" && ${inputData2[0]} != '' ]]
		then
				printf "in condition3"
			if [[ ${inputData2[0]} =~ ^[0-9]+$ ]]
			then
				flag2="true"
				
				
			else
				flag2="false		"
				flag="false"
			fi
		
fi



if [[ $flag == "true" && $flag2 == "true" ]]
then
. ../../scripts/update.sh 
else
        echo "no column with name ${inputData[0]} or data not valid  "
fi
