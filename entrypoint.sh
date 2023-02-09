#!/bin/sh -l

echo "Hola $1"
time=$(date)
echo "time=$time" >> $GITHUB_OUTPUT
