import sys


with open(sys.argv[1]) as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x.rstrip() for x in rows]

def part_1(puzzle):
    directions = puzzle[0]
    nodes = {}

    for line in puzzle[2:]:
        position, node = line.split(" = ")
        nodes[position] = node[1:-1].split(", ")

    steps = 0
    current = "AAA"
    while current != "ZZZ":
        steps += 1
        if directions[0] == "L":
            current = nodes[current][0]
        else:
            current = nodes[current][1]
        
        directions = directions[1:] + directions[0]

    return steps

print(f"Part 1: {part_1(puzzle_input)}")
