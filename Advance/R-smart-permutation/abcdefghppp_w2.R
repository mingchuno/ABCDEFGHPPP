library(data.table)

#================================#
# Some functions
#================================#
# Function to get all possibilities of addition & ubstraction of two single-digited numbers
all_possbilility <- function(base = 10, replicate = TRUE, least = TRUE) {
  all <- as.data.table(expand.grid(d1 = 0:(base - 1), d2 = 0:(base - 1)))
  # Addition
  all <- all[, carry := trunc((d1 + d2) / base)]
  all <- all[, carry1 := trunc((d1 + d2 + 1) / base)]
  all <- all[, add := d1 + d2 - carry * base] # Addition
  all <- all[, add1 := d1 + d2 + 1 - carry1 * base] # Addition + 1 (carry)
  # Substraction
  all <- all[, sub := d1 - d2 + ((d1 - d2) < 0) * base] # Subtraction
  all <- all[, sub1 := d1 - d2 - 1 + ((d1 - d2 - 1) < 0) * base] # Subtraction + 1 (carry)
  
  all <- if (replicate) all[] else all[d1 != d2]
  return(all)
}


# Function to find
find <- function(what, target, permutation, rename = c("d1", "d2")) {
  set <- permutation[permutation[[what]] %in% target, c("d1", "d2", what), with = FALSE]
  names(set) <- rename[1:ncol(set)]
  set <- set[!duplicated(set)]
  return(set)
}


# Function to convert the digits to the desired written presentation based on the base
convert_wr <- function(x, base) {
  if (base > (10 + 26)) stop("Maximum Base supported is 36 (0-Z)")
  digit <- c(0:9, LETTERS)[1:base]
  digit[x + 1]
}


solve_w2 <- function(base) {
  all <- all_possbilility(base = base, FALSE)
  
  sol_egp <- rbind(
    find("carry", 1, all, c("e", "g", "p"))[e > 0][g > 0][e != p][g != p], 
    find("carry1", 1, all, c("e", "g", "p"))[e > 0][g > 0][e != p][g != p]
  )
  sol_egp <- sol_egp[!duplicated(sol_egp)]
  
  sol_fhp <- find("add", unique(sol_egp$p), all, c("f", "h", "p"))[f != p][h != p]
  
  sol_efghp <- merge(sol_egp, sol_fhp, by = "p", allow.cartesian = TRUE)[e != f][e != h][g != f][g != h]
  sol_efghp <- sol_efghp[(e * base + f + g * base + h - p * (base^2 + base + 1)) == 0]
  
  sol_ace <- rbind(
    find("sub", unique(sol_efghp$e), all, c("a", "c", "e"))[a > c][a > 0][c > 0][a != e][c != e],
    find("sub1", unique(sol_efghp$e), all, c("a", "c", "e"))[a > c][a > 0][c > 0][a != e][c != e]
  )
  
  sol_bdf <- find("sub", unique(sol_efghp$f), all, c("b", "d", "f"))[b != f][d != f]
  
  sol_abcdefghp <- merge(
    merge(sol_efghp, sol_ace, by = "e", allow.cartesian = TRUE)[a != f][a != g][a != h][a != p][c != f][c != g][c != h][c != p],
    merge(sol_efghp, sol_bdf, by = "f", allow.cartesian = TRUE)[b != e][b != g][b != h][b != p][d != e][d != g][d != h][d != p],
    by = c("e", "f", "g", "h", "p"), allow.cartesian = TRUE
  )
  
  sol_abcdefghp <- sol_abcdefghp[a != b][a != d][c != b][c != d]
  sol_abcdefghp <- sol_abcdefghp[(a * base + b - c * base - d - e * base - f) == 0]
  
  sol_abcdefghp <- sol_abcdefghp[order(a, b, c, d, e, f, g, h, p), list(a, b, c, d, e, f, g, h, p)]
  sol_abcdefghp[] <- lapply(sol_abcdefghp, convert_wr, base = base)
  return(sol_abcdefghp)
}


#================================#
# Output
#================================#
sink(file.choose())
cat("Machine: i5-4460; RAM: 8GB; 64-bit\n\n")
cat("----------------------------------------------------------------\n\n")
for (base in c(16, 22, 28, 34)) {
  time <- system.time({sol <- solve_w2(base)})
  
  cat("# Base", base, "- Width 2", "\n\n")
  cat("Total number of solutions:", nrow(sol), "\n\n")
  cat("First 50 solutions: \n")
  for (i in 1:50) {
    with(sol[i], cat(format(i, width = nchar(50)), ": ", a, b, " - ", c, d, " = ", e, f, "  &  ", e, f, " + ", g, h, " = ", p, p, p, "\n", sep = ""))
  }
  cat("\n")
  cat("Time Used:", time[1], "(user)", time[2], "(system)", time[3], "(elapsed) \n\n")
  cat("----------------------------------------------------------------\n\n")
}
sink()



