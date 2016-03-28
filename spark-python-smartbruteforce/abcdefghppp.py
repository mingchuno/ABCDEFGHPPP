# Author: C Jethro Lam
#
# Assumed existence of SparkContext "sc" and readily run on spark shell or notebook 
# To run as standalone app, please follow http://spark.apache.org for configuring "sc"
#
# Per reviewer, assuming leading digits A,C,E,G,P cannot be 0

import itertools
import time
from operator import mul

start_time = time.time()

# Return all 6-digit permutations meeting AB-CD=EF, output as (EF, (A,B,C,D,E,F))
perm_1 = sc.parallelize(list(itertools.permutations([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 6)))\
    .filter(lambda x : x[0] > 0 and x[2] > 0 and x[4] >0)\
    .filter(lambda x : sum(map(mul, (10, 1, -10, -1, -10, -1), x))==0)\
    .map(lambda x : (10*x[4]+x[5], x))\
    .unpersist().cache()

# Return all 5-digit permutations meeting EF+GH=PPP, output as (EF, (E,F,G,H,P))
perm_2 = sc.parallelize(list(itertools.permutations([0, 1, 2, 3, 4, 5, 6, 7, 8, 9], 5)))\
    .filter(lambda y : sum(map(mul, (10, 1, 10, 1, -111), y))==0)\
    .filter(lambda y : y[0] > 0 and y[2] > 0 and y[4] >0)\
    .map(lambda y : (10*y[0]+y[1], y))\
    .unpersist().cache()

# Return all permutation meeting both conditions with distinct A,B,C,D,E,F,G,H,P
# Join by EF, then enforce distinctiveness
perm_ans = perm_1.join(perm_2).map(lambda kv : kv[1])\
    .filter(lambda z : len(set(z[0] + z[1])) == 9)\
    .map(lambda z : z[0][0:4] + z[1])\
    .unpersist().cache()

solutions = perm_ans.collect()

print "Solutions: %s" %solutions
print "Number of solutions: %d" %len(solutions)
print "Elapsed time(sec): %0.4f" %(time.time() - start_time)
print "Spark running on 2-node m3.xlarge cluster"

#Solutions: [(8, 6, 5, 4, 3, 2, 7, 9, 1), (9, 0, 6, 3, 2, 7, 8, 4, 1), (9, 5, 2, 7, 6, 8, 4, 3, 1), (8, 5, 4, 6, 3, 9, 7, 2, 1), (9, 0, 2, 7, 6, 3, 4, 8, 1)]
#Number of solutions: 5
#Elapsed time(sec): 0.9005
#Spark running on 2-node m3.xlarge cluster

