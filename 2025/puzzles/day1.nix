inputPath:

with builtins;
let
  testInput = ''
    L68
    L30
    R48
    L5
    R60
    L55
    L1
    L99
    R14
    L82
  '';
  expectedPart1Test = 3;
  expectedPart2Test = 6;

  aocInput = readFile inputPath;

  parseLines = rawData:
    filter (x: isString x && x != "") (
      split "\n" rawData
    );

  startingState = { pos = 50; stoppedCount = 0; passedCount = 0; };

  processMove = acc: line:
    let
      direction = substring 0 1 line;
      val = fromJSON (substring 1 (stringLength line - 1) line);

      delta = if direction == "R" then val else (0 - val);
      rawPosition = acc.pos + delta;

      modulo = rawPosition - ((rawPosition / 100) * 100);
      newPos = if modulo < 0 then modulo + 100 else modulo;

      newStoppedCount =
        if newPos == 0
        then acc.stoppedCount + 1 else acc.stoppedCount;

      passed =
        if direction == "R" then
          (acc.pos + val) / 100
        else
          let
            distanceToZero = if acc.pos == 0 then 100 else acc.pos;
          in
          if val >= distanceToZero then
            1 + ((val - distanceToZero) / 100)
          else 0;
    in
    {
      pos = newPos;
      stoppedCount = newStoppedCount;
      passedCount = acc.passedCount + passed;
    };
  test = foldl' processMove startingState (parseLines testInput);
  solution = foldl' processMove startingState (parseLines aocInput);
in
{
  part1 =
    if test.stoppedCount != expectedPart1Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.stoppedCount}
        Expected: ${toString expectedPart1Test}
      ''
    else solution.stoppedCount;

  part2 =
    if test.passedCount != expectedPart2Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.passedCount}
        Expected: ${toString expectedPart2Test}
      ''
    else solution.passedCount;
}
