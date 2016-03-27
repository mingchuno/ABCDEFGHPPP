function* permutation(arr) {
  if( arr.length === 0 ) yield [];
  else for(var x of arr){
    let iter = permutation(arr.filter(y => y !== x));
    while(1){
      let {done, value} = iter.next();
      if( done ) break; 
      yield value.concat(x);
    }   
  }
}

function main() {
  console.debug("The script is Running, it may take a while")

  // assume the knowledge of p = 1
  let iter = permutation([0,2,3,4,5,6,7,8,9]);
  while(1){
    const {done, value} = iter.next();
    if( done ) break;

    const [a, b, c, d, e, f, g, h] = value;
    const ab=10*a+b, cd=10*c+d, ef=10*e+f, gh=10*g+h; 

    if( a > 0 && c > 0 && e > 0 && g > 0 && ab-cd === ef && ef+gh === 111 ){
      console.log(
        [a,b,'-',c,d,'=',e,f].join(''), 
        [e,f,'+',g,h,'=111'].join('')
      );
    } 
  }

  console.debug("Finished")
}

main()
