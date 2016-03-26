#!/usr/bin/env python3
# High performance implementation using python itertools.permutations
# Average runtime observed of main: ~4.5ms, when compiled with cython: ~0.12μs
# Author: Saren
# https://s-blog.wtako.net/view/17/

from itertools import permutations

PPP = 111

def check_last_4(i):
    if i[0] == 0 or i[2] == 0:
        return 0
    EF, GH = i[0] * 10 + i[1], i[2] * 10 + i[3]
    if EF + GH == PPP:
        return EF
    return 0

def check_first_4(i, EF):
    if i[0] == 0 or i[2] == 0:
        return 0
    AB, CD = i[0] * 10 + i[1], i[2] * 10 + i[3]
    if AB - CD == EF:
        return 1

if __name__ == '__main__':
    for i in permutations(set(range(10)) - {1}, 4):
        EF = check_last_4(i)
        if EF == 0:
            continue
        for j in permutations(set(range(10)) - set(i) - {1}, 4):
            if check_first_4(j, EF):
                print(j, i)

