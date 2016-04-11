open Core.Std
open Core_extended
open Solve

let questions = [
  (module struct
    let width = 4
    let base = 17
  end : QUESTION)
  ;
  (module struct
    let width = 4
    let base = 21
  end)
  ;
  (module struct
    let width = 4
    let base = 25
  end)
  ;
  (module struct
    let width = 4
    let base = 29
  end)
]

let rec lazy_take n lazy_list =
  match (n, Lazy_list.decons lazy_list) with
  | (_, None) -> Lazy_list.empty ()
  | (0, _) -> Lazy_list.empty ()
  | (n, Some (x, xs)) -> Lazy_list.cons x (lazy_take (n-1) xs)

let show_solutions (module Q: QUESTION) =
  let start_time = (Time.now () |> Time.to_float) in
  let module S = Solver(Q) in
  S.solutions |> lazy_take 50 |> Lazy_list.iter ~f:S.print_sol;
  S.solutions |> Lazy_list.length |>
    printf "The number of solutions in base %d with width %d is %d\n" Q.base Q.width;
  (Time.now () |> Time.to_float) -. start_time |>
    printf "Time needed: %fs.\n"; print_newline ()

let () =
  List.iter ~f:show_solutions questions