inputPath:

with builtins;
let
  testInput = ''
    11-22,95-115,998-1012,1188511880-1188511890,222220-222224,1698522-1698528,446443-446449,38593856-38593862,565653-565659,824824821-824824827,2121212118-2121212124
  '';
  expectedPart1Test = 1227775554;

  aocInput = readFile inputPath;

  isInvalidId = num:
    let
      str = toString num;
      len = stringLength str;
      half = len / 2;
      isEven = (half * 2) == len;

      lhs = substring 0 half str;
      rhs = substring half half str;
    in
    isEven && (lhs == rhs);

  processRanges = rawData:
    let
      cleanData = replaceStrings [ "\n" " " ] [ "" "" ] rawData;
      rangeStrings = filter (x: isString x && x != "") (
        split "," cleanData
      );
      expandRange = rangeStr:
        let
          bounds = filter isString (split "-" rangeStr);
          minVal = fromJSON (head bounds);
          maxVal = fromJSON (elemAt bounds 1);
          length = maxVal - minVal + 1;
        in
        genList (i: minVal + i) length;
    in
    concatMap expandRange rangeStrings;

  solve = rawString:
    let
      allNumbers = processRanges rawString;
      invalidIds = filter isInvalidId allNumbers;
    in
    foldl' add 0 invalidIds;

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
      "Part 1: ${toString solution}";
}
