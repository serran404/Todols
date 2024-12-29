#!/bin/bash

# here I will remove todos
# I'll search for the start tag, writing down the line number
# then search for the end tag, noting the line number
# then delete everything between these lines
# if the line numbers don't match we can ask for confirmation

function removeTodo() {
	# ask for tag to remove
	# delete that todo
	local tag
	echo -n "Tag for todo to remove:"
	read tag
	local start_line=$(sed -n "/<${tag}[ >]/=" ~/todo/xml/file.xml) 
	local end_line=$(sed -n "/<\/${tag}>/=" ~/todo/xml/file.xml)
	echo $start_line
	echo $end_line
	deleteLines $start_line $end_line
}

function deleteLines() {
	# input: 2 lines, delete those lines and everything in between
	# if the lines mismatch ask for confirmation
	local start_line=$1
	local end_line=$2
	if [[ $start_line = $end_line ]]; then
		sed "${start_line}d" ~/todo/xml/file.xml
	elif [[ $start_line < $end_line ]]; then
		# ask for confirmation
		local answer
		echo -n "This contains multiple todos.\nDo you still wish to remove this tag and all its children? (yes/no): "
		while :; do
			read answer
			if [[ $answer = no ]]; then
				echo "Aborting deletion" ; break 
			elif [[ $answer = yes ]]; then
				echo "Proceeding with deletion" ; break
				for (( line=$start_line; line<=$end_line; line++ )); do # does not enter loop
					echo "in for loop"
					sed "${line}d" ~/todo/xml/file.xml
				done
			else 
				echo "Please write either yes or no: "
			fi
		done
	fi
}

