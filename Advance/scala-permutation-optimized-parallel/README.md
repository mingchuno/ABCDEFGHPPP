# Methodology
Assume `P = 1`

Solve `EF + GH = 111` -> Set A { {E,F,G,H} .... }

Use Set A to solve `AB + CD = EF`

Total iteration = (Base)P4 + (SizeOf(SetA) * (Base - 4)P4)

# Results
JVM warm up time ~ 250ms

The following results included JVM Warm up time
* Base 10  ~ 450ms 
* Base 16  ~ 1100ms 
* Base 22  ~ 4000ms 
* Base 28  ~ 18000ms 
* Base 34  ~ 109000ms
* Base 40  ~ 491820ms

From the obersevation, every increase of 6 in Base will have 4.x increase of the computation time.
