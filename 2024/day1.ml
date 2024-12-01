open Printf

let file = "input1"

let get_data =
  let ic = open_in file in
  let lhs = ref [] in
  let rhs = ref [] in

  try
    while true do
      let line = input_line ic in
      let sides = String.split_on_char ' ' line in
      let clean = List.filter (fun x -> x <> "") sides in

      match clean with
      | lhs_str :: rhs_str :: _ ->
        lhs := (int_of_string lhs_str :: !lhs);
        rhs := (int_of_string rhs_str :: !rhs);
      | _ ->
        printf "Invalid line: %s\n" line
    done

  with End_of_file ->
    close_in ic;

  (!lhs, !rhs)

let part1 () =
  let (lhs, rhs) = get_data in

  let lhs = List.sort compare lhs in
  let rhs = List.sort compare rhs in
  let total = ref 0 in

  try
    List.iter2 (fun lhs_val rhs_val ->
      let diff = abs (lhs_val - rhs_val) in
      total := !total + diff;
    ) lhs rhs;

    printf "Part 1: %d\n" !total;

  with Invalid_argument _ ->
    printf "The lists aren't the same size\n";;

let count_occurences el lst =
  List.length (List.filter (fun x -> x = el) lst)

let part2 () =
  let (lhs, rhs) = get_data in
  let total = ref 0 in

  List.iter (fun lhs_val ->
    let occ = count_occurences lhs_val rhs in
    total := !total + (lhs_val * occ);
  ) lhs;

  printf "Part 2: %d\n" !total;;

let () =
  part1 ();
  part2 ();
