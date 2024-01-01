with open('input3.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x.rstrip() for x in rows]


def part_1():
    coordinates = set()

    for i, row in enumerate(puzzle_input):
        for j, char in enumerate(row):
            if char.isdigit() or char == '.':
                continue
            for c_row in [i - 1, i, i + 1]:
                for collumn in [j - 1, j, j + 1]:
                    if c_row < 0 or c_row >= len(puzzle_input) or collumn < 0 or collumn >= len(puzzle_input[c_row]) or not puzzle_input[c_row][collumn].isdigit():
                        continue
                    while collumn > 0 and puzzle_input[c_row][collumn - 1].isdigit():
                        collumn -= 1
                    coordinates.add((c_row, collumn))

    numbers = []

    for c_row, collumn in coordinates:
        number = ""
        while collumn < len(puzzle_input[c_row]) and puzzle_input[c_row][collumn].isdigit():
            number += puzzle_input[c_row][collumn]
            collumn += 1
        numbers.append(int(number))

    print(f'Part 1: {sum(numbers)}')


def part_2():
    total = 0

    for i, row in enumerate(puzzle_input):
        for j, char in enumerate(row):
            if char != '*':
                continue

            coordinates = set()

            for c_row in [i - 1, i, i + 1]:
                for collumn in [j - 1, j, j + 1]:
                    if c_row < 0 or c_row >= len(puzzle_input) or collumn < 0 or collumn >= len(puzzle_input[c_row]) or not puzzle_input[c_row][collumn].isdigit():
                        continue
                    while collumn > 0 and puzzle_input[c_row][collumn - 1].isdigit():
                        collumn -= 1
                    coordinates.add((c_row, collumn))

            if len(coordinates) != 2:
                continue

            numbers = []

            for c_row, collumn in coordinates:
                number = ""
                while collumn < len(puzzle_input[c_row]) and puzzle_input[c_row][collumn].isdigit():
                    number += puzzle_input[c_row][collumn]
                    collumn += 1
                numbers.append(int(number))

            total += numbers[0] * numbers[1]

    print(f'Part 2: {total}')

part_1()
part_2()
