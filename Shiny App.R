
# Setup
load("results.RDATA")
library(shiny)

# Define UI for app
ui <- fluidPage(
  
  # App title
  titlePanel("Results of the Simulations"),
  
  # Sidebar layout
  sidebarLayout(
    
    # Sidebar panel for inputs
    sidebarPanel(
      
      # Input: Buttons for the parameters
      radioButtons(inputId = "dataset",
                   label = "Parameters",
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

# Define server logic required to draw a histogram ----
server <- function(input, output) {

  output$average <- renderPlot({
    
    dataset <- get(input$dataset)
    #dataset <- reactive({ get(input$dataset) })
    
    par(mfrow = c(1, 2))
    
    barplot(rowMeans(dataset$A[ , , input$generation]), 
            ylim = c(0, 20),
            main = "Average Strategy for Player A",
            xlab = "Player A's Card",
            ylab = "Average Bet")
    abline(h=seq(0,20,2), lty=2)
    
    image(1:10, seq(0,20,2),
          rowMeans(dataset$B[ , , , input$generation] == "Call", dims = 2),
          col = gray((100 : 0) / 100),
          main = "Average Strategy for Player B",
          xlab = "Player B's Card", ylab = "Player A's bet")
  })
  
  output$best <- renderPlot({
    
    par(mfrow = c(1, 2))
    dataset <- get(input$dataset)
    fitness <- dataset$fit[ , , input$generation]
    strat_fittest_A <- names(sort(colMeans(fitness), decreasing  = T)[1])
    strat_fittest_B <- names(sort(rowMeans(-fitness), decreasing  = T)[1])
    
    barplot(dataset$A[ , strat_fittest_B, input$generation], 
            ylim = c(0, 20),
            main = "Best Strategy for Player A",
            xlab = "Player A's Card",
            ylab = "Bet")
    abline(h=seq(0,20,2), lty=2)
    
    image(1:10, seq(0,20,2),
          dataset$B[ , , strat_fittest_A, input$generation] == "Call",
          col = gray((100 : 0) / 100),
          main = "Best Strategy for Player B",
          xlab = "Player B's Card",
          ylab = "Player A's bet")
  })
  
  output$av_bet <- renderText({
    
    dataset <- get(input$dataset)
    
    print(paste("Player A bets on average", round(mean(dataset$A[ , , input$generation] ), 2), "per hand."))
    
  })
  
  output$av_gain <- renderText({
    
    dataset <- get(input$dataset)
    
    print(paste("Player A gains on average", round(mean(dataset$fit[ , , input$generation] ), 2), "per hand."))
    
  })
  
  output$av_call <- renderText({
    
    dataset <- get(input$dataset)
    
    print(paste("Player B calls ", round(100 * mean(dataset$B[ , , , input$generation]  == "Call"), 1), "% of the time.", sep = ""))
    
  })
  
}

# Create Shiny app
shinyApp(ui = ui, server = server)
