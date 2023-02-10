#!/bin/sh -l

# Initialization
file_extension="$1"
key_name="$2"
criteria_key="$3"
criteria_value="$4"
file_list=$(eval "ls -R1 */*.$file_extension")
number_of_checklists=$(echo $file_list | wc -l)

# Info message
echo "Running with file_extension=$file_extension, key_name=$key_name, criteria_key=$criteria_key, criteria_value=$criteria_value"

# Check JSON field uniqueness (GUID for azure checklists)
failed_tests=0
performed_tests=0
IFS='
'
for file in $file_list; do
    # Figure out whether we want to process this specific one, if criteria were specified
    process=yes
    if [ -n "$criteria_key" -a -n "$criteria_value" ]; then
        checklist_criteria_value=$(cat $file | jq -r "$criteria_key")
        if [ "$checklist_criteria_value" != "$criteria_value" ]; then
            process=no
        fi
    fi
    if [ "$process" == "yes" ]; then
        performed_tests=$((performed_tests+1))
        # Process file
        echo "Processing $file..."
        all_guids=$(cat $file | jq -r "try .. | objects | select( .$key_name) | .$key_name" | wc -l)
        unique_guids=$(cat $file | jq -r "try .. | objects | select( .$key_name) | .$key_name" | sort -u | wc -l)
        # Compare values
        if [ "$all_guids" -eq "$unique_guids" ]; then
            echo "File $file has $all_guids GUIDs, and all are unique"
        else
            echo "File $file has $all_guids GUIDs, but only $unique_guids are unique"
            failed_tests=$((failed_tests+1))
        fi
    else
        echo "Skipping file $file, not matching criteria ($criteria_key = $criteria_value)"
    fi
done
echo "$performed_tests files verified, $failed_tests FAILED lint checks"
echo "number_of_checklists=$number_of_checklists" >> $GITHUB_OUTPUT
if [ "$failed_tests" -gt 0 ]; then
    exit 1
fi