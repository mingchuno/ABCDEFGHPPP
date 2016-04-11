open Core.Std
open Core_extended

let (>>=) = Lazy_list.(>>=)

module type QUESTION =
  sig
    val width : int val base : int
  end

module type SOLVED =
  sig
    type t
    val solutions : t Lazy_list.t
    val print_sol : t -> unit  
  end

module Solver(Q: QUESTION): SOLVED = struct

(*
   ABCD
  -EFGH
  =====
   IJKL
  +MNOP
  =====
  11111
*)
  type t = int list

  open Q
  let biggest_digit = base - 1

  let rec insert_into x = function
    | [] -> [[x]]
    | hd::tl -> (x::hd::tl) :: (insert_into x tl |> List.map ~f:(List.cons hd))

  let rec perm r l =
    if r = 0 then Lazy_list.return [] else match l with
      | [] -> Lazy_list.empty ()
      | hd::tl -> perm (r-1) tl
       |> Lazy_list.map ~f:(fun permutation -> insert_into hd permutation)
       |> Lazy_list.concat_list
       |> Lazy_list.append (perm r tl)

  let generate_flipped = function
    | [] -> assert false
    | l::kji ->
    	let rec flip = function
    	  | [] -> [[]]
    	  | k::ji -> List.concat_map ~f:(fun jm -> [k::jm; (base - k)::jm]) (flip ji)
      in flip kji |> List.concat_map ~f:(fun ojm -> [l::ojm; (base + 1 - l)::ojm])

  let remove_impossible_l = 
    List.fold_left
      ~init:(List.range ~stop:`inclusive 2 (base/2))
      ~f:(fun ls k -> List.filter ~f:(fun l -> l <> k && l <> k + 1) ls)

  let ijks =
    List.range ~stop:`inclusive 2 (biggest_digit/2)
    |> perm (width - 1)

  let lkjis = 
    Lazy_list.map ijks ~f:(fun ijk -> 
      remove_impossible_l ijk
      |> List.map ~f:(fun l -> l::ijk))
    |> Lazy_list.concat_list
    |> Lazy_list.map ~f:generate_flipped
    |> Lazy_list.concat_list

let lazy_range (start:int) (stop:int) =
  Lazy_list.unfold
    ~f:(fun x -> 
      let next = x + 1 in 
      if next > stop then None else Some(next))
    ~init:(start - 1) 

let generate_solution_from_lkji = function
  | [] -> assert false
  | l::kji ->
    let rec go_deeper used_digits carry partial_solution = function
      | [i] ->
        let digit_difference = i + if carry then 1 else 0 in
        lazy_range 2 (biggest_digit - digit_difference)
        |> Lazy_list.filter_map ~f:(fun e ->
          let a = e + digit_difference in 
          if List.for_all used_digits ~f:(fun x -> x <> e && x <> a)
            then Some (e::partial_solution) else None)
      | k::ji ->
        let digit_difference = k + if carry then 1 else 0 in
        let max_g_without_carry = base - digit_difference - 1 in
        let check_and_go_deeper carry g = 
          let c = g + digit_difference - if carry then base else 0 in 
          if List.for_all used_digits ~f:(fun x -> x <> g && x <> c)
            then go_deeper (g::c::used_digits) carry (g::partial_solution) ji
            else Lazy_list.empty () in
        let no_carry =
          lazy_range 0 max_g_without_carry
          >>= check_and_go_deeper false in
        let yes_carry = 
          lazy_range (max_g_without_carry + 1) biggest_digit
          >>= check_and_go_deeper true in
        Lazy_list.append no_carry yes_carry
      | [] -> assert false in
    let used_in_ijklmnop1 = l :: (base + 1 - l) :: 1 :: (List.concat_map kji ~f:(fun k -> [k; base - k])) in
    go_deeper used_in_ijklmnop1 false (l::kji) (l::kji)

  let solutions = 
  	lkjis >>= generate_solution_from_lkji

  exception Out_of_range of int
  let print_int_in_base wxyz =
    let show_digit digit =
      Char.of_int_exn(
        if digit <= 9 then Char.to_int '0' + digit else
        if digit <= 35 then Char.to_int 'A' + (digit - 10)
          else raise (Out_of_range digit)) in
    List.iter wxyz ~f:(fun x -> show_digit x |> print_char) 

  let print_sol solution =
    let (efgh, l::kji) = List.split_n solution width in
    let (ijkl, mnop) =
      let rec build ji (kl, p) = match ji with
        | j::i -> build i (j::kl, (base - j)::p)
        | [] -> (kl, p) in
      build kji ([l], [base + 1 -l]) in
    let (false, abcd) =
      List.fold2_exn (List.rev efgh) (l::kji) ~init:(false, []) ~f:(fun (carry, d) g k ->
        let digit_difference = k + if carry then 1 else 0 in
        let (c, carry) = if g + digit_difference > biggest_digit
          then (g + digit_difference - base, true)
          else (g + digit_difference, false) in
        (carry, c::d)
    ) in 
    print_int_in_base abcd; print_string " - ";
    print_int_in_base efgh; print_string " = ";
    print_int_in_base ijkl; print_string ", ";
    print_int_in_base ijkl; print_string " + ";
    print_int_in_base mnop; print_string " = ";
    List.init (width + 1) (fun _ -> 1) |> print_int_in_base;
    print_newline ();

end