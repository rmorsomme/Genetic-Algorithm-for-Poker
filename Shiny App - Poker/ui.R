
# Setup
library(shiny)
library(ggplot2)
load("results.RDATA")

fluidPage(
  
  # App title
  titlePanel("Results of the Simulations"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      # Input: Buttons for the parameters
      radioButtons(inputId = "dataset",
                   label = "Simulation",
                   choices = c("default (ante = 5, mutation rate = 0.05)" = "results_ante_05_mut_05",
                               "ante = 0" = "results_ante_00_mut_01",
                               "ante = 10" = "results_ante_10_mut_05",
                               "mutation rate = 0.001" = "results_ante_05_mut_001",
                               "mutation rate = 0.01" = "results_ante_05_mut_01",
                               "mutation rate = 0.1" = "results_ante_05_mut_10")),
      
      # Horizontal line
      tags$hr(),
      
      # Input: Slider for the generation
      sliderInput(inputId = "generation",
                  label = "Generation",
                  min = 1, 
                  max = 125,
                  value = 1,
                  animate = animationOptions(interval = 250, loop = TRUE))
      
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      
      # Output: barplot
      plotOutput(outputId = "average"),
      textOutput(outputId = "av_bet"),
      textOutput(outputId = "av_gain"),
      textOutput(outputId = "av_call"),
      plotOutput(outputId = "best")
      
    )
  )
)