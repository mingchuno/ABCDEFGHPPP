#=
author: mingchuno
smart permutation inspired by python-high-perf
=#
array = [0 ,2 ,3, 4, 5, 6, 7 ,8, 9]
sarray = Set(array)

for last4_arr in combinations(array, 4), efgh_arr in permutations(last4_arr)
  e = efgh_arr[1]
  if e == 0 continue end # fail fast

  f = efgh_arr[2]

  g = efgh_arr[3]
  if g == 0 continue end # fail fast

  h = efgh_arr[4]

  ef = e*10 + f
  gh = g*10 + h

  if ef + gh == 111
    remain_arr = collect(setdiff(sarray, Set(last4_arr)))
    for first4_arr in combinations(remain_arr, 4), abcd_arr in permutations(first4_arr)
      a = abcd_arr[1]
      if a == 0 continue end # fail fast

      b = abcd_arr[2]

      c = abcd_arr[3]
      if c == 0 continue end # fail fast

      d = abcd_arr[4]
      ab = a*10 + b
      cd = c*10 + d
      if ab - cd == ef
        println("($(ab) - $(cd) = $(ef)) + $(gh) = 111")
      end
    end
  end
end
