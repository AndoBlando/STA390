# R parallel testing script

# Note: the following packages may not be installed on the server
# But, we can install them directly on the server
# install.packages(c("foreach","doMC")) # will attempt to install on the server
# but since you will not have the write permissions in the `typical` directory,
# you can instead install it in a local directory.

library(foreach) # for loops in parallel
library(doMC) # specify number of cores to use


registerDoMC(50) # number of cores to use
Num_iter = 50

# loop in parallel
results_list<-foreach(k=1:Num_iter) %dopar% {
  Sys.sleep(10)
  k*2 # output of each iteration
}
unlist(results_list) # want vector answer from list output
