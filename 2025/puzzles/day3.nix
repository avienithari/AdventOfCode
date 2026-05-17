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

  aocInput = readFile inputPath;

  parseLines = rawData:
    filter (x: isString x && x != "") (
      split "\n" rawData
    );

  processBank = line:
    let
      len = stringLength line;
      indices = genList (i: len - 1 - i) len;

      folder = acc: idx:
        let
          char = substring idx 1 line;

          numStr =
            if acc.maxRight != "" then
              char + acc.maxRight else "0";
          num = fromJSON numStr;

          newMaxRight =
            if char > acc.maxRight then char else acc.maxRight;
          newGlobalMax =
            if num > acc.globalMax then num else acc.globalMax;
        in
        {
          maxRight = newMaxRight;
          globalMax = newGlobalMax;
        };
      result = foldl' folder { maxRight = ""; globalMax = 0; } indices;
    in
    result.globalMax;

  solve = rawData:
    let
      lines = parseLines rawData;
      joltages = map processBank lines;
    in
    foldl' add 0 joltages;

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
    else solution;
}
