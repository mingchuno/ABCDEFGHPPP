#!/usr/bin/env pypy3
# http://m2.hkgolden.com/view.aspx?message=6307521&type=SW&page=1
# 熊大地產經紀
from itertools import permutations

def check(i):

    if i[0] == 0 or i[2] == 0 or i[4] == 0 or i[6] == 0:

        return

    ab = i[0] * 10 + i[1]

    cd = i[2] * 10 + i[3]

    ef = i[4] * 10 + i[5]

    if ab - cd != ef:

        return

    gh = i[6] * 10 + i[7]

    ppp = i[8] * 100 + i[8] * 10 + i[8]

    if ef + gh == ppp:

        print("{0} - {1} = {2}, {2} + {3} = {4}".format(ab, cd, ef, gh, ppp))



if __name__ == '__main__':

    for i in permutations(range(0, 10), 9):

        check(i)