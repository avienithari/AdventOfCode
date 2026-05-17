inputPath:

with builtins;
let
  testInput = ''
    ..@@.@@@@.
    @@@.@.@.@@
    @@@@@.@.@@
    @.@@@@..@.
    @@.@@@@.@@
    .@@@@@@@.@
    .@.@.@.@@@
    @.@@@.@@@@
    .@@@@@@@@.
    @.@.@@@.@.
  '';
  expectedPart1Test = 13;
  expectedPart2Test = 43;

  aocInput = readFile inputPath;

  parseLines = rawData:
    filter (x: isString x && x != "") (
      split "\n" rawData
    );

  solve = rawData:
    let
      grid = parseLines rawData;
      height = length grid;
      width = stringLength (head grid);

      directions = [
        { dy = -1; dx = -1; }
        { dy = -1; dx = 0; }
        { dy = -1; dx = 1; }
        { dy = 0; dx = -1; }
        { dy = 0; dx = 1; }
        { dy = 1; dx = -1; }
        { dy = 1; dx = 0; }
        { dy = 1; dx = 1; }
      ];

      rollsInit = listToAttrs (
        concatMap
          (y:
            let row = elemAt grid y;
            in
            concatMap
              (x:
                if substring x 1 row == "@"
                then
                  [{
                    name = "${toString y}, ${toString x}";
                    value = { inherit y x; };
                  }]
                else [ ]
              )
              (genList (i: i) width)
          )
          (genList (i: i) height)
      );

      countNeighbors = state: y: x:
        foldl'
          (acc: dir:
            if state ? "${toString (y + dir.dy)}, ${toString (x + dir.dx)}"
            then acc + 1 else acc
          ) 0
          directions;

      getRemoveableNames = state:
        let
          removeableRolls = filter
            (
              roll: countNeighbors state roll.y roll.x < 4
            )
            (attrValues state);
        in
        map (roll: "${toString roll.y}, ${toString roll.x}") removeableRolls;

      p1Removeable = getRemoveableNames rollsInit;
      part1Sum = length p1Removeable;

      cascade = state: removedCount:
        let
          toRemove = getRemoveableNames state;
          numToRemove = length toRemove;
        in
        if numToRemove == 0
        then removedCount
        else
          cascade (removeAttrs state toRemove) (removedCount + numToRemove);

      part2Sum = cascade rollsInit 0;
    in
    {
      inherit part1Sum part2Sum;
    };

  test = solve testInput;
  solution = solve aocInput;
in
{
  part1 =
    if test.part1Sum != expectedPart1Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.part1Sum}
        Expected: ${toString expectedPart1Test}
      ''
    else
      solution.part1Sum;

  part2 =
    if
      test.part2Sum != expectedPart2Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.part2Sum}
        Expected: ${toString expectedPart2Test}
      ''
    else
      solution.part2Sum;
}
