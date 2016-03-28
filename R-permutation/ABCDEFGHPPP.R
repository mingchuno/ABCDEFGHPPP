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


# Store all permutations to 'x'
# install.packages("gtools") # install packages 'gtool'
x <- gtools::permutations(10, 9 , 0:9) 

colnames(x) <- c(LETTERS[1:8], "P")  # add column names

# Solution
sol <- x[(10 * (x[, "A"] - x[, "C"] - x[, "E"]) + (x[, "B"] - x[, "D"] - x[, "F"])) == 0,] 
sol <- sol[(10 * (sol[, "E"] + sol[, "G"]) + (sol[, "F"] + sol[, "H"]) - 111 * sol[, "P"]) == 0,]
print(sol)

# Solution, 1st digit cannot be zero
sol_no_zero <- sol[sol[, "A"] & sol[, "C"] & sol[, "E"] & sol[, "P"], ]
print(sol_no_zero)


# Print all solutions
for (i in 1:nrow(sol)) {
  cat("Solution", i, ":\n")
  cat("  ", sol[i, c("A", "B")], "\n", sep = "")
  cat("- ", sol[i, c("C", "D")], "\n", sep = "")
  cat("----", "\n")
  cat("  ", sol[i, c("E", "F")], "\n", sep = "")
  cat("+ ", sol[i, c("G", "H")], "\n", sep = "")
  cat("----", "\n")
  cat(" ", sol[i, c("P", "P", "P")], "\n", sep = "")
  cat(" ===", "\n\n")
}




