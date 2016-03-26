var Main = (function () {
    function Main() {
    }
    Main.prototype.test = function (a, b, c, d, e, f, g, h, p) {
        return ((a * 10 + b) - (c * 10 + d) == (e * 10 + f) &&
            (e * 10 + f) + (g * 10 + h) == p * 100 + p * 10 + p);
    };
    Main.prototype.pureBruteForce = function () {
        var count = 0;
        for (var p = 1; p <= 9; p++) {
            for (var a = 1; a <= 9; a++) {
                if (a == p)
                    continue;
                for (var b = 1; b <= 9; b++) {
                    if (b == p || b == a)
                        continue;
                    for (var c = 1; c <= 9; c++) {
                        if (c == p || c == a || c == b)
                            continue;
                        for (var d = 1; d <= 9; d++) {
                            if (d == p || d == a || d == b || d == c)
                                continue;
                            for (var e = 1; e <= 9; e++) {
                                if (e == p || e == a || e == b || e == c || e == d)
                                    continue;
                                for (var f = 1; f <= 9; f++) {
                                    if (f == p || f == a || f == b || f == c || f == d || f == e)
                                        continue;
                                    for (var g = 1; g <= 9; g++) {
                                        if (g == p || g == a || g == b || g == c || g == d || g == e || g == f)
                                            continue;
                                        for (var h = 1; h <= 9; h++) {
                                            if (h == p || h == a || h == b || h == c || h == d || h == e || h == f || h == g)
                                                continue;
                                            if (this.test(a, b, c, d, e, f, g, h, p)) {
                                                console.log('a=' + a + ',b=' + b + ',c=' + c + ',d=' + d + ',e=' + e + ',f=' + f + ',g=' + g + ',h=' + h + ',p=' + p + '<br>');
                                            }
                                            count++;
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        console.log('search ' + count + ' times');
    };
    return Main;
})();
var main = new Main();
main.pureBruteForce();
/*
copy app.js to console in chrome to see the result.

a=8,b=5,c=4,d=6,e=3,f=9,g=7,h=2,p=1<br>
a=8,b=6,c=5,d=4,e=3,f=2,g=7,h=9,p=1<br>
a=9,b=5,c=2,d=7,e=6,f=8,g=4,h=3,p=1<br>
search 362880 times
*/ 
