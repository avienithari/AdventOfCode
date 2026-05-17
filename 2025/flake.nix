{
  description = "AOCix";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem (system:
      let
        pkgs = import nixpkgs { inherit system; };

        aoc-nix = pkgs.writeShellScriptBin "aoc-nix" ''
          if [ -f .env ]; then
            source .env
          else
            echo "Error: no .env with aoc session cookie found."
            exit 1
          fi

          if [ -z "$1" ]; then
            DAYS=$(find ./puzzles -maxdepth 1 -name "day*.nix" | \
              sed -n 's/.*day\([0-9]\+\)\.nix/\1/p' | sort -n)

            if [ -z "$DAYS" ]; then
              echo "No puzzles found in ./puzzles."
              exit 0
            fi
          else
            DAYS="$1"
          fi

          mkdir -p ./input/

          for DAY in $DAYS; do
            INPUT_FILE="./input/day''${DAY}.txt"

            if [ ! -f "$INPUT_FILE" ]; then
              curl -s --cookie "session=$AOC_SESSION" \
                "https://adventofcode.com/2025/day/$DAY/input" > "$INPUT_FILE"
            fi

            git add -f "$INPUT_FILE"

            echo "--- Evaluating Day: $DAY ---"
            nix eval --file ./main.nix --apply "f: f \"$DAY\""

            git rm --cached --force "$INPUT_FILE" >/dev/null 2>&1
          done
        '';
      in
      {
        devShells.default = pkgs.mkShell {
          buildInputs = with pkgs; [
            nixd
            nixfmt
            deadnix
            statix

            aoc-nix
          ];
        };
      }
    );
}
