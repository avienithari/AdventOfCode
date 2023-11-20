win = 6
draw = 3
lose = 0

scissors_points = 3 # C, Z
paper_points = 2 # B, Y
rock_points = 1 # A, X

strategy = []
points = 0

with open('input2.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    for row in rows:
        strategy.append(tuple(row.rstrip('\n')))
check = 0
for matchup in strategy:
    check += 1
    if matchup[0] == 'A' and matchup[2] == 'X':
        points += (draw + rock_points)
    elif matchup[0] == 'B' and matchup[2] == 'Y':
        points += (draw + paper_points)
    elif matchup[0] == 'C' and matchup[2] == 'Z':
        points += (draw + scissors_points)

    elif matchup[0] == 'A' and matchup[2] == 'Y':
        points += (win + paper_points)
    elif matchup[0] == 'B' and matchup[2] == 'Z':
        points += (win + scissors_points)
    elif matchup[0] == 'C' and matchup[2] == 'X':
        points += (win + rock_points)

    elif matchup[0] == 'A' and matchup[2] == 'Z':
        points += (lose + scissors_points)
    elif matchup[0] == 'B' and matchup[2] == 'X':
        points += (lose + rock_points)
    elif matchup[0] == 'C' and matchup[2] == 'Y':
        points += (lose + paper_points)

print(f'You got {points} points with first strategy.')

check = 0
points = 0
for matchup in strategy:
    check += 1
    if matchup[0] == 'A' and matchup[2] == 'X':
        points += (lose + scissors_points)
    elif matchup[0] == 'B' and matchup[2] == 'Y':
        points += (draw + paper_points)
    elif matchup[0] == 'C' and matchup[2] == 'Z':
        points += (win + rock_points)
    elif matchup[0] == 'A' and matchup[2] == 'Y':
        points += (draw + rock_points)
    elif matchup[0] == 'B' and matchup[2] == 'Z':
        points += (win + scissors_points)
    elif matchup[0] == 'C' and matchup[2] == 'X':
        points += (lose + paper_points)
    elif matchup[0] == 'A' and matchup[2] == 'Z':
        points += (win + paper_points)
    elif matchup[0] == 'B' and matchup[2] == 'X':
        points += (lose + rock_points)
    elif matchup[0] == 'C' and matchup[2] == 'Y':
        points += (draw + scissors_points)

print(f'You got {points} points with second strategy.')
