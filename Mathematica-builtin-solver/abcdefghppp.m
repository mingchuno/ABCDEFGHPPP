#!/usr/local/bin/WolframScript -script

variables = {a, b, c, d, e, f, g, h, p};

solutions = Solve[
    {
        (10 a + b) - (10 c + d) == (10 e + f),  (* AB - CD = EF *)
        (10 e + f) + (10 g + h) == (111*p)      (* EF + GH = PPP *)
    } ~Join~
    (0 < # <= 9 & /@ {a, c, e, g, p}) ~Join~    (* Leading digits are not zero *)
    (0 <= # <= 9 & /@ {b, d, f, h}),            (* The rest can be anything between 0 and 9 *)

    variables,

    Integers        (* Solve in integer domain *)
];

realSolutions = Select[solutions, DuplicateFreeQ[variables /. #]&];  (* all numbers are distinct *)

s = IntegerString;

Print[StringJoin[{s[10a+b]," - ",s[10c+d]," = ",s[10e+f]," + ",s[10g+h]," = ",s[111p]}/.#]]& /@ realSolutions;

(*

Prints:

"85 - 46 = 39 + 72 = 111"
"86 - 54 = 32 + 79 = 111"
"90 - 27 = 63 + 48 = 111"
"90 - 63 = 27 + 84 = 111"
"95 - 27 = 68 + 43 = 111"

*)



