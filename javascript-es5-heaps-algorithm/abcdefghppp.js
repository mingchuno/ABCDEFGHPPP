function print(a,b,c,d){
  var sa = a.toString();
  var sb = b.toString();
  var sc = c.toString();
  var sd = d.toString();
  console.log([sa,'-',sb,'=',sc,' ',sc,'+',sd,'=', 111].join(''));
}

function allPerm(lis, callback){
  function swap(a,b){
    var t = lis[a];
    lis[a] = lis[b];
    lis[b] = t;
  }
  function run(n){
    if( n === 0 ) callback();
    else for(var i=0; i<=n; i++){
      run(n-1);
      swap(n&1?0:i,n);
    }
  }
  run(lis.length-1);
}

var arr = [ 0, 2, 3, 4, 5, 6, 7, 8, 9 ];
allPerm(arr, function() {
  var ab = 10 * arr[0] + arr[1];
  var cd = 10 * arr[2] + arr[3];
  var ef = 10 * arr[4] + arr[5];
  var gh = 10 * arr[6] + arr[7];
  if (ab < 10 || cd < 10 || ef < 10 || gh < 10) return;
  if (ab - cd === ef && ef + gh === 111) print(ab, cd, ef, gh);
});
