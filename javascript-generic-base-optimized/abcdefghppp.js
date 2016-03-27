// O( base^(base/2+1) )
// the time complexity is same as brute force (well, NP problem), but somehow reduce the coefficient

// use any base you like ^^
const base = 10;              
// const base = 17;
const noLeadingZero = true;

var width = Math.floor((base-1)/4);
var minBnd = 1;
for(var i=1; i<width; i++) minBnd *= base;
var e = 1;
for(var i=0; i<width; i++) e = base*e+1;

console.log('Question: find a,b,c,d such that');
console.log('1. all with distinct digits in base-N.');
console.log('2. all have W=floor(N/4) number of digits');
console.log('3. a-b=c+d=e=11...1 (W number of 1)\n');

function bsearch(a,b,test){
  while(b-a>1){
    var mid = Math.floor((a+b)/2);
    test(mid) ? b = mid : a = mid 
  }
  return b;
}

function pad(s){
  while(s.length < width ) s = '0'+s;
  return s;
}
function print(a,b,c,d){
  var sa = pad(a.toString(base));
  var sb = pad(b.toString(base));
  var sc = pad(c.toString(base));
  var sd = pad(d.toString(base));
  var se = pad((a-b+d).toString(base));
  return [sa,'-',sb,'=',sc,',',sc,'+',sd,'=',se].join('');
}

// O( B )
function check2(a,b){
  var used = new Array(base);
  for(var i=0; i<base; i++) used[i] = false;
  used[1] = true;
  var test = function(x){
    var w = width;
    while( w-- ){
      var t = x % base;
      if( used[t] ) return false;
      used[t] = true;
      x = (x-t)/base;
    }
    return true;
  };
  return test(a) && test(b);
}

// O( B )
function check4(a,b,c,d){
  var used = new Array(base);
  for(var i=0; i<base; i++) used[i] = false;
  used[1] = true;
  var test = function(x){
    var w = width;
    while( w-- ){
      var t = x % base;
      if( used[t] ) return false;
      used[t] = true;
      x = (x-t)/base;
    }
    return true;
  };
  return test(a) && test(b) && test(c) && test(d);
}

// generate possible set of a,b,c,d O(base^width)
var arr = [];
var used = new Array(base);
for(var i=0; i<base; i++) used[i] = false;
used[1] = true;
function generate(w,v){
  if( w == width ){
    arr.push(v);
    return;
  }
  var start = noLeadingZero && w === 0 ? 2 : 0;
  for(var i=start; i<base; i++){
    if( used[i] ) continue;
    used[i] = true;
    generate(w+1, base*v+i);
    used[i] = false;
  }
}
generate(0,0);
console.log('number of '+width+'-distinct-digits:', arr.length);

// find all candidate pairs of c and d O(base^(width+1)*ln(B))
var ds = [], cs = [];
for(var i=0; i<arr.length; i++){
  var c = arr[i], d = e - c;
  var ix = bsearch(0,arr.length, function(j){
    return d <= arr[j]
  });
  // c and c should not share same digit
  if( d === arr[ix] && check2(c,d) ){
    cs.push(c); ds.push(d);
  }
}
console.log('number of candidates of (c,d):', ds.length);

// O( base^(2*width+1) )
console.log('number of cases to consider:', arr.length * cs.length); 
var ans = [];
for(var i=0; i<arr.length; i++){
  var a = arr[i], end;
  if( noLeadingZero ){ 
    end = bsearch(-1, cs.length, function(x){
      return a - cs[x] < minBnd;
    })
  }
  else {
    end = bsearch(-1, cs.length, function(x){
      return a < cs[x];
    })
  }
  for(var j=0; j<end; j++){
    var c = cs[j], d = ds[j];
    var b = a - c;
    if( check4(a,b,c,d) ) ans.push(print(a,b,c,d));
  }
}
console.log(ans.join('\n'));
console.log('number of solutions:', ans.length);

// require('fs').writeFile('sol_' + base, ans.join('\n'));

