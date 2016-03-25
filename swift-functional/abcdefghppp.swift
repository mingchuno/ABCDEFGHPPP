func permutation(xs: [Int], permu: [Int] = [], results: [[Int]] = [])(solutionFilter:([Int] -> Bool)) -> [[Int]]{
    switch xs.count {
    case 0 :
        return solutionFilter(permu) ? results + [permu] : results
        
    default :
        return xs.flatMap({ x in
            permutation(
                xs.filter({ elem in elem != x }),
                permu: [x] + permu,
                results: results
            )(solutionFilter: solutionFilter)
        })
    }
}

permutation([0,2,3,4,5,6,7,8,9])(solutionFilter: { xs in
    let a = xs[0]
    let b = xs[1]
    let c = xs[2]
    let d = xs[3]
    let e = xs[4]
    let f = xs[5]
    let g = xs[6]
    let h = xs[7]
    
    let r1 = a > 0 && c > 0 && e > 0 && g > 0
    let r2 = (a * 10 + b) - (c * 10 + d) == (e * 10 + f)
    let r3 = 111 - (g * 10 + h) == (e * 10 + f)
    
    return r1 && r2 && r3
}).forEach{ sol in
    print("********")
    print("  \(sol[0])\(sol[1])")
    print(" -\(sol[2])\(sol[3])")
    print("-----")
    print("  \(sol[4])\(sol[5])")
    print(" +\(sol[6])\(sol[7])")
    print("-----")
    print(" 111")
    print("********") 
}