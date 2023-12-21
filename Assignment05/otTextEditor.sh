#!/bin/bash

# Function to add a line at the top

addLineTop() {
	echo "$2" | cat - "$1" > temp && mv temp "$1"
}

# Function to add a line at the bottom

addLineBottom() {
	echo "$2" >> "$1"
}

# Function to add a line at a specific line number

addLineAt() {
	sed -i "${2}i${3}" "$1"
}

# Function to replace the first occurrence of a word

updateFirstWord() {
	sed -i "0,/$2/s//$3/" "$1"
}

# Function to replace all occurrences of a word

updateAllWords() {
	sed -i "s/$2/$3/g" "$1"
}

# Function to insert a word after another word

insertWord() {
	sed -i "s/\b$2\b/& $3/" "$1"
}

# Function to delete a specific line

deleteLine() {
	sed -i "${2}d" "$1"
}

# Function to delete lines containing a specific word

deleteLineContainingWord() {
	if [ $# -eq 4 ];
	then
		awk "NR==$2 {print}" $1 | grep -w  "$3"
	fi
	if [ $? = 0 ]
	then
		sed -i -e "$2 {/$3/d}" $1
	fi
}

case "$1" in
	"addLineTop")
		addLineTop "$2" "$3"
		;;
	"addLineBottom")
		addLineBottom "$2" "$3"
		;;
	"addLineAt")
		addLineAt "$2" "$3" "$4"
		;;
	"updateFirstWord")
		updateFirstWord "$2" "$3" "$4"
		;;
	"updateAllWords")
		updateAllWords "$2" "$3" "$4"
		;;
	"insertWord")
		insertWord "$2" "$3" "$4" "$5"
		;;
	"deleteLine")
		deleteLine "$2" "$3"
		;;
	"deleteLineContainingWord")
		deleteLineContainingWord "$2" "$3" "$4"
		;;
	*)
		echo "Invalid command $0 use from {addLineTop|addLineBottom|addLineAt|updateFirstWord|updateAllWords|insertWord|deleteLine|deleteLineContainingWord}"
		exit 1
		;;
esac

echo "Operation completed successfully."

