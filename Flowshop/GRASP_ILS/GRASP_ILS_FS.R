## ----setup, include=FALSE------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)


## ---- eval=FALSE---------------------------------------------------------
## # generator of starting solutions for a GRASP heuristic
## PalmerGenerator <- function(M, rcl=4){
## 
##   m <- dim(M)[1]
##   n <- dim(M)[2]
##   S <- matrix(0, 2, n)
## 
##   for(j in 1:n)
##     for(i in 1:m){
##       S[1, j] <- S[1, j] + (m - i)*M[i, j]
##       S[2, j] <- S[2, j] + (i - 1)*M[i, j]
##     }
## 
## 
##   diff <- S[1, ] - S[2, ]
##   palmer <- order(diff)
## 
##   grasp <- numeric(n)
## 
##   chosen <- rep(FALSE, n)
## 
##   for(i in 1:n){
##     k <- sample(1:min(rcl, n-i+1), 1)
##     j <- which(chosen==FALSE)[k]
##     grasp[i] <- palmer[j]
##     chosen[j] <- TRUE
##   }
## 
##   return(grasp)
## }


## ---- eval=FALSE---------------------------------------------------------
## GRASPFS <- function(M, rcl=4, iter=100, op="swap", opt="HC", ...){
## 
##   params <- list(...)
## 
##   if(!opt %in% c("HC", "TS", "SA"))
##     return(success==FALSE)
## 
##   n <- dim(M)[2]
##   bestsol <- numeric(n)
##   bestfit <- Inf
## 
##   for(t in 1:iter){
## 
##     seed_sol <- PalmerGenerator(M, rcl=rcl)
## 
##     if(opt=="HC")
##       test_sol <- HCFS(M, seed_sol, op=op)
## 
##     if(opt=="TS")
##       test_sol <- TSFS(M, seed_sol, iter=25, op=op, early = TRUE)
## 
##     if(opt=="SA"){
##       if(is.null(params$Tmax) & is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, op=op)
##       if(!is.null(params$Tmax) & is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, Tmax=params$Tmax, op=op)
##       if(is.null(params$Tmax) & !is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, mu=params$mu, op=op)
##       if(!is.null(params$Tmax) & !is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, Tmax=params$Tmax, mu=params$mu, op=op)
##     }
## 
## 
##     if(test_sol$obj < bestfit){
##       bestsol <- test_sol$sol
##       bestfit <- test_sol$obj
##     }
## 
##   }
## 
##   return(list(sol=bestsol, obj=bestfit))
## }


## ---- eval=FALSE---------------------------------------------------------
## PerturbationInsertion <- function(v, ni=4){
##   n <- length(v)
##   for(i in 1:ni){
##     ch <- sample(1:n, 2)
##     v <- insertion(v, ch[1], ch[2])
##   }
##   return(v)
## }


## ---- eval=FALSE---------------------------------------------------------
## ILSFS <- function(M, ni=4, iter=100, opt="HC", ...){
## 
##   params <- list(...)
## 
##   if(!opt %in% c("HC", "TS", "SA"))
##     return(success==FALSE)
## 
##   n <- dim(M)[2]
##   bestsol <- numeric(n)
##   bestfit <- Inf
## 
##   sol <- PalmerTrapezes(M)$pal
##   fit <- makespan(M, sol)
## 
##   for(i in 1:iter){
## 
##     seed_sol <- PerturbationInsertion(sol)
## 
##     if(opt=="HC")
##       test_sol <- HCFS(M, seed_sol, op=op)
## 
##     if(opt=="TS")
##       test_sol <- TSFS(M, seed_sol, iter=25, op="swap", early = TRUE)
## 
##     if(opt=="SA"){
##       if(is.null(params$Tmax) & is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, op="swap")
##       if(!is.null(params$Tmax) & is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, Tmax=params$Tmax, op="swap")
##       if(is.null(params$Tmax) & !is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, mu=params$mu, op="swap")
##       if(!is.null(params$Tmax) & !is.null(params$mu))
##         test_sol <- SAFS(M, seed_sol, Tmax=params$Tmax, mu=params$mu, op="swap")
##     }
## 
##     if(test_sol$obj < fit){
##       sol <- test_sol$sol
##       fit <- test_sol$obj
##     }
## 
##     if(test_sol$obj < bestfit){
##       bestsol <- test_sol$sol
##       bestfit <- test_sol$obj
##     }
##   }
## 
##   return(list(sol=bestsol, obj=bestfit))
## 
## }


## ------------------------------------------------------------------------
library(combheuristics)


## ------------------------------------------------------------------------
set.seed(2020)
instance <- matrix(sample(10:90, 100, replace = TRUE), 5, 20)


## ------------------------------------------------------------------------
set.seed(2020)


#Standard options of the GRASP function, including Hill climbing.
GRASP01 <- GRASPFS(instance, iter=50)
GRASP01$obj

#GRASP with simulated annealing.
GRASP02 <- GRASPFS(instance, opt="SA", iter=50, Tmax=5000, mu=2500)
GRASP02$obj

#GRASP with tabu search.
GRASP03 <- GRASPFS(instance, iter=50, opt="TS")
GRASP03$obj


## ------------------------------------------------------------------------
#Standard options of the ILS function, including Hill climbing.
ILS01 <- ILSFS(instance, iter=50)
ILS01$obj

#GRASP with simulated annealing.
set.seed(2020)
ILS02 <- ILSFS(instance, iter=50, opt="SA", Tmax=5000, mu=2500)
ILS02$obj

#ILS with tabu search.
ILS03 <- ILSFS(instance, iter=50, opt="TS")
ILS03$obj
ILS03$sol

