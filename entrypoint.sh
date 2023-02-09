#!/bin/sh -l

language="$1"
file_list=$(ls -R1 **/*.$language.json)
number_of_checklists=$(echo $file_list | wc -l)
failed_tests=0
while read -r file; do
    echo "Processing $file..."
    all_guids=$(cat $file | jq -r 'try .items[].guid' | wc -l)
    unique_guids=$(cat $file | jq -r 'try .items[].guid' | sort -u | wc -l)
    if [[ "$all_guids" == "$unique_guids" ]]; then
        echo "File $file has $all_guids GUIDs, and all are unique"
    else
        echo "File $file has $all_guids GUIDs, but only $unique_guids are unique"
        failed_tests=$((failed_tests+1))
    fi
done <<< "$file_list"
echo "number_of_checklists=$number_of_checklists" >> $GITHUB_OUTPUT
