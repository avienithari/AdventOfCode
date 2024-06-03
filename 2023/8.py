import sys
from math import gcd


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

def part_2(puzzle):
    nodes = {}
    steps = puzzle[0]

    for line in puzzle[2:]:
        position, node = line.split(" = ")
        nodes[position] = node[1:-1].split(", ")

    positions = [key for key in nodes if key.endswith("A")]
    cycles = []

    for current in positions:
        cycle = []

        current_steps = steps
        step_count = 0
        first_z = None

        while True:
            while step_count == 0 or not current.endswith("Z"):
                step_count += 1
                current = nodes[current][0 if current_steps[0] == "L" else 1]
                current_steps = current_steps[1:] + current_steps[0]

            cycle.append(step_count)

            if first_z is None:
                first_z = current
                step_count = 0
            elif current == first_z:
                break

        cycles.append(cycle)

    nums = [cycle[0] for cycle in cycles]

    lcm = nums.pop()

    for num in nums:
        lcm = lcm * num // gcd(lcm, num)

    return lcm

print(f"Part 1: {part_1(puzzle_input)}")
print(f"Part 2: {part_2(puzzle_input)}")
