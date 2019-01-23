
# Setup
library(shiny)
library(ggplot2)
load("results0.RDATA")
load("results5.RDATA")
load("results10.RDATA")

fluidPage(
  
  # App title
  titlePanel("Results of the Simulations"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      # Input: Buttons for the ante
      selectInput(inputId = "ante",
                  label = "Ante",
                  choices = c("0",
                              "5",
                              "10"),
                  selected = "0"),
      
      # Input: Buttons for the mutation rate
      selectInput(inputId = "mut_rat",
                  label = "Mutaton Rate",
                  choices = c("0.001",
                              "0.01",
                              "0.05",
                              "0.1"),
                  selected = "0.01"),
      
      # Input: Slider for the generation
      sliderInput(inputId = "generation",
                  label = "Generation",
                  min = 1, 
                  max = 150,
                  value = 5,
                  step = 1,
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