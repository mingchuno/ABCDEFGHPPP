function print(a,b,c,d){
  var sa = a.toString();
  var sb = b.toString();
  var sc = c.toString();
  var sd = d.toString();
  console.log([sa,'-',sb,'=',sc,' ',sc,'+',sd,'=', 111].join(''));
}
function nextPerm(lis){
  var len = lis.length;
  function findMaxDecIx(){
    for(var i=len-2; i >= 0; i-- ){
      if( lis[i] < lis[i+1] ) return i;
    }
    return -1;
  }
  function findMinLargerIx(i){
    var j, t = lis[i];
    for(j=len-1; j>i; j--){
      if( lis[j] > t ) break;
    }
    return j;
  }
  function swap(i, j){
    var t = lis[i];
    lis[i] = lis[j];
    lis[j] = t;
  }
  function reverse(i, j){
    while( i < j ) swap(i++, j--);
  }
  // main process
  var p = findMaxDecIx();
  if( p === -1 ){
    reverse(0,len-1);     // clean up
    return true;          // signal true finish one cycle
  }
  else {
    swap(p, findMinLargerIx(p));
    reverse(p+1, len-1);
    return false;
  }
}

var arr = [ 0, 2, 3, 4, 5, 6, 7, 8, 9 ];
while(1) {
  var ab = 10 * arr[0] + arr[1];
  var cd = 10 * arr[2] + arr[3];
  var ef = 10 * arr[4] + arr[5];
  var gh = 10 * arr[6] + arr[7];
  if (ab > 9 && cd > 9 && ef > 9 && gh > 9 && ab - cd === ef && ef + gh === 111) print(ab, cd, ef, gh);
  if ( nextPerm(arr) ) break;
}
