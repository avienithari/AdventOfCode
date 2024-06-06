import sys
from collections import deque

def get_data():
    puzzle_input = open(sys.argv[1], 'r').read().split()
    for r, row in enumerate(puzzle_input):
        for c, ch in enumerate(row):
            if ch == "S":
                starting_row = r
                starting_column = c
                break
        else:
            continue
        break

    seen = {(starting_row, starting_column)}
    queue = deque([(starting_row, starting_column)])

    return puzzle_input, seen, queue

def part_1():
    puzzle, seen, queue = get_data()

    while queue:
        r, c = queue.popleft()
        ch = puzzle[r][c]

        if r > 0 and ch in "S|JL" and puzzle[r - 1][c] in "|7F" and (r - 1, c) \
            not in seen:
                seen.add((r - 1, c))
                queue.append((r - 1, c))

        if r < len(puzzle) - 1 and ch in "S|7F" and puzzle[r + 1][c] in "|JL" \
            and (r + 1, c) not in seen:
                seen.add((r + 1, c))
                queue.append((r + 1, c))

        if c > 0 and ch in "S-J7" and puzzle[r][c - 1] in "-LF" and (r, c - 1) \
            not in seen:
                seen.add((r, c - 1))
                queue.append((r, c - 1))

        if c < len(puzzle[r]) - 1 and ch in "S-LF" and puzzle[r][c + 1] in "-J7" \
            and (r, c + 1) not in seen:
                seen.add((r, c + 1))
                queue.append((r, c + 1))

    return len(seen) // 2

def part_2():
    puzzle, seen, queue = get_data()
    possible_s = {"|", "-", "J", "L", "7", "F"}

    while queue:
        r, c = queue.popleft()
        ch = puzzle[r][c]

        if r > 0 and ch in "S|JL" and puzzle[r - 1][c] in "|7F" and (r - 1, c) \
            not in seen:
                seen.add((r - 1, c))
                queue.append((r - 1, c))
                if ch == "S":
                    possible_s &= {"|", "J", "L"}

        if r < len(puzzle) - 1 and ch in "S|7F" and puzzle[r + 1][c] in "|JL" \
            and (r + 1, c) not in seen:
                seen.add((r + 1, c))
                queue.append((r + 1, c))
                if ch == "S":
                    possible_s &= {"|", "7", "F"}

        if c > 0 and ch in "S-J7" and puzzle[r][c - 1] in "-LF" and (r, c - 1) \
            not in seen:
                seen.add((r, c - 1))
                queue.append((r, c - 1))
                if ch == "S":
                    possible_s &= {"-", "J", "7"}

        if c < len(puzzle[r]) - 1 and ch in "S-LF" and puzzle[r][c + 1] in "-J7" \
            and (r, c + 1) not in seen:
                seen.add((r, c + 1))
                queue.append((r, c + 1))
                if ch == "S":
                    possible_s &= {"-", "L", "F"}

    assert len(possible_s) == 1
    (S,) = possible_s

    puzzle = [row.replace("S", S) for row in puzzle]
    puzzle = ["".join(ch if (r, c) in seen else "." for c, ch in enumerate(row)) for r, row in enumerate(puzzle)]

    outside = set()

    for r, row in enumerate(puzzle):
        within = False
        up = None

        for c, ch in enumerate(row):
            if ch == "|":
                assert up is None
                within = not within
            elif ch == "-":
                assert up is not None
            elif ch in "LF":
                assert up is None
                up = ch == "L"
            elif ch in "7J":
                assert up is not None
                if ch != ("J" if up else "7"):
                    within = not within
                up = None
            elif ch == ".":
                pass

            if not within:
                outside.add((r, c))

    return (len(puzzle) * len(puzzle[0]) - len(outside | seen))

print(f"Part 1: {part_1()}")
print(f"Part 2: {part_2()}")
