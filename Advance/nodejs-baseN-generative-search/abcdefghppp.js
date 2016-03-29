function abcdefghppp(base, width, size){
  size = typeof size === 'undefined' ? 50 : size;   // max output size
  var i;
  var ans = [];
  var cnt = 0;
  var used1 = new Array(base);
  var used2 = new Array(base);
  var sp = new Array(width);

  var diff = [new Array(base), new Array(base)];
  for(i=0; i<2; i++) for(var j=0; j<base; j++) diff[i][j] = [];

  // EXP[i] = base^i
  var EXP = new Array(width);
  EXP[0] = 1;
  for(i=1; i<width; i++) EXP[i] = base*EXP[i-1];

  // value of e
  var e = 1;
  for(i=0; i<width; i++) e = base*e+1;

  // just to make sure b has at least width digits
  var MIN=1;
  for(i=1; i<width; i++) MIN = MIN*base;

  // used-tables helpers
  function reset(used){
    for(var i=0; i<used.length; i++) used[i] = false;
    used[1] = true;
  }
  function checkWrite(used, a){
    // mutable check
    for(var i=width; i--;){
      var t = a%base;
      if( used[t] ) return false;
      used[t] = true;
      a = (a-t)/base;
    }
    return true;
  }

  // return true to break
  function generate(w,c){
    if( w === width ){
      var d = e - c;
      if( d < c ) return true;    // due to symmetry of c and d
      reset(used2);
      if( checkWrite(used2, c) && checkWrite(used2, d) ) solveAB(c);
      return false;
    }

    // left-most digit cannot start with zero and one is used
    var start = w === 0 ? 2 : 0;
    for(var i=start; i<base; i++){
      if( used1[i] ) continue;
      used1[i] = true;
      if( generate(w+1, base*c+i) ) return true;
      used1[i] = false;
    }
    return false;
  }

  function solveAB(c){
    var i,t;
    // possible digits in a and b
    var vs = [];
    for(i=0; i<used2.length; i++) if( !used2[i] ) vs.push(i);

    // O(B*B)
    // diff[0][i] = all possible pairs of digits [a,b] such that b-a = i
    // diff[1][i] = all possible pairs of digits [a,b] such that 10+b-a= i
    for(i=0; i<2; i++) for(var j=0; j<base; j++) diff[i][j].splice(0);
    for(i=0; i<vs.length; i++){
      for(var k=i+1; k<vs.length; k++){
        var v1 = vs[i], v2 = vs[k];
        diff[0][v2-v1].push([v1,v2]);
        diff[1][base+v1-v2].push([v2,v1]);
      }
    }

    function diffSearch(i, borrow, a, b){
      if( i === width ){
        if( a > b && b > MIN ){
          if(ans.length < size) ans.push([a,b,c,e-c]);
          cnt++;
        }
        return;
      }
      if( sp[i] + borrow === base ) return;    // this imply that a0 = b0 = 0, so not a solution
      for(var j=0; j<2; j++){
        var vec = diff[j][sp[i]+borrow];
        for(var k=0; k<vec.length; k++) {
          var a0 = vec[k][1], b0 = vec[k][0];
          if( used2[a0] || used2[b0] ) continue;
          used2[a0] = used2[b0] = true;
          diffSearch(i+1, j, a+a0*EXP[i], b+b0*EXP[i]);
          used2[a0] = used2[b0] = false;
        }
      }
    }

    for(i=0, t=c; i<width; i++, t = Math.floor(t/base) ) sp[i] = t%base;
    diffSearch(0, 0, 0, 0);
    // due to symmetry of c and d
    c = e - c;
    for(i=0, t=c; i<width; i++, t = Math.floor(t/base) ) sp[i] = t%base;
    diffSearch(0, 0, 0, 0);
  }

  reset(used1);
  generate(0,0);

  return [cnt, ans];
}

function print(base,ans){
  var sa = ans[0].toString(base);
  var sb = ans[1].toString(base);
  var sc = ans[2].toString(base);
  var sd = ans[3].toString(base);
  var se = (ans[0]-ans[1]+ans[3]).toString(base);
  return [sa,'-',sb,'=',sc,', ',sc,'+',sd,'=',se].join('');
}

var s2 = '============================================================';
[16,22,28,34].forEach(function(base) {
  var width = 2;
  var s = Date.now();
  var x = abcdefghppp(base, width);
  var e = Date.now();
  var cnt = x[0], ans = x[1];
  s2 += `
Case base=${base}
${ans.map((x) => print(base,x)).sort().join('\n')}
time: ${((e - s) / 1000)}s
number of solutions for base-${base} : ${cnt}
============================================================`
});
require('fs').writeFileSync('output_w2.txt', s2);


var s4 = '============================================================';
[17,21,25,29].forEach(function(base) {
  var width = 4;
  var s = Date.now();
  var x = abcdefghppp(base, width);
  var e = Date.now();
  var cnt = x[0], ans = x[1];
  s4 += `
Case base=${base}
${ans.map((x) => print(base,x)).sort().join('\n')}
time: ${((e - s) / 1000)}s
number of solutions for base-${base} : ${cnt}
============================================================`
});
require('fs').writeFileSync('output_w4.txt', s4);

