import re
from word2number import w2n

puzzle_input = []

with open('input1.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x for x in rows]

digits = []

for i in puzzle_input:
    digit_regex = re.findall(r'\d', i)

    if len(digit_regex) == 2:
        digits.append(int((digit_regex[0]) + digit_regex[1]))

    elif len(digit_regex) > 2:
        digits.append(int((digit_regex[0]) + digit_regex[-1]))

    else:
        digits.append(int((digit_regex[0]) + digit_regex[0]))

print(f'The sum of all the callibrations is: {sum(digits)}')
digits.clear()

for i in puzzle_input:
    digit_regex = re.findall(r'\d|one|two|three|four|five|six|seven|eight|nine', i)

    for j in range(len(digit_regex)):
        if isinstance(digit_regex[j], str):
            digit_regex[j] = w2n.word_to_num(digit_regex[j])

    if len(digit_regex) == 2:
        digits.append(int((digit_regex[0] * 10) + digit_regex[1]))

    elif len(digit_regex) > 2:
        digits.append(int((digit_regex[0] * 10) + digit_regex[-1]))

    else:
        digits.append(int((digit_regex[0] * 10) + digit_regex[0]))

print(f'The sum of all the callibrations with words is: {sum(digits)}')
