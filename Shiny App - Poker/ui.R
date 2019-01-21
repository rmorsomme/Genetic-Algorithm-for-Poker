
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
      
      # Input: Slider for the generation
      sliderInput(inputId = "generation",
                  label = "Generation",
                  min = 1, 
                  max = 125,
                  value = 1,
                  animate = animationOptions(interval = 250, loop = TRUE)),
      
      # Horizontal line
      tags$hr(),
      
      # Text
      helpText("Upper left corner: the height of the bars corresponds to the size of the bets in player A's best strategy of the generation."),
      helpText("Upper right corner: the color of the tiles corresponds to player B's action in her/his best strategy of the generation (white is fold and black is call)."),
      helpText("Lower left corner: the height of the bars corresponds to the average size of the bets effectuated by player A in the generation."),
      helpText("Lower right corner: the color of the tiles corresponds to the proportion of player B's strategies that call in the generation.")
      
    ),
    
    # Main panel for displaying outputs
    mainPanel(
      
      # Output: barplot
      h3(textOutput(outputId = "title"), align = "center"),
      plotOutput(outputId = "best"),
      h6(textOutput(outputId = "av_bet" ), align = "center"),
      h6(textOutput(outputId = "av_gain"), align = "center"),
      h6(textOutput(outputId = "av_call"), align = "center"),
      plotOutput(outputId = "average")
      
    )
  )
)