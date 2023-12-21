#!/bin/bash


case $1 in
	"addDir")
		mkdir -p "$2/$3"
		;;
        "deleteDir")
		if [ -d "$2/$3" ]; then
			rm -r "$2/$3"
		else
			echo "Directory not found: $2/$3"
		fi
		;;
	"listFiles")
                if [ -d "$2/$3" ]; then
			find "$2/$3" -type f
                else
                        echo "Directory not found: $2/$3"
                fi
                ;;
        "listDirs")
                if [ -d "$2/$3" ]; then
                        find "$2/$3" -type d
                else
                        echo "Directory not found: $2/$3"
                fi
                ;;
        "listAll")
                if [ -d "$2/$3" ]; then
                        find "$2/$3"
                else
                        echo "Directory not found: $2/$3"
                fi
                ;;
        "addFile")
                touch "$2/$3"
                ;;
        "addContentToFile")
                if [ -f "$2/$3" ]; then
                        echo "$4" >> "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "addContentToFileBegining")
                if [ -f "$2/$3" ]; then
                        echo "$4" | cat - "$2/$3" > temp && mv temp "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "showFileBeginingContent")
                if [ -f "$2/$3" ]; then
                        head -n "$4" "$2/$3"
		else
                        echo "File not found: $2/$3"
                fi
                ;;
        "showFileEndContent")
                if [ -f "$2/$3" ]; then
                        tail -n "$4" "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "showFileContentAtLine")
                if [ -f "$2/$3" ]; then
                        awk "NR==$4" "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "showFileContentForLineRange")
                if [ -f "$2/$3" ]; then
                        awk "NR>=$4 && NR<=$5" "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "moveFile")
                if [ -f "$2/$3" ]; then
                        mv "$2/$3" "$4"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "deleteFile")
                if [ -f "$2/$3" ]; then
                        rm "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "copyFile")
                if [ -f "$2/$3" ]; then
                        cp "$2/$3" "$4"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        "clearFileContent")
                if [ -f "$2/$3" ]; then
                        : > "$2/$3"
                else
                        echo "File not found: $2/$3"
                fi
                ;;
        *)
                        echo "Invalid command";;
esac

