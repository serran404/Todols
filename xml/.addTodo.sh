#!/bin/bash


# I want to add todos

function insert_new_line() {
	parent_line=$1 ; parent_line=$((parent_line + 1))
	string="<$2 $4>$3</$2>"
	sed -i "${parent_line}i${string}" ~/todo/xml/file.xml
}


function locateParent() {
	parent_tag=$1
	if [[ $(grep -c "<$2" ~/todo/xml/file.xml ) -eq 0 ]]; then
		line_number=$( sed -n "/<${parent_tag}[[:space:]>]/=" ~/todo/xml/file.xml)
		[[ -n $line_number ]] && ( \
		createParent ${line_number} ;
		insert_new_line ${line_number} "$2" "$3" "$4" ) ||
		( echo "That tag does not exist" ; exit 1 )

	else
		echo "This tag is already in use" ; exit 2 
	fi
}


function createParent() {
	# creates a parent if it is not one
	local line_number=$1
	line_number=$(($line_number+0))
	sed -i "${line_number}s|</|\\
</|g" ~/todo/xml/file.xml	
}


function addTodo() {
	local parent
	local tag
	local todo
	local attr
	echo -n "Parent:"
	read parent
	echo -n "Tag:"
	read tag
	[[ -z "$tag" ]] && tag="${parent}1" # change 1 to amount of tags
	echo -n "Todo:"
	read todo
	# read attributes
	keepReading=true
	while [[ $keepReading == true ]]; do
		echo -n "(%q to exit) Attribute name:"
		read attr_name
		[[ $attr_name == %q ]] && keepReading=false ||
		{ echo -n "Attribute value:" ; read attr_val ; attr="$attr $attr_name=\"$attr_val\"" ; }
	done
	locateParent "$parent" "$tag" "$todo" "${attr}"
}


