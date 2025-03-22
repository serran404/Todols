#!/bin/bash

# clearing todo
# search for tag, change the prio to "klar"


function clearTodo() {
	local tag=$1
	local line_number=$(sed -n "/<$tag[[:space:]>]/=" ~/todo/xml/file.xml)
	sed -i "${line_number}s/\(<$tag[^>]*\bprio=\"\)[^\"]*\"/\1klar\"/" ~/todo/xml/file.xml
}

function changeTodo() {
	local tag=$1
	local new_prio=$2
	local line_number=$(sed -n "/<$tag/=" ~/todo/xml/file.xml)
	sed -i "${line_number}s/\(<$tag[^>]*\bprio=\"\)[^\"]*\"/\1${new_prio}\"/" ~/todo/xml/file.xml
}

function remove_all_cleared_todo() {
	local tag=
	source ~/todo/xml/.removeTodo.sh
	while [[ $( grep -c '<.\+ prio="klar"' ~/todo/xml/file.xml ) != 0 ]]; do
		tag=$( grep -m 1 '<.\+ prio="klar"' ~/todo/xml/file.xml | sed -n 's/^<\([^ >]*\).*/\1/p')
		removeTodo "$tag"
	done
}
