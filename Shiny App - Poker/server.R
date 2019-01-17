
# Setup
library(shiny)
library(ggplot2)
load("results.RDATA")

# Server
function(input, output) {
  
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
    
    paste("Player A bets on average", round(mean(dataset$A[ , , input$generation] ), 2), "per hand.")
    
  })
  
  output$av_gain <- renderText({
    
    dataset <- get(input$dataset)
    
    paste("Player A gains on average", round(mean(dataset$fit[ , , input$generation] ), 2), "per hand.")
    
  })
  
  output$av_call <- renderText({
    
    dataset <- get(input$dataset)
    
    paste("Player B calls ", round(100 * mean(dataset$B[ , , , input$generation]  == "Call"), 1), "% of the time.", sep = "")
    
  })
  
}