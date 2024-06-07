import sys
from functools import cache

def part_1():
    total = 0
    puzzle_input = open(sys.argv[1], 'r')

    for line in puzzle_input:
        lhs, rhs = line.split()
        rhs = tuple(map(int, rhs.split(",")))
        total += count(lhs, rhs)

    return total

def part_2():
    total = 0
    puzzle_input = open(sys.argv[1], 'r')

    for line in puzzle_input:
        lhs, rhs = line.split()
        rhs = tuple(map(int, rhs.split(",")))

        lhs = "?".join([lhs] * 5)
        rhs *= 5

        total += count(lhs, rhs)

    return total

@cache
def count(lhs, rhs):
    if lhs == "":
        return 1 if rhs == () else 0

    if rhs == ():
        return 0 if "#" in lhs else 1

    result = 0

    if lhs[0] in ".?":
        result += count(lhs[1:], rhs)

    if lhs[0] in "#?":
        if rhs[0] <= len(lhs) and "." not in lhs[:rhs[0]] and \
            (rhs[0] == len(lhs) or lhs[rhs[0]] != "#"):
            result += count(lhs[rhs[0] + 1:], rhs[1:])
        else:
            result += 0

    return result

print(f"Part 1: {part_1()}")
print(f"Part 2: {part_2()}")
