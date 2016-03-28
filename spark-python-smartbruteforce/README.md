# Spark 

Spark application with Python API implementing a smart bruteforce approach to solve the ABCEFGHPPP problem

# Smart Bruteforce Approach

Naive bruteforce approach searches for solutions to AB-CD=EF and EF+GH=PPP over a permutation set of size 3,628,800 (10C9).  This smart approach breaks the problem down by first solving AB-CD=EF over a search space of size 151,200 (10C6) and solving EF+GH=PPP over a search space of size 30,240 (10C5), and then running a final search on the intersection of the two solutions.

# Output

NOTE: Per reviewer, assuming leading digits A, C, E, G, P cannot be 0

    Solutions: [(8, 6, 5, 4, 3, 2, 7, 9, 1), (9, 0, 6, 3, 2, 7, 8, 4, 1), (9, 5, 2, 7, 6, 8, 4, 3, 1), (8, 5, 4, 6, 3, 9, 7, 2, 1), (9, 0, 2, 7, 6, 3, 4, 8, 1)]
    Number of solutions: 5
    Elapsed time(sec): 0.9005
    Spark running on 2-node m3.xlarge cluster

