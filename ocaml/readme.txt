hello:ocaml mukeshtiwari$ ocamlfind ocamlopt -o abcdefghppp -linkpkg -package batteries abcdefghppp.ml
File "abcdefghppp.ml", line 26, characters 18-162:
Warning 8: this pattern-matching is not exhaustive.
Here is an example of a value that is not matched:
[]
hello:ocaml mukeshtiwari$ ./abcdefghppp 
85 - 46 = 39, 39 + 72 = 111
86 - 54 = 32, 32 + 79 = 111
90 - 27 = 63, 63 + 48 = 111
90 - 63 = 27, 27 + 84 = 111
95 - 27 = 68, 68 + 43 = 111

or from toplevel
# #use "topfind";;
# #require "batteries";;
C-c C-b to evaluate the buffer
