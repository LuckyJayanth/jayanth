#!/bin/bash

TAGS_FILE="tags.txt"

# Function to create a tag

create_tag() {
    tag_name=$1
    echo "$tag_name" >> "$TAGS_FILE"
    echo "Tag '$tag_name' created successfully."
}

# Function to list all tags

list_tags() {
    if [ -e "$TAGS_FILE" ];
    then
        echo "List of tags:"
        cat "$TAGS_FILE"
    else
        echo "No tags available."
    fi
}

# Function to delete a tag

delete_tag() {
	 # Function to delete a tag
     tag_name="$1"
    # Check if tag_name is empty
    if [ -z "$tag_name" ];
    then
        echo "Error: Tag name cannot be empty."
        exit 1
    fi
    # Check if the tags file exists
    if [ -e "$TAGS_FILE" ];
    then
        # Remove the tag from the tags file
        grep -v "^$tag_name$" "$TAGS_FILE" > "$TAGS_FILE.tmp"
        mv "$TAGS_FILE.tmp" "$TAGS_FILE"
        echo "Tag '$tag_name' deleted successfully."
    else
        echo "Error: Tag '$tag_name' not found."
        exit 1
    fi
}
# Main script logic
while getopts "t:ld:" opt;
do
	case $opt in
		t) 
			create_tag "$OPTARG"
			;;
		l) 
			list_tags
			;;
		d) 
			delete_tag "$OPTARG"
			;;
		?) 
			echo "Invalid option"
			;;
	esac
done
