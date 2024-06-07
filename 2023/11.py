import sys

puzzle_input = open(sys.argv[1], 'r').read().split()

empty_rows = [r for r, row in enumerate(puzzle_input) if all(ch == "." for ch in row)]
empty_col = [c for c, col in enumerate(zip(*puzzle_input)) if all(ch == "." for ch in col)]
points = [(r, c) for r, row in enumerate(puzzle_input) for c, ch in enumerate(row) if ch == "#"]

def observatory(scale):
    total = 0

    for i, (r1, c1) in enumerate(points):
        for (r2, c2) in points[:i]:
            for r in range(min(r1, r2), max(r1, r2)):
                total += scale if r in empty_rows else 1
            for c in range(min(c1, c2), max(c1, c2)):
                total += scale if c in empty_col else 1

    return total

print(f"Part 1: {observatory(2)}")
print(f"Part 2: {observatory(1000000)}")
