Results
================
Raphaël Morsomme
2019-01-12

Since RMD script with a shiny component still runs the chunks that are cached (`cache = TRUE`), I cache the output of the GA (very time consuming) by hand.

``` r
library(tidyverse)
library(gdata)

# Setup
load("functions.RDATA")
n_generation <- 125
set.seed(123)

# Running the GA
results_ante_05_mut_05  <- my_GA(n_generation = n_generation)
results_ante_10_mut_05  <- my_GA(ante = 10, n_generation = n_generation)
results_ante_00_mut_01  <- my_GA(ante = 0, mutation_rate = 0.01, n_generation = n_generation)
results_ante_05_mut_01  <- my_GA(mutation_rate = 0.01, n_generation = n_generation)
results_ante_05_mut_10  <- my_GA(mutation_rate = 0.1, n_generation = n_generation)
results_ante_05_mut_001 <- my_GA(mutation_rate = 0.001, n_generations = n_generation)

# Saving results
save(results_ante_05_mut_05, results_ante_10_mut_05,
     results_ante_00_mut_01, results_ante_05_mut_01,
     results_ante_05_mut_10, results_ante_05_mut_001,
     file = "results.RDATA")
```