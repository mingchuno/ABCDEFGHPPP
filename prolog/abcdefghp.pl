% AUTHOR : Jason Yu %
combineDigits([E], R) :-
  R is E.
combineDigits([H | T], R) :-
  length(T, L),
  combineDigits(T, ROfTail),
  R is (H * (10 ^ L)) + ROfTail.

splitDigits(_, [], 0) :- !.
splitDigits(D, [H | T], L) :-
  NewL is L-1,
  H is D div (10^NewL),
  TDigits is D mod (10 ^ NewL),
  splitDigits(TDigits, T, NewL).

satisfy([AB, CD, EF, GH, PPP]) :-
  Digits = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9],

  member(A, Digits), A \= 0,
  member(B, Digits), \+ member(B, [A]),
  combineDigits([A, B], AB),

  member(C, Digits), C \= 0, \+ member(C, [A, B]),
  member(D, Digits), \+ member(D, [A, B, C]),
  combineDigits([C, D], CD),

  EF is AB - CD, EF >=10,
  splitDigits(EF, [E, F], 2),
  \+ member(E, [A, B, C, D]),
  \+ member(F, [A, B, C, D, E]),

  member(G, Digits), G \= 0,
  \+ member(G, [A, B, C, D, E, F]),
  member(H, Digits),
  \+ member(H, [A, B, C, D, E, F, G]),
  member(P, Digits),
  \+ member(P, [A, B, C, D, E, F, G, H]),

  combineDigits([G, H], GH),
  combineDigits([P, P, P], PPP),

  EF is AB-CD,
  PPP is EF+GH.

answer :-
  forall(
    satisfy([AB, CD, EF, GH, PPP]),
    format('~d - ~d = ~d, ~d + ~d = ~d~N', [AB, CD, EF, EF, GH, PPP])
  ).
