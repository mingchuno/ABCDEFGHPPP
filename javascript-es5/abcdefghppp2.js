function pad(s){
  while(s.length < 2) s = '0'+s;
  return s;
}
function print(a,b,c,d){
  var sa = pad(a.toString());
  var sb = pad(b.toString());
  var sc = pad(c.toString());
  var sd = pad(d.toString());
  console.log(sa,'-',sb,'=',sc,' ',sc,'+',sd,'=', 111);
}
function arraySwap(arr,a,b){
  var t = arr[a];
  arr[a] = arr[b];
  arr[b] = t;
}
function arrayReverse(arr,a,b){
  a = a || 0;
  b = b || arr.length-1;
  var t = null;
  while(a < b) t=arr[a], arr[a]=arr[b], arr[b]=t, a++, b--;
}
function arrayNextPerm(arr){
  var lastIndex = arr.length-1;
  var descIndex = function(){
    var i = lastIndex-1;
    while( i >= 0 && arr[i] > arr[i+1] ) i--;
    return i;
  };
  var swapIndex = function(n,a){
    var ix = a;
    for(var i=a; i<=lastIndex; i++){
      if(n < arr[i] && arr[i] < arr[ix]) ix = i;
    }
    return ix;
  };
  var l = descIndex();
  var b = l >= 0;
  if(b) arraySwap(arr, l, swapIndex(arr[l], l+1) );
  arrayReverse(arr, l+1, lastIndex);
  return b;
}

var arr = [ 0, 2, 3, 4, 5, 6, 7, 8, 9 ];
do {
  var ab = 10*arr[0] + arr[1];
  var cd = 10*arr[2] + arr[3];
  var ef = 10*arr[4] + arr[5];
  var gh = 10*arr[6] + arr[7];
  if( ab < 10 || cd < 10 || ef < 10 || gh < 10 ) continue;
  if ( ab - cd === ef && ef + gh === 111) print(ab,cd,ef,gh);
} while( arrayNextPerm(arr) );
