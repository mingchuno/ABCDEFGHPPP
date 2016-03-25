open Batteries
open Batteries.LazyList

let delete x xs = Batteries.LazyList.filter (fun y -> x <> y) xs

let concatMap f l =
   Batteries.LazyList.map f l |>  Batteries.LazyList.concat


let rec perm xs n =
  match n, xs with
  | 0, _ -> Batteries.LazyList.of_list [[]]
  | t, ts ->
     concatMap (fun x ->  Batteries.LazyList.map (fun y -> x :: y)
                                  (perm (delete x ts) (t - 1))) ts


let sat (xs : int list) : bool =
  match xs with
  |[a; b; c; d; e; f; g; h; p] ->
    a <> 0 && c <> 0 && e <> 0 && g <> 0 && p <> 0 &&
    ((10 * a + b) - (10 * c + d) = (10 * e + f)) &&
    ((10 * e + f) + (10 * g + h) = 111 * p)
  | _ -> failwith "not valid permutaion"

let printsolution [a; b; c; d; e; f; g; h; p] =
      Printf.printf "%d%d - %d%d = %d%d, " a b c d e f;
      Printf.printf "%d%d + %d%d = %d%d%d\n" e f g h p p p



let () =
  let ps = perm (Batteries.LazyList.of_list [0;1;2;3;4;5;6;7;8;9]) 9 in
  Batteries.LazyList.iter printsolution (Batteries.LazyList.filter sat ps);
