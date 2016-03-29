##Usage

    ruby abcdefghppp.rb [width] [base]

If no width provided, the default width will be 4.
If no base provided, the default width will be `4 * width + 1`, which is the number of unknowns.

## Methodology

The solving method is by unification (use width 2 as example):

    AB - CD == EF
    EF + GH == III

First, we know that I must be 1.

Then, we can get a set of partial solutions by the constrain

    F + H == BASE + 1

This generates a set of possible solutions of {F, H, I}.

Then we can further expand them by

    E + G == BASE
    B - D == F or B - D + BASE == F
    if B < D:
        A - C - 1 == E
    else:
        A - C == E

This generates the whole set of solutions.

In the process of expanding solutions, the size of the set will first grow, then shrink due to the limit of possible remaining choices.

Lazy evaluation is used, so the program may generate the first 50 solutions almost instantly using very little memory space.

For the number of solutions, since only the count is recorded, the memory usage is still small.

## Possible improvements
 - Use immutable data structure to reduce the overhead for cloning array of a solution when expanding the solution set
 - Some cases should be redundant, e.g. ABCD - EFGH = IJKL, IJKL + MNOP = QQQQQ, some {(B, C), (F, G), (J, K), (N, O)} pairs should be interchangable, but that is affected by the carry, so will be complicated...
 - Lower the computational complexity?
 - Use another languages, Ruby is just slow...

