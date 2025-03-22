#!/bin/bash 
# More safety, by turning some bugs into errors.  set -o errexit -o pipefail -o noclobber -o nounset
source ~/todo/xml/.removeTodo.sh
source ~/todo/xml/.addTodo.sh
source ~/todo/xml/.parser.sh
source ~/todo/xml/.clearTodo.sh
# ignore errexit with `&& true`
getopt --test > /dev/null && true
if [[ $? -ne 4 ]]; then
    echo 'I’m sorry, `getopt --test` failed in this environment.'
    exit 1
fi

# option --output/-o requires 1 argument
LONGOPTS=add:,parent_tag:,remove:,help,prio:,due_date:,clear_todo:,change_tag:,remove_all_cleared
OPTIONS=a:p:r:hP:d:c:C:R

# -temporarily store output to be able to check for errors
# -activate quoting/enhanced mode (e.g. by writing out “--options”)
# -pass arguments only via   -- "$@"   to separate them correctly
# -if getopt fails, it complains itself to stdout
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTS --name "$0" -- "$@") || exit 2
# read getopt’s output this way to handle the quoting right:
eval set -- "$PARSED"
a=n
p=n
r=n
h=n
P=n
d=n
c=n
C=n
R=n

add_tag=-
remove_tag=-
clear_tag=-
change_tag=-
parent_tag=-
prio=-
due_date=-
# echo "PARSED: $PARSED"

# now enjoy the options in order and nicely split until we see --
while true; do
    case "$1" in
        -a|--add)
		a=y
            	add_tag="$2"
            	shift 2
            	;;
        -p|--parent_tag)
		p=y
		# dont do to much
		parent_tag="$2"
            	shift 2
            	;;
        -r|--remove)
		r=y
		# remove todo with
		remove_tag="$2"
		# removeTodo $tag
            	shift 2
            	;;
        -h|--help)
		h=y
		echo "some helpful info"
            	shift
           	;;
	-P|--priority)
		P=y
		prio="$2"
		shift 2
		;;
	-d|--due_date)
		d=y
		due_date="$2"
		shift 2
		;;
	-c|--clear_tag)
		c=y
		clear_tag="$2"
		shift 2
		;;
	-C|--change_prio)
		C=y
		change_tag="$2"
		shift 2
		;;
	-R|--remove_all_cleared)
		R=y
		shift
		;;
        --)
            shift
            break
            ;;
        *)
            echo "Programming error"
            exit 3
            ;;
    esac
done

# now lets do what they want



if [[ $a == y ]]; then
	# if they are simply - use "" for prio and due date and make root the owner of the todo
	[[ ! $p == y ]] && parent_tag="root"
	[[ ! $d == y ]] && due_date=""
	todo=
	echo -n "To-do title:"
	read todo
	attr="prio=\"$prio\" datum=\"$due_date\""
	locateParent "$parent_tag" "$add_tag" "$todo" "${attr}"
fi
if [[ $r == y ]]; then
	# remove the tag
	echo "Removing todo: $remove_tag"
	removeTodo $remove_tag
fi
if [[ $c == y ]]; then
	# clear tag
	clearTodo $clear_tag
fi
if [[ $C == y ]]; then
	#change prio
	new_prio=
	echo -n "New priority: "
	read new_prio
	changeTodo "$change_tag" "$new_prio"
fi
if [[ $R == y ]]; then
	remove_all_cleared_todo
fi

[[ $h == n ]] && xml_parser
