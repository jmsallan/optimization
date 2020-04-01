#---- two codings of the makespan function ----

makespan1 <- function(M, sol){
  
  m <- dim(M)[1]
  n <- dim(M)[2]
  
  t <- matrix(numeric(m*n), m, n)
  
  M <- M[ , sol]
  
  t[1,1] <- M[1,1]
  
  for(j in 2:n) t[1, j] <- t[1, (j-1)] + M[1, j]
  for(i in 2:m) t[i, 1] <- t[(i-1), 1] + M[i, 1]
  
  for(i in 2:m){
    for(j in 2:n)
      t[i,j] <- max(t[i-1,j], t[i, j-1]) + M[i, j]
  }
  
  result <- t[m, n]
  return(result)
}

makespan2 <- function(M, sol){
  
  m <- dim(M)[1]
  n <- dim(M)[2]
  
  M <- M[ , sol]
  
  
  for(j in 2:n) M[1, j] <- M[1, (j-1)] + M[1, j]
  for(i in 2:m) M[i, 1] <- M[(i-1), 1] + M[i, 1]
  
  for(i in 2:m){
    for(j in 2:n)
      M[i,j] <- max(M[i-1,j], M[i, j-1]) + M[i, j]
  }
  
  return(M[m, n])
}

#---- which is faster? -----

#building a random instance of 10 machines and 20 tasks
set.seed(2020)
instance <- matrix(sample(10:90, 200, replace = TRUE), 10, 20)

#building a list of 1000 possible solutions
set.seed(1111)
perms <- lapply(1:1000, function(x) sample(1:20, 20))

#testing speed of two makespan functions
library(rbenchmark)
benchmark(sapply(perms, function(x) makespan1(instance, x)), sapply(perms, function(x) makespan2(instance, x)))


