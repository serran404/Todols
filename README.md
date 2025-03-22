# TODOLS

## A todolist manager

I wanted to have a working todolist but struggled to make anything worked, so I started making my own in bash to get something perfect for myself but also to learn bash.

## `todo.sh`

The `todo.sh` file is very simple, and I use it as a placeholder for the actual program. The ideas I have are listed in a somewhat free way, hopefully they are understandable. I am unaware if they are able to make in my freetime but hopefully they will be added to the program. I am right now not working on the project, but using it every day.

# Example

        > todols
        TODO List:
        ==========
        1. Make a github repo
        2. Study for the exam

where the todos are colored based on the last word in the `todo.txt` file.

| Keyword       | Color         |
| ------------- | ------------- |
| viktig        | Red           |
| medel         | Yellow        |
| lite          | Cyan          |
| övrigt        | Magenta       |
| klar		| Green		|

These are swedish words, I suggest changing them if you plan to use this at this early stage.

## Wrapper

The wrapper has a few options that are

> -a, --add=tag

The tag to be added. 

> -p, --parent_tag=tag

The tag of the parent which the new tag should be placed under.

> -r, --remove=tag

Tag to be removed, if this is a parent tag it will ask if you wish to remove its children as well.

> -h, --help

This does nothing.

> -P, --prio=keyword

The coloring of the tag, the keyword is one of the above

> -d, --due_date=DD/MM/YY

Sets a due date and will show days remaining, eg. 2 dagar kvar. Whenever this is negative it will be shown in caps except if it has the priority klar, when its done; the countdown does not disappear though.

> -c, --clear_todo=tag

Makes a todo cleared which means it has the priority klar, eg. done. 

> -C, --change_tag=tag

Changes the priority of a specific tag.

> -R, --remove_all_cleared

This removes all tags with the priority klar. It removes all todos that are complete.

