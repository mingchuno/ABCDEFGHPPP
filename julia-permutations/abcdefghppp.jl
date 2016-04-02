#=
author: mingchuno
simple permutation brute fource
=#
array = [0 ,2 ,3, 4, 5, 6, 7 ,8, 9]

for arr in permutations(array)
  a = arr[1]
  if a == 0 continue end # fail fast

  b = arr[2]

  c = arr[3]
  if c == 0 continue end # fail fast

  d = arr[4]

  e = arr[5]
  if e == 0 continue end # fail fast

  f = arr[6]

  g = arr[7]
  if g == 0 continue end # fail fast

  h = arr[8]

  ab = a*10 + b
  cd = c*10 + d
  ef = e*10 + f
  gh = g*10 + h

  if ab - cd == ef && ef + gh == 111
    println("($(ab) - $(cd) = $(ef)) + $(gh) = 111")
  end
end
