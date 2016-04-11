# Method

The same as that in the parent folder, but limit the use of lazy lists only to generating IJKL.

It is a nice abstraction, allowing the separation of defining the computation, iterating the results and counting the results. But it doesnt come for free, the overhead added up in a tight loop is substantial.
Instead of flatmapping and appending the lazy lists, the solvers in this folder uses two for-loops.

Further optimization include:
- Using a bool array, instead of a list, to store whether a digit is used, reducing the allocation and garbage collection when moving in and out of the search space. Checking if a digit was used takes constant time, instead of O(used digits).
- Using an int ref as the bool array.
- Explicitly passing varialbes to functions instead of having free variables.

# Result
After using loop instead of lazy list, there is a about 8x speed up.
After using loop and array, the performance is comparable to the C version (<40s for base 29 width 4).

Added an iteration/(somewhat) cps version that uses no lazy lists. Uses less memory and a bit faster.