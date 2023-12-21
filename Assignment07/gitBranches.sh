#!/bin/bash

list_branches() {
	git branch
}
create_branch() {
	branch_name=$1
	git checkout -b "$branch_name"
}
delete_branch() {
	branch_name=$1
	git branch -d "$branch_name"
}
merge_branches() {
	branch_name1=""
	branch_name2=""
	while [ "$#" -gt 0 ];
	do
		case "$1" in
			-1) 
				branch_name1="$2"
				;;
              		-2) 
				branch_name2="$2"
				;;
			 *) shift;;
		esac
	done
	if [ -n "$branch_name1" ] && [ -n "$branch_name2" ];
	then
		git checkout "$branch_name2"
		git merge "$branch_name1"
	else
		echo "give atleast two branch name"
	fi
}
rebase_branches() {
    local branch_name1=""
    local branch_name2=""
    while [ "$#" -gt 0 ];
    do
	    case "$1" in
		    -1) 
			    branch_name1="$2";
			    shift 2
			    ;;
		    -2) 
			    branch_name2="$2";
			    shift 2
			    ;;
		    *) 
			    shift
			    ;;
        esac
    done
    if [ -n "$branch_name1" ] && [ -n "$branch_name2" ];
    then
        git checkout "$branch_name1"
        git rebase "$branch_name2"
    else
        echo "give atleast two branch name"
    fi
}
while getopts ":lb:d:m:r:" option;
do
	case "$option" in
		l)
			list_branches
			;;
		b)
			create_branch "$OPTARG"
			;;
		d)
			delete_branch "$OPTARG"
			;;
		m)
			merge_branches "$@";
			exit
			;;
		r)
			rebase_branches "$@";
			exit
			;;
		?)
			echo "Invalid option:"
	esac
done
