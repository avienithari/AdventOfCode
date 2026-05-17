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

      getCell = y: x:
        if y >= 0 && y < height && x >= 0 && x < width
        then substring x 1 (elemAt grid y)
        else ".";

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

      countAdj = y: x:
        foldl'
          (acc: dir:
            if getCell (y + dir.dy) (x + dir.dx) == "@" then
              acc + 1 else acc
          ) 0
          directions;

      processRow = totalAcc: y:
        let
          processCol = rowAcc: x:
            if getCell y x == "@" && countAdj y x < 4
            then rowAcc + 1
            else rowAcc;
        in
        totalAcc + foldl' processCol 0 (genList (i: i) width);
    in
    foldl' processRow 0 (genList (i: i) height);

  test = solve testInput;
  solution = solve aocInput;
in
{
  part1 =
    if test != expectedPart1Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test}
        Expected: ${toString expectedPart1Test}
      ''
    else
      solution;
}
