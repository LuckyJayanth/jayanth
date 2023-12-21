#!/bin/bash

# Check if template file and key-value pairs are provided
if [ "$#" -lt 2 ];
then
	echo "Usage: $0 <template_file> key1=value1 key2=value2"
	exit 1
fi

# Get template file and shift arguments

template_file="$1"

shift

# Read the template content

template_content=$(<"$template_file")

# Loop through key-value pairs and replace variables in the template

while (( "$#" ));
do
  # Split key and value
  IFS='=' read -r key value <<< "$1"

  # Replace variable in the template
  template_content=${template_content//"{{$key}}"/$value}

  shift
done

# Print the modified template
echo "$template_content"

