with open('input4.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x.rstrip() for x in rows]


def split_input(line):
    start_index = line.index(":")
    end_index = line.index("|")
    left = line[start_index + 1:end_index].split(" ")
    right = line[end_index + 1:].split(" ")

    return left, right


def part_1():
    points = 0
    card_points = []
    for line in puzzle_input:
        counter = 0
        left, right = split_input(line)
        for number in right:
            if number == "":
                continue
            elif number in left:
                counter += 1

        if counter == 1:
            card_points.append(1)
        elif counter > 1:
            points += 1
            for i in range(1, counter):
                points *= 2

            card_points.append(int(points))
            points = 0

    print(f"Part 1: {sum(card_points)}")


def part_2():
    map = {}
    for i, line in enumerate(puzzle_input):
        if i not in map:
            map[i] = 1

        left, right = split_input(line)
        counter = 0
        for number in right:
            if number == "":
                continue
            elif number in left:
                counter += 1

        for next in range(i + 1, i + counter + 1):
            map[next] = map.get(next, 1) + map[i]

    print(f"Part 2: {sum(map.values())}")

part_1()
part_2()
