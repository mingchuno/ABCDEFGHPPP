#=
author: mingchuno
smart permutation inspired by python-high-perf
TODO: parallel & mutil core, compile?, README and output
=#

BASE = 22
PPP = sum(map(x -> BASE^x,0:2)) # generic PPP
println("PPP is:$(PPP)")
array = sort(collect(setdiff(Set(0:BASE-1), Set(1))))
sarray = Set(array)
count = 0

@time for last4_arr in combinations(array, 4), efgh_arr in permutations(last4_arr)
  @inbounds e = efgh_arr[1]
  if e == 0 continue end # fail fast

  @inbounds f = efgh_arr[2]

  @inbounds g = efgh_arr[3]
  if g == 0 continue end # fail fast

  @inbounds h = efgh_arr[4]

  ef = e*BASE + f
  gh = g*BASE + h

  if ef + gh == PPP
    remain_arr = collect(setdiff(sarray, Set(last4_arr)))
    for first4_arr in combinations(remain_arr, 4), abcd_arr in permutations(first4_arr)
      @inbounds a = abcd_arr[1]
      if a == 0 continue end # fail fast

      @inbounds b = abcd_arr[2]

      @inbounds c = abcd_arr[3]
      if c == 0 continue end # fail fast

      @inbounds d = abcd_arr[4]
      ab = a*BASE + b
      cd = c*BASE + d
      if ab - cd == ef
        println("($(base(BASE,ab)) - $(base(BASE,cd)) = $(base(BASE, ef))) + $(base(BASE,gh)) = 111")
        count += 1
      end
    end
  end
end

println("Total number of soln is:$(count)")
