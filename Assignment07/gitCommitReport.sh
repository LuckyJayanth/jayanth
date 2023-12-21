#!/bin/bash

while getopts "u:d:" opt;
do
	case $opt in
		u)
			repo_url="$OPTARG"
			;;
		d)
			days="$OPTARG"
			;;
		\?)
			echo "Invalid option: -$OPTARG" >&2
			exit 1
			;;
		:)
			echo "Option -$OPTARG requires an argument." >&2
			exit 1
			;;
	esac
done

if [ -z "$repo_url" ] || [ -z "$days" ]; then
  echo "Usage: $0 -u <repo_url> -d <days>"
  exit 1
fi

# Clone the repository
repo_name=$(basename "$repo_url" .git)
git clone "$repo_url" "$repo_name" || { echo "Error: Unable to clone the repository."; exit 1; }

# Navigate to the repository
cd "$repo_name" || { echo "Error: Unable to navigate to the repository."; exit 1; }

# Get commits for the last specified days
commits=$(git log --since="$days days ago" --pretty=format:"%h|%an|%ae|%s" --date=local)

# Generate CSV header
echo "Commit Id,Author Name,Author Email,Commit Message" > commit_report.csv

# Iterate through commits and extract information
while IFS= read -r line; do
  IFS='|' read -ra commit_info <<< "$line"
  commit_id="${commit_info[0]}"
  author_name="${commit_info[1]}"
  author_email="${commit_info[2]}"
  commit_message="${commit_info[3]}"
  
  # Optional: Check if the commit message starts with the pattern "JIRA-XXXX:"
  if [[ $commit_message =~ ^JIRA-[0-9]+: ]]; then
    validity="Valid"
  else
    validity="Invalid"
  fi
  
  # Append information to the CSV file
  echo "$commit_id,$author_name,$author_email,\"$commit_message\",$validity" >> commit_report.csv
done <<< "$commits"

echo "Commit report generated successfully: commit_report.csv"

