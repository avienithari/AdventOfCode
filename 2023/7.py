import sys

puzzle_input = open(sys.argv[1]).read().split()
hands = []
for i in range(0, len(puzzle_input), 2):
    hands.append((puzzle_input[i], int(puzzle_input[i + 1])))

def hand_score(hand):
    counts = []
    for card in hand:
        counts.append(hand.count(card))

    if 5 in counts:
        return 6
    if 4 in counts:
        return 5
    if 3 in counts:
        if 2 in counts:
            return 4
        return 3
    if counts.count(2) == 4:
        return 2
    if 2 in counts:
        return 1
    return 0

def possibilities(hand):
    joker = []
    if hand == "":
        return [""]
    for x in ("23456789TQKA" if hand[0] == "J" else hand[0]):
        for y in possibilities(hand[1:]):
            joker.append(x + y)

    return joker

def best_option(hand):
    return max(map(hand_score, possibilities(hand)))

def strength(hand, remap, part):
    my_sort = []
    for card in hand:
        my_sort.append(remap.get(card, card))

    if part == 1:
        return (hand_score(hand), my_sort)
    return (best_option(hand), my_sort)

def part_1(hands):
    remap = {
        "T": "A",
        "J": "B",
        "Q": "C",
        "K": "D",
        "A": "E"
    }
    hands.sort(key = lambda hand: strength(hand[0], remap, part=1))
    total = 0
    for rank, hand in enumerate(hands, 1):
        total += rank * hand[1]

    return total

def part_2(hands):
    remap = {
        "T": "A",
        "J": ".",
        "Q": "C",
        "K": "D",
        "A": "E"
    }
    hands.sort(key = lambda hand: strength(hand[0], remap, part=2))
    total = 0
    for rank, hand in enumerate(hands, 1):
        total += rank * hand[1]

    return total
    
print(f"Part 1: {part_1(hands)}")
print(f"Part 2: {part_2(hands)}")
