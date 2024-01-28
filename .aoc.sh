#!/bin/zsh


echo "import sys

puzzle_input = open(sys.argv[1], 'r').read().split()
for line in puzzle_input:
    print(line)

" >> $1.py

touch input$1.txt
