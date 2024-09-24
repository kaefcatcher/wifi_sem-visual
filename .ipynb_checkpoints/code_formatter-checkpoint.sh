#!/bin/bash

while [[ "$#" -gt 0 ]]; do
    case $1 in
        --name) notebook="$2"; shift ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

if [ -z "$notebook" ]; then
    echo "Error: No notebook file provided. Use --nameoffile <filename>"
    exit 1
fi

basename=$(basename "$notebook" .ipynb)

echo "Converting $notebook to a Python script..."
jupyter nbconvert --to script "$notebook"
echo "Formatting $basename.py with autopep8..."

autopep8 --in-place --aggressive --aggressive "$basename.py"

echo "The Python script has been formatted and saved as $basename.py"

p2j "$basename.py" -o

echo "The Python script has been converted back to ipynb"