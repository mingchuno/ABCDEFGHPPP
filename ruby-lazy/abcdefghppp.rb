#!/usr/bin/env ruby
(0..9).to_a
.permutation(9)
.lazy
.select { |a, b, c, d, e, f, g, h, p|
    a > 0 && c > 0 && e > 0 && g > 0 && p > 0
}.map { |a, b, c, d, e, f, g, h, p|
    {
        :AB => 10 * a + b,
        :CD => 10 * c + d,
        :EF => 10 * e + f,
        :GH => 10 * g + h, 
        :PPP => 111 * p
    }
}.select { |sol|
    sol[:AB] - sol[:CD] == sol[:EF] &&
    sol[:EF] + sol[:GH] == sol[:PPP]
}.each { |sol| p sol }
