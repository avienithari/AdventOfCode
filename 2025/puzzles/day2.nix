inputPath:

with builtins;
let
  testInput = ''
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
  '';
  expectedPart1Test = 1227775554;
  expectedPart2Test = 4174379265;

  aocInput = readFile inputPath;

  startingState = { doubledSum = 0; repeatedSum = 0; };

  solve = rawString:
    let
      cleanData = replaceStrings [ "\n" " " ] [ "" "" ] rawString;
      rangeStrings = filter (x: isString x && x != "") (
        split "," cleanData
      );

      folder = acc: num:
        let
          str = toString num;
          len = stringLength str;
          half = len / 2;
          isEven = (half * 2) == len;
          lhs = substring 0 half str;
          rhs = substring half half str;

          isDoubled = isEven && (lhs == rhs);

          divisors = filter (c: len == (len / c) * c) (
            genList (i: i + 1) half
          );

          checkChunk = size: (
            replaceStrings [ (substring 0 size str) ]
              [ "" ]
              str
          ) == "";

          isRepeated = isDoubled || any checkChunk divisors;

          newDoubled =
            if isDoubled then
              acc.doubledSum + num else acc.doubledSum;
          newRepeated =
            if isRepeated then
              acc.repeatedSum + num else acc.repeatedSum;
        in
        seq newDoubled (seq newRepeated {
          doubledSum = newDoubled;
          repeatedSum = newRepeated;
        });

      processSingleRange = globalAcc: rangeStr:
        let
          bounds = filter isString (split "-" rangeStr);
          minVal = fromJSON (head bounds);
          maxVal = fromJSON (elemAt bounds 1);
          length = maxVal - minVal + 1;

          rangeNums = genList (i: minVal + i) length;
          rangeResult = foldl' folder startingState rangeNums;

          newGlobalDoubled = globalAcc.doubledSum + rangeResult.doubledSum;
          newGlobalRepeated = globalAcc.repeatedSum + rangeResult.repeatedSum;
        in
        seq newGlobalDoubled (seq newGlobalRepeated {
          doubledSum = newGlobalDoubled;
          repeatedSum = newGlobalRepeated;
        });
    in
    foldl' processSingleRange startingState rangeStrings;

  test = solve testInput;
  solution = solve aocInput;
in
{
  part1 =
    if test.doubledSum != expectedPart1Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.doubledSum}
        Expected: ${toString expectedPart1Test}
      ''
    else
      "Part 1: ${toString solution.doubledSum}";

  part2 =
    if test.repeatedSum != expectedPart2Test
    then
      throw ''
        [TEST FAILED]
        Got:      ${toString test.repeatedSum}
        Expected: ${toString expectedPart2Test}
      ''
    else
      "Part 2: ${toString solution.repeatedSum}";
}
