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

  aocInput = readFile inputPath;
  parseLines = rawData:
    filter (x: isString x && x != "") (
      split "\n" rawData
    );

  startingState = { pos = 50; count = 0; };

  processMove = acc: line:
    let
      direction = substring 0 1 line;
      varStr = substring 1 (stringLength line - 1) line;
      val = fromJSON varStr;

      delta = if direction == "R" then val else (0 - val);
      rawPosition = acc.pos + delta;

      modulo = rawPosition - ((rawPosition / 100) * 100);
      newPos = if modulo < 0 then modulo + 100 else modulo;

      newCount = if newPos == 0 then acc.count + 1 else acc.count;
    in
    {
      pos = newPos;
      count = newCount;
    };
  testPart1 = (foldl' processMove startingState (parseLines testInput)).count;
  solution = foldl' processMove startingState (parseLines aocInput);
in
{
  part1 =
    if testPart1 != expectedPart1Test
    then
      throw ''
        [Test FAILED]
        Got:      ${toString testPart1}
        Expected: ${toString expectedPart1Test}
      ''
    else "Part 1: ${toString solution.count}";
}
