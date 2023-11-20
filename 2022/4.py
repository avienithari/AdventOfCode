puzzle_input = []

with open('input4.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    for row in rows:
        puzzle_input.append(row.strip())

fully_contained = 0
overlap = 0
for line in puzzle_input:
    x, y = line.split(',')
    start1, end1 = x.split('-')
    start2, end2 = y.split('-')
    start1, end1, start2, end2 = [int(i) for i in [start1, end1, start2, end2]]
    if start1 <= start2 and end2 <= end1 or start2 <= start1 and end1 <= end2:
        fully_contained += 1

    if not (end1 < start2 or start1 > end2):
        overlap += 1


print(f'Number of pairs with fully containing the other range is: {fully_contained}.')
print(f'Number of pairs with overlapping ranges is: {overlap}.')
