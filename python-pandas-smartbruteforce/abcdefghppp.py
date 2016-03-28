# Author: C Jethro Lam
#
# pip install pandas
# http://pandas.pydata.org
#
# Assuming leading digits A,C,E,G,P cannot be 0

import itertools
import time
import pandas
from operator import mul

start_time = time.time()

# Return all 6-digit permutations meeting AB-CD=EF
df = pandas.DataFrame(list(itertools.permutations([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 6)), columns=list('ABCDEF'))
df1 = df[(df.A > 0) & (df.C > 0) & (df.E > 0) & (10*df.A + df.B - 10*df.C - df.D == 10*df.E + df.F)]

# Return all 5-digit permutations meeting EF+GH=PPP
df = pandas.DataFrame(list(itertools.permutations([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 5)), columns=list('EFGHP'))
df2 = df[(df.E > 0) & (df.G > 0) & (df.P > 0) & (10*df.E + df.F + 10*df.G + df.H == 111*df.P)]

# Join above by EF as common key, then enforce distinctiveness on A,B,C,...,P
df = pandas.merge(df1, df2, on=['E', 'F'])
df3 = df[df.T.apply(lambda x : len(set(x))==9)]

solutions = df3.values

print "Solutions:\n %s" %solutions
print "Number of solutions: %d" %len(solutions)
print "Elapsed time(sec): %0.4f" %(time.time() - start_time)

#Solutions:
# [[9 0 6 3 2 7 8 4 1]
# [8 6 5 4 3 2 7 9 1]
# [8 5 4 6 3 9 7 2 1]
# [9 0 2 7 6 3 4 8 1]
# [9 5 2 7 6 8 4 3 1]]
#Number of solutions: 5
#Elapsed time(sec): 0.1336
