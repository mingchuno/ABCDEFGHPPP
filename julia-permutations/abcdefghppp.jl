#=
author: mingchuno
simple permutation brute fource
=#
array = [0 ,2 ,3, 4, 5, 6, 7 ,8, 9]

# Since 9P9 == 9P8
for i=1:factorial(9)
  temp_arr = nthperm(array, i)
  a = temp_arr[1]
  if a == 0 continue end # fail fast

  b = temp_arr[2]

  c = temp_arr[3]
  if c == 0 continue end # fail fast

  d = temp_arr[4]

  e = temp_arr[5]
  if e == 0 continue end # fail fast

  f = temp_arr[6]

  g = temp_arr[7]
  if g == 0 continue end # fail fast

  h = temp_arr[8]

  ab = a*10 + b
  cd = c*10 + d
  ef = e*10 + f
  gh = g*10 + h

  if ab - cd == ef && ef + gh == 111
    println("($(ab) - $(cd) = $(ef)) + $(gh) = 111")
  end
end
