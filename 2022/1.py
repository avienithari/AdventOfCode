elves = []
elve_calories = 0

with open('input1.txt', 'r') as data:
    rows = data.readlines()
    for row in rows:
        if row != '\n':
            elve_calories += int(row)
        else:
            elves.append(elve_calories)
            elve_calories = 0

print(f'{elves.index(max(elves)) + 1}th elf is carring {max(elves)} calories')

elves.sort(reverse=True)
print(f'Total number of calories carried by top three elves is: {elves[0] + elves[1] + elves[2]}')
