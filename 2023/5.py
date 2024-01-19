with open('input5.txt', 'r') as puzzle:
    rows = puzzle.read().split("\n\n")
    puzzle_input = [x for x in rows]

def part_1(puzzle):
    seeds, *blocks = puzzle
    seeds = list(map(int, seeds.split(":")[1].split()))

    for block in blocks:
        ranges = []
        for line in block.splitlines()[1:]:
            a, b, c = map(int, line.split())
            ranges.append((a, b, c))
        values = []
        for seed in seeds:
            for a, b, c in ranges:
                if b <= seed < b + c:
                    values.append(seed + a - b)
                    break
            else:
                values.append(seed)
        seeds = values

    return min(seeds)

def part_2(puzzle):
    inputs, *blocks = puzzle
    inputs = list(map(int, inputs.split(":")[1].split()))
    seeds = []

    for i in range(0, len(inputs), 2):
        seeds.append((inputs[i], inputs[i] + inputs[i + 1]))

    for block in blocks:
        ranges = []
        for line in block.splitlines()[1:]:
            ranges.append(list(map(int, line.split())))
        values = []
        while seeds:
            start, end = seeds.pop()
            for a, b, c in ranges:
                over_start = max(start, b)
                over_end = min(end, b + c)
                if over_start < over_end:
                    values.append((over_start + a - b, over_end + a -b))
                    if over_start > start:
                        seeds.append((start, over_start))
                    if end > over_end:
                        seeds.append((over_end, end))
                    break
            else:
                values.append((start, end))
        seeds = values

    return min(seeds)[0]

print(f"Part 1: {part_1(puzzle_input)}")
print(f"Part 2: {part_2(puzzle_input)}")
