import sys

with open(sys.argv[1]) as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x.rstrip() for x in rows]

def part_1(array):
    if all(x == 0 for x in array):
        return 0

    deltas = []
    for x, y in zip(array, array[1:]):
        deltas.append(y - x)

    diff = part_1(deltas)

    return array[-1] + diff

def part_2(array):
    if all(x == 0 for x in array):
        return 0

    deltas = []
    for x, y in zip(array, array[1:]):
        deltas.append(y - x)

    diff = part_2(deltas)

    return array[0] - diff

def total(puzzle):
    first_part = 0
    second_part = 0

    for line in puzzle:
        nums = list(map(int, line.split()))
        first_part += part_1(nums)
        second_part += part_2(nums)

    return first_part, second_part

print(f"Part 1: {total(puzzle_input)[0]}")
print(f"Part 2: {total(puzzle_input)[1]}")
