#!/bin/sh -l

language="$1"
file_list=$(ls -R1 **/*.$language.json)
number_of_checklists=$(echo $file_list | wc -l)
echo "number_of_checklists=$number_of_checklists" >> $GITHUB_OUTPUT
