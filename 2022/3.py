puzzle_input = []

with open('input3.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    for row in rows:
        puzzle_input.append(row)

def score(value):
    if 'a' <= value <= 'z':
        return ord(value) - ord('a') + 1
    else:
        return ord(value) - ord('A') + 1 + 26

points = 0
for row in puzzle_input:
    left = row[:int(len(row)/2)]
    right = row[int(len(row)/2):]

    for value in left:
        if value in right:
            points += score(value)
            break

print(f'Sum of the priorites is: {points} points.')

points = 0
i = 0
while i < len(puzzle_input):
    for value in puzzle_input[i]:
        if value in puzzle_input[i+1] and value in puzzle_input[i+2]:
            points += score(value)
            break
    i += 3

print(f'Sum of the badges priorites is: {points} points.')
