#!/usr/bin/env python
# pure wild guess, but it's not too slow :)

import random
import time

timeout = 5
start = time.time()
while True:
    if time.time() - start > timeout:
        print "Not lucky enough to find a solution in {0} second(s). :(".format(timeout)
        break

    x = range(1,10)
    random.shuffle(x)
    if (x[0] * 10 + x[1]  - x[2] *10 - x[3] == x[4] * 10 + x[5]) \
     and (x[4] * 10 + x[5] + x[6] * 10 + x[7] == x[8] * 100 + x[8] *10 + x[8]):
        print 'A={0}, B={1}, C={2}, D={3}, E={4}, F={5}, G={6}, H={7}, P={8}'.format(*x)
        print "Time elapsed = {0:.3f} second(s)".format(time.time() - start)
        break
