day:

let
  puzzles = import ./puzzles;
  inputPath = ./. + "/input/day${day}.txt";
in
{
  result = puzzles."day${day}" inputPath;
}
