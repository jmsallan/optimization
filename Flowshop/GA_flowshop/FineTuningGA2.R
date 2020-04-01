library(GA)
library(combheuristics)

makespanGA <- function(M, sol){
  
  m <- dim(M)[1]
  n <- dim(M)[2]
  
  M <- M[ , sol]
  
  for(j in 2:n) M[1, j] <- M[1, (j-1)] + M[1, j]
  for(i in 2:m) M[i, 1] <- M[(i-1), 1] + M[i, 1]
  
  for(i in 2:m)
    for(j in 2:n)
      M[i,j] <- max(M[i-1,j], M[i, j-1]) + M[i, j]
  
  
  return(-M[m, n])
}


parameter_values <- expand.grid(instance=1:10, selection=c("gaperm_lrSelection", "gaperm_nlrSelection"), crossover=c("gaperm_cxCrossover", "gaperm_oxCrossover"), mutation=c("gaperm_ismMutation", "gaperm_swMutation"), popsize=c(50, 100), pcrossover=c(1, 0.8), pmutation=c(0.1, 0.2, 0.5), seed=1:5)

instance_list <- Taillard_FS$tai.20.5

testGAFS <- function(list, params){
  instance <- list[[as.numeric(params[1])]]
  
  gaControl("permutation" = list(selection = params[2], crossover = params[3], mutation = params[4]))
  
  ga_output <- ga(type = "permutation", fitness = makespanGA, M=instance$tij, lower = 1, upper = instance$n, popSize=as.numeric(params[5]), maxiter = 150, pmutation = as.numeric(params[6]), seed=as.numeric(params[7]), monitor = FALSE)
  
  z <- -ga_output@fitnessValue
  
  fit <- (z-instance$lower)/(instance$upper - instance$lower)
  return(fit)
}

h2b <- apply(parameter_values, 1, function(x) testGAFS(list=instance_list, params=x))



# obtaining a data frame with experiment results
results <- parameter_values
results$h2b <- h2b

#store the table into a csv file
setwd("~/Dropbox (UPC)/00-curso1920/MH1920q2/Experiments")
write.csv(results, "resultsGAtai20_5.csv", row.names = FALSE)

