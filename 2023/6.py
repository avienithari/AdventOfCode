import sys


puzzle_input = open(sys.argv[1]).read().split()

def race(times, distances):
    n = 1

    for time, distance in zip(times, distances):
        m = 0
        for hold in range(time):
            if hold * (time - hold) > distance:
                m += 1

        n *= m
    return n

def part_1(puzzle):
    times = list(map(int, puzzle[1:len(puzzle)//2]))
    distances = list(map(int, puzzle[len(puzzle)//2 + 1:]))

    return race(times, distances)

def part_2(puzzle):
    time = list(map(int, ["".join(puzzle[1:len(puzzle)//2])]))
    distance = list(map(int, ["".join(puzzle[len(puzzle)//2 + 1:])]))
    
    return race(time, distance)


print(f"Part 1: {part_1(puzzle_input)}")
print(f"Part 2: {part_2(puzzle_input)}")
