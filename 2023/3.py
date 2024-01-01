with open('input3.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x.rstrip() for x in rows]

def loop_over(i, j, coordinates):
    for row in [i - 1, i, i + 1]:
        for collumn in [j - 1, j, j + 1]:
            if row < 0 or row >= len(puzzle_input) or collumn < 0 or collumn >= len(puzzle_input[row]) or not puzzle_input[row][collumn].isdigit():
                continue
            while collumn > 0 and puzzle_input[row][collumn - 1].isdigit():
                collumn -= 1
            coordinates.add((row, collumn))

def calc(coordinates):
    numbers = []

    for row, collumn in coordinates:
        number = ""
        while collumn < len(puzzle_input[row]) and puzzle_input[row][collumn].isdigit():
            number += puzzle_input[row][collumn]
            collumn += 1
        numbers.append(int(number))

    return numbers

def part_1():
    coordinates = set()

    for i, row in enumerate(puzzle_input):
        for j, char in enumerate(row):
            if char.isdigit() or char == '.':
                continue
            loop_over(i, j, coordinates)

    numbers = calc(coordinates)
    print(f'Part 1: {sum(numbers)}')

def part_2():
    total = 0

    for i, row in enumerate(puzzle_input):
        for j, char in enumerate(row):
            if char != '*':
                continue

            coordinates = set()

            loop_over(i, j, coordinates)
            if len(coordinates) != 2:
                continue

            numbers = calc(coordinates)
            total += numbers[0] * numbers[1]

    print(f'Part 2: {total}')


part_1()
part_2()
