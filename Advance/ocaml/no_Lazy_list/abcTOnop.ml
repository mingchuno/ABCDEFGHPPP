open Core.Std
open Solve_cps

let questions = [
  (module struct
    let width = 4
    let base = 17
  end : QUESTION);
  (module struct
    let width = 4
    let base = 21
  end);
  (module struct
    let width = 4
    let base = 25
  end);
  (module struct
    let width = 4
    let base = 29
  end);
  (module struct
    let width = 6
    let base = 25
  end);
]

let show_solutions (module Q: QUESTION) =
  let start_time = (Time.now () |> Time.to_float) in
  let module S = Solver(Q) in
  S.solve() |>
    printf "The number of solutions in base %d with width %d is %d\n" Q.base Q.width;
  (Time.now () |> Time.to_float) -. start_time |>
    printf "Time needed: %fs.\n"; print_newline ()

let () =
  List.iter ~f:show_solutions questions