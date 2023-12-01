from copy import deepcopy
puzzle_input = []
stacks = []
crates = []
instructions = []

with open('input5.txt', 'r') as puzzle:
    rows = puzzle.readlines()
    puzzle_input = [x for x in rows]

for i in range(36):
    stacks.append([])
    for j in range(8):
        if puzzle_input[j][i] == ' ' or puzzle_input[j][i] == '[' or puzzle_input[j][i] == ']' or puzzle_input[j][i] == '':
            continue
        else:
            stacks[i].append(puzzle_input[j][i].rstrip('\n'))
    
for i in range(1, 36, 4):
    crates.append(stacks[i])

instructions = puzzle_input[puzzle_input.index('\n') + 1:]

crates_by_one = deepcopy(crates)
crates_by_stack = deepcopy(crates)

def move_crates(amount, source, destination):
    for i in range(amount):
        move = crates_by_one[source].pop(0)
        crates_by_one[destination].insert(0, move)
        move = crates_by_stack[source].pop(0)
        crates_by_stack[destination].insert(0 + i, move)

for i in instructions:
    amount = int(i.split()[1])
    source = int(i.split()[3]) - 1
    destination = int(i.split()[5]) - 1
    move_crates(amount, source, destination)

moved_crates_by_one = [] 
moved_crates_by_stack = []

for i in range(9):
    moved_crates_by_one.append(crates_by_one[i][0])
    moved_crates_by_stack.append(crates_by_stack[i][0])

print(f'Crates ending of top of each stack by moving one by one: {moved_crates_by_one}')
print(f'Crates ending of top of each stack by moving by stacks: {moved_crates_by_stack}')
