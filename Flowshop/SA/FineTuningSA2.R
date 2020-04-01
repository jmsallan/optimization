if(!"devtools" %in% installed.packages())
  install.packages("devtools")

if(!"combheuristics" %in% installed.packages())
  install_github("jmsallan/combheuristics")

library(combheuristics)

#----- tuning the simulated annealing -----

#picking the instance
set.seed(2020)
instance <- matrix(sample(10:90, 100, replace = TRUE), 5, 20)
# The best value we have found is 1239

#parameter list
parameter_values <- expand.grid(run=1:10, Tmax=c(5000, 10000), mu=c(500, 1000, 5000, 10000), op=c("swap", "insertion"))

#function picking values from a set of parameters and returning the heuristic to best ratio (here called fit)
testSAFS <- function(instance, inisol, lower, params){
  z <- SAFS(M=instance, inisol=inisol, Tmax=as.numeric(params[2]), mu=as.numeric(params[3]), op=params[4])$obj
  fit <- (z-lower)/lower
  return(fit)
}

#starting solution
palmer <- PalmerTrapezes(instance)$pal

# running the experiment
set.seed(2020)
h2b <- apply(parameter_values, 1, function(x) testSAFS(instance, inisol=palmer, lower=1239, x))

# obtaining a data frame with experiment results
results <- parameter_values
results$h2b <- h2b

#store the table into a csv file
setwd("~/Dropbox (UPC)/00-curso1920/MH1920q2/Experiments")
write.csv(results, "resultsSA2.csv", row.names = FALSE)





