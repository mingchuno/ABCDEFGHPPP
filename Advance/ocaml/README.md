# Method

```

   A B C D
 - E F G H
 ----------
   I J K L
 + M N O P
 ----------
 1 1 1 1 1

```

Note that L + P = 11, I + M = J + N = K + O = 10.
(width - 1) numbers are permuted from 2 to (base - 1)/2, possible L's are calculated.
By symmetry, 2^width possibility can be generated from the above selection.

E.g. width 4 and base 17, suppose 8762 is selected, there are 15 more IJKL to test, from 876G, 87B2 to 9ABG.
Generating IJKL is very fast as little calculation is needed.

With an IJKL, possible EFGH's are calculated digit by digit.

# Result

Tested on iMac with 2.7GHz i5.

| width, base | 4, 17 | 4, 21 | 4, 25 | 4, 29 |
|-------------|-------|-------|-------|-------|
| time/s      | 0.3   | 8     | 125   | 1173  |

Uses ~12MB memory.

This is rather slow, I guess the reason is that there are too many allocations in the tight loop, have not looked into the assembly code though. I made a rough change from using Lazy_list from core_extended to BatLazyList from batteries and had some performance gain, but I am too lazy.