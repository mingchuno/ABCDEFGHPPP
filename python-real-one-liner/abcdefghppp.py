#!/usr/bin/env pypy3
from itertools import permutations as p

print([i for i in p(set(range(10)) - {1}, 8) if all([i[j] != 0 for j in range(0, 7, 2)]) and (i[0] * 10 + i[1])-(i[2] * 10 + i[3]) == i[4] * 10 + i[5] and (i[4] * 10 + i[5]) + (i[6] * 10 + i[7]) == 111])
