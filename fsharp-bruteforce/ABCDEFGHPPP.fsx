type Result = 
    { A: int
      B: int
      C: int
      D: int
      E: int
      F: int
      G: int
      H: int
      P: int }

// For getting permutations of a list: http://stackoverflow.com/a/3129136/465056
let rec getPermutations list =
    let rec distribute e = function
        | [] -> [[e]]
        | (h :: t) as l -> (e :: l) :: [for l in distribute e t -> h :: l]
    match list with
    | [] -> [[]]
    | h :: t -> List.collect (distribute h) (getPermutations t)

let solvePermutation = function
    | [a; b; c; d; e; f; g; h; p; _] when a <> 0 && c <> 0 && e <> 0 && g <> 0 && p <> 0 ->
        let v1 = a * 10 + b
        let v2 = c * 10 + d 
        let v3 = e * 10 + f 
        let v4 = g * 10 + h 
        let pVal = p * 100 + p * 10 + p
        v1 - v2 = v3 && v3 + v4 = pVal
    | _ -> false

[0..9]
|> getPermutations
|> List.filter solvePermutation
|> List.map (function [a; b; c; d; e; f; g; h; p; _] -> 
                        { A = a; B = b; C = c; D = d; E = e; F = f; G = g; H = h; P = p } | _ -> failwith "Unexpected")
