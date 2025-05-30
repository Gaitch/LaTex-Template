#!/bin/bash

# Create output directory if it doesn't exist
mkdir -p output

# First LaTeX pass
lualatex -shell-escape -output-directory=output "$1"

# Extract the filename without extension
BASENAME=$(basename "$1" .tex)

# Run biber only if --bib or --full is provided
if [[ "$2" == "--bib" || "$2" == "--full" ]]; then
    biber output/"$BASENAME"
fi

# Run second and third passes only if --full is provided
if [[ "$2" == "--full" ]]; then
    lualatex -shell-escape -output-directory=output "$1"
    lualatex -shell-escape -output-directory=output "$1"
fi

# Move final PDF to the main directory
mv output/*.pdf .

