open Core.Std

let flip ref_int index =
  ref_int := Int.bit_xor !ref_int (Int.shift_left 1 index)

let get ref_int index =
  Int.bit_and !ref_int (Int.shift_left 1 index) <> 0

module type QUESTION =
  sig
    val width : int val base : int
  end

module type SOLVED =
  sig
    val solve : unit -> int
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

  open Q
  let biggest_digit = base - 1

  let rec insert_into x = function
    | [] -> [[x]]
    | hd::tl -> (x::hd::tl) :: (insert_into x tl |> List.map ~f:(List.cons hd))

  (* This is not exactly cps because of the non-tail calls,
  but I like the name :P *)
  let rec perm_cps r l ~f =
    if r = 0 then f [] else match l with
      | [] -> ()
      | hd :: tl ->
        perm_cps r tl ~f;
        perm_cps (r-1) tl ~f:(fun permutation ->
          insert_into hd permutation
          |> List.iter ~f
        )

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
    print_newline ()

  let count = ref 0

  let iterate_solution_from_lkji = function
    | [] -> assert false
    | l::kji ->
      let available = ref (-1) in
      let () =
        flip available 1;
        flip available l; flip available (base + 1 - l);
        List.iter kji ~f:(fun k -> flip available k; flip available (base - k)) in 
      let rec go_deeper carry base count partial_solution = function
        | [i] ->
          let digit_difference = i + if carry then 1 else 0 in
          for e = 2 to biggest_digit - digit_difference do
            let a = e + digit_difference in
              if get available e && get available a then
                (Int.incr count;
                  if !count <= 50 then print_sol (e::partial_solution))
          done
        | k::ji ->
          let digit_difference = k + if carry then 1 else 0 in
          let max_g_without_carry = base - digit_difference - 1 in
          let check_and_go_deeper carry g digit_difference base available count partial_solution = 
            (* taking stuff as params is faster than pulling them from closure *)
            let c = g + digit_difference - if carry then base else 0 in 
            if get available g && get available c then
              ( flip available g; flip available c;
                go_deeper carry base count (g::partial_solution) ji;
                flip available g; flip available c;
              ) in
          for g = 0 to max_g_without_carry do
            check_and_go_deeper false g digit_difference base available count partial_solution 
          done;
          for g = (max_g_without_carry + 1) to biggest_digit do
            check_and_go_deeper true g digit_difference base available count partial_solution
          done;
        | [] -> assert false in
      go_deeper false base count (l::kji) (l::kji)

  let solve () =
    List.range ~stop:`inclusive 2 (biggest_digit/2)
    |> perm_cps (width - 1) ~f:(
      fun ijk ->
      remove_impossible_l ijk
      |> List.iter ~f:(fun l ->
        l:: ijk
        |> generate_flipped
        |> List.iter ~f: iterate_solution_from_lkji)
    );
    !count

end