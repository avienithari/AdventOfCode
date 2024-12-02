open Printf

let file = "input2"
(* let file = "test" *)

let get_data =
  let ic = open_in file in
  let reports = ref [] in

  try
    while true do
      let line = input_line ic in
      let levels =
        String.split_on_char ' ' line
        |> List.filter (fun x -> x <> "")
        |> List.map int_of_string
      in
      reports := levels :: !reports
    done

  with End_of_file ->
    close_in ic;

  (!reports)

let rec is_increasing lst =
  match lst with
    | [] | [_] -> true
    | x :: y :: rest -> x <= y && is_increasing (y :: rest)

let rec is_decreasing lst =
  match lst with
    | [] | [_] -> true
    | x :: y :: rest -> x >= y && is_decreasing (y :: rest)

let rec is_valid lst =
  match lst with
    | [] | [_] -> true
    | x :: y :: rest ->
      if abs (x - y) >= 1 && abs (x - y) <= 3 then
        is_valid (y :: rest)
      else
        false

let part1 () =
  let reports = get_data in

  let total = List.filter (fun level ->
    match level with
    | [] -> false
    | _ -> (is_increasing level || is_decreasing level) && is_valid level
  ) reports in

  printf "Part 1: %d\n" (List.length total)
;;


let () =
  part1 ();
