#================================#
# ABCDEFGHPPP
# R code to solve
#   AB
# - CD
# ----
#   EF
# + GH
# ----
#  PPP
#================================#
library(data.table)
add <- function(x, new_vrb, base, exclude_zero = FALSE) {
  possible_value <- (exclude_zero):(base - 1)
  x_out <- NULL
  for (i in 1:nrow(x)) {
    tmp <- possible_value[!(possible_value %in% x[i, ])]
    if (length(new_vrb) == 1) {
      tmp <- data.table(tmp)
    } else {
      tmp <- gtools::permutations(length(tmp), 2, tmp)
      tmp <- data.table(tmp)
    }
    names(tmp) <- new_vrb
    tmp <- cbind(x[i, ], tmp)
    x_out <- rbind(x_out, tmp)
  }
  x_out <- setcolorder(x_out, order(names(x_out)))
  return(x_out)
}

check <- function(base = 10) {
  
}




#================================#
# Zero is not allowed for the first digit (A, C, E, G, P != 0)
#================================#
## All possible values of E and G
sol <- gtools::permutations(9, 2, 1:9)
sol <- data.table(sol)
names(sol) <- c("e", "g")
## Find all possible values of  P
sol <- add(sol, "p", base = 10, TRUE)
sol <- sol[p == trunc((e + g)/ 10)]
## Find all possible values of G and H
sol <- add(sol, c("f", "h"), base = 10)
sol <- sol[(e * 10 + f + g * 10 + h - p * 111) == 0]
## Find all possible values of B and D
sol <- add(sol, c("b", "d"), base = 10)
sol <- sol[((b - d - f) %% 10) == 0]
## Find all possible values of A and C
sol <- add(sol, c("a", "c"), base = 10, TRUE)
sol <- sol[(a * 10 + b - c * 10 - d - e * 10 - f) == 0]
sol <- sol[order(a, b, c, d, e, f, g, h, p)]
sol

