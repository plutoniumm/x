is_prime <- function(num) {
  for (i in seq(2, sqrt(num))) {
    if (num %% i == 0) {
      return(FALSE)
    }
  }
  return(TRUE)
}

# Get command-line argument
args <- commandArgs(trailingOnly = TRUE)
N <- as.integer(args[1])

twin_prime_const <- 1

# Loop over numbers from 2 to N and add prime numbers to sum
for (i in 3:N) {
  if (is_prime(i)) {
    # print(i)
    term <- 1 - (1 / ((i - 1)^2))
    twin_prime_const <- twin_prime_const * term
  }
}

# Print result
cat(twin_prime_const)
