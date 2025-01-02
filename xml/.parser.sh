#!/bin/bash
# Define color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[0;33m'
MAGENTA='\033[0;35m'
RESET='\033[0m'

declare -A urgencies=(
    ["viktig"]=${RED}
    ["medel"]=${YELLOW}
    ["lite"]=${CYAN}
    ["övrigt"]=${MAGENTA}
    ["klar"]=${GREEN}
)

function read_xml() {
	local IFS=\>
	read -d \< ENTITY CONTENT
}
function parser_attributes() {
	for part in "${parts[@]}"; do
		if [ ${missingStringEnd} = false ] ; then
			# what happens when I do not have a tag?
			IFS="=" read -ra subparts<<<"$part"
			attr="${subparts[1]}"
			if [ -n "$attr" ] && [ ${attr: -1} = "\"" ]; then 
				attributes[${subparts[0]}]=${subparts[1]}
			elif [ -n "$attr" ] && [ ${attr:0:1} = "\"" ]; then
				missingStringEnd=true
				key=${subparts[0]}
			fi					
		elif [ ${part: -1} = "\"" ]; then
			attr="${attr} ${part}"
			attributes["${key}"]="${attr}"
			missingStringEnd=false
		else
			attr="$attr $part"
		fi
		# extract different elements and stor in hashmap that 
		# is stored in another map with the tag, eg. root
	done
}
declare -A attribute_hashes=( )
missingStringEnd=false
key=""
declare -a tag_stack=()
indent_level=0
counter=0
echo ""
echo -e "${GREEN}TODO list:${RESET}"
echo "=========="
while read_xml; do
	CONTENT=$(echo ${CONTENT})
	IFS=" " read -ra parts <<< "$ENTITY"
	declare -A attributes=( )
	if [ ${#tag_stack[@]} != 0 ] && [[ ${ENTITY} =~ ^/ ]]; then
		# this is a closing </tag>
		# check if it is righfully closed
		if [[ ${tag_stack[-1]} == "${ENTITY:1}" ]]; then
			unset tag_stack[-1] # removes last element
			((indent_level--))  # move one step back in hierarchy
		else
			echo "unclosed tagname: ${tag_stack[-1]}"
		fi
	else
		# this is an opening <tag>
		# get the attributes
		parser_attributes

		# check if the attributes are stored, if not we store them
		[[ -n ${parts[0]} ]] && 
		[[ ! -n ${attribute_hashes[${parts[0]}]} ]] && 
		attribute_hashes[${parts[0]}]=attributes
		# acces via: declare -n ref=${attribute_hashes[tag]}

		if [ ${#tag_stack[@]} != 0 ] && [[ ${tag_stack[-1]} != ${ENTITY} ]]; then
			# this is a child to the parent tag_stack[-1]
			# rest of actions on children
			# print the content and the tag with the color stored in attributes[prio]
			counter=$((counter+1))

			prio=${RESET}
			[[ -n ${attributes["prio"]} ]] && prio=${attributes["prio"]}
			color=${urgencies["${prio:1:-1}"]:-${RESET}}
			tabs=$(printf "%${indent_level}s")
			echo -e "${counter}.$color ${tabs// /'    '}${CONTENT}  [${parts[0]}]  [${attributes["datum"]:-""}]${RESET}"

			((indent_level++)) # next is indented further
		fi
		tag_stack+=(${parts[0]}) # add the tag, always first word in <tag attributes>

	fi
	if [[ ${missingStringEnd} = true ]]; then 
		echo "string tog inte slut"
       	fi
done < ~/todo/xml/file.xml # sends file.xml to stdin
echo ""
