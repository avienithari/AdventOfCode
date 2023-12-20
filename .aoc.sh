#!/bin/zsh


echo "with open('input$1.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x for x in rows]
" >> $1.py
