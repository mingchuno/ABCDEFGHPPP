function test(n){
  var a = n%10; n = Math.floor(n/10);
  var b = n%10; n = Math.floor(n/10);
  var c = n%10; n = Math.floor(n/10);
  var d = n%10; n = Math.floor(n/10);
  var g = n%10; n = Math.floor(n/10);
  var h = n%10; n = Math.floor(n/10); 
  var p = n%10; 
  // constraints
  if( 10*a+b < 10*c+d || 10*a+b-10*c-d+10*g+h != 111*p ) return false;
  var e = Math.floor((10*a+b-10*c-d)/10);
  var f = Math.floor((10*a+b-10*c-d)%10);
  // exclude leading zero
  if( a == 0 || c == 0 || e == 0 ) return false;
  // all digits are distinct
  var arr = [a,b,c,d,e,f,g,h,p];
  for(var i=0; i<arr.length; i++){
    for(var j=i+1; j<arr.length; j++){
      if( arr[i] == arr[j] ) return false;
    }
  }
  return true;
}
function toString(n){
  var a = n%10; n = Math.floor(n/10);
  var b = n%10; n = Math.floor(n/10);
  var c = n%10; n = Math.floor(n/10);
  var d = n%10; n = Math.floor(n/10);
  var e = Math.floor((10*a+b-10*c-d)/10);
  var f = Math.floor((10*a+b-10*c-d)%10);
  var g = n%10; n = Math.floor(n/10);
  var h = n%10; n = Math.floor(n/10); 
  var p = n%10; 
  return [a,b,'-',c,d,'=',e,f].join('') + ' ' + [e,f,'+',g,h,'=',p,p,p].join('');
}
var solution = [];
for(var i=0; i<2e6; i++){
  if( test(i) ) solution.push(i);
}
console.log(solution.map(toString).sort().join('\n'));
console.log('number of solution', solution.length);