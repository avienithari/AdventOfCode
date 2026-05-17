inputPath:

with builtins;
let
  testInput = ''
    987654321111111
    811111111111119
    234234234234278
    818181911112111
  '';
  expectedPart1Test = 357;
  expectedPart2Test = 3121910778619;

  aocInput = readFile inputPath;

  parseLines = rawData:
    filter (x: isString x && x != "") (
      split "\n" rawData
    );

  getMaxJoltage = k: line:
    let
      len = stringLength line;

      folder = stack: idx:
        let
          c = substring idx 1 line;
          charsLeft = len - idx - 1;

          popStack = st:
            let
              stLen = stringLength st;
            in
            if stLen > 0
              && (substring (stLen - 1) 1 st) < c
              && (stLen + charsLeft >= k) then
              popStack (substring 0 (stLen - 1) st)
            else
              st;

          popped = popStack stack;
          poppedLen = stringLength popped;
        in
        if poppedLen < k then popped + c else popped;

      finalString = foldl' folder "" (genList (i: i) len);
    in
    fromJSON finalString;

  solve = rawData:
    let
      lines = parseLines rawData;

      processBank = acc: line:
        let
          p1Max = getMaxJoltage 2 line;
          p2Max = getMaxJoltage 12 line;
        in
        {
          part1Sum = acc.part1Sum + p1Max;
          part2Sum = acc.part2Sum + p2Max;
        };
    in
    foldl' processBank { part1Sum = 0; part2Sum = 0; } lines;

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
    if test.part2Sum != expectedPart2Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.part2Sum}
        Expected: ${toString expectedPart2Test}
      ''
    else
      solution.part2Sum;
}
