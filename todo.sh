#!/bin/bash

# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

declare -A urgencies=(["viktig"]=${RED} ["medel"]=${YELLOW} ["lite"]=${CYAN} ["övrigt"]=${MAGENTA} ["klar"]=${GREEN})

# Check if the input file is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <todo_file>"
    exit 1
fi

# Read the input file
todo_file=$1

# Check if the file exists
if [ ! -f "$todo_file" ]; then
    echo "Error: File '$todo_file' not found!"
    exit 1
fi

# Output the todo list
echo -e "\n${GREEN}TODO List:${RESET}"
echo "=========="

line_number=1
while IFS= read -r line; do
	last_word=$(echo "$line" | awk '{print $NF}')
	last_word=$(echo "$last_word" | xargs)
	line_without_last_word=$(echo "$line" | awk '{$NF=""; print $0}' | xargs)
	color=${urgencies[$last_word]:-${RESET}}
	echo -e "${RESET}$line_number. ${color}$line_without_last_word${RESET}"
	line_number=$((line_number + 1))
done < "$todo_file"

echo -e ""

