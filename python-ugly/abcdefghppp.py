#!/usr/bin/env python3

print([[a, b, c, d, e, f, g, h, 1] for a in range(2, 10) for b in range(10) for c in range(2, 10) for d in range(10) for e in range(2, 10) for f in range(10) for g in range(2, 10) for h in range(10) if len(set([a, b, c, d, e, f, g, h, 1])) == 9 and 10 * a + b - 10 * c - d == 10 * e + f and 10 * e + f + 10 * g + h == 111])
