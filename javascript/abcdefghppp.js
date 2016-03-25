function permuatation(arr, permu = [], results = []) {
  switch (arr.length){
    case 0 :
      // push to results
      results.push(permu)
      return permu
    default:
      arr.forEach(a => permuatation(arr.filter(x => x != a),permu.concat([a]),results))
      return results
  }
}

function main() {
  console.debug("The script is Running, it may take a while")

  permuatation([0,1,2,3,4,5,6,7,8,9])
    .filter(possible => {
      const [a, b, c, d, e, f, g, h, p] = possible // if we assume p = 1 will run 10 time faster

      const eq1 = e*10 + f
      const eq2 = a * 10 + b  - ( c * 10 + d)
      const eq3 = p*100 + p *10 + p - (g*10 + h)

      return a > 0 && c > 0 && e > 0 && g > 0 && eq1 == eq2 && eq1 == eq3
    })
    .map(solutionInArr => {
      return {
        a: solutionInArr[0],
        b: solutionInArr[1],
        c: solutionInArr[2],
        d: solutionInArr[3],
        e: solutionInArr[4],
        f: solutionInArr[5],
        g: solutionInArr[6],
        h: solutionInArr[7],
        p: solutionInArr[8]
      }
    })
    .map(JSON.stringify)
    .forEach(elem => console.log(elem))

  console.debug("Finished")

}

main()
