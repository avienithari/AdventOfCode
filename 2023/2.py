from collections import defaultdict


with open('input2.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x for x in rows]

elf_cubes = {'red': 12, 
             'green': 13, 
             'blue': 14}

ids = 0
power = 0

for line in puzzle_input:
    counter = True
    id, line = line.split(':')
    vector = defaultdict(int)
    for draw in line.split(';'):
        for event in draw.split(','):
            n, cube = event.split()
            n = int(n)
            vector[cube] = max(vector[cube], n)
            if int(n) > elf_cubes.get(cube, 0):
                counter = False
    score = 1
    for v in vector.values():
        score *= v
    power += score

    if counter:
        ids += int(id.split()[-1])

print(f'Sum of these Ids is: {ids}')
print(f'Power of these Ids is: {power}')
