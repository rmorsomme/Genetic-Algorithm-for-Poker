Results
================
Raphaël Morsomme
2019-02-25

``` r
library(tidyverse)
library(gdata)
library(rlang)
```

I simulate `150` generations with the GA across three levels of ante (`ante`) 0, 5, 10 and four levels of mutation rate (`mut_rates`) 0.001, 0.01, 0.05, 0.1 and save the results for the [Shiny App](https://rmorsomme.shinyapps.io/shiny_app_-_poker/).

``` r
#
# Setup
load("functions.RDATA")
n_generation <- 125
set.seed(123)


#
# Running the GA

antes <- c(0, 5, 10)
mut_rates <- c(0.001, 0.01, 0.05, 0.1)

for(ante in antes){
  
  simul_names <- character(0)
  
  for(mut_rate in mut_rates){
    
    simul_name <- paste(
      "results_ante_", ante, 
      "mut_", mut_rate, 
      sep = ""
      )
    
    simul_results <- my_GA(
      n_generation  = n_generation,
      ante          = ante,
      mutation_rate = mut_rate
      )
    
    assign(
      x     = simul_name,
      value = simul_results
      )
    
    simul_names <- c(simul_names, simul_name)
    
  }
  
  
  #
  # Saving results
  save(
    list = simul_names,
    file = paste("Shiny App - Poker/results", ante, ".RDATA", sep = "")
       )
  
}
```
