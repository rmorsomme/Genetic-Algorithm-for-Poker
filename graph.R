


par(mfrow = c(2, 2), cex = 1.1)

# Plots
if(generation %in% gen_print){
  
  barplot(rowMeans(pop_A), ylim = c(0, max(bets)),
          main = "Average Strategy for Player A",
          xlab = "Player A's Card", ylab = "Average Bet")
  abline(h=bets, lty=2)
  
  mtext(paste("Generation", generation), cex = 2, adj = -0.1, line = 2.5)
  
  image(cards, bets, rowMeans(pop_B == "Call", dims = 2),
        col = gray((100 : 0) / 100),
        main = "Average Strategy for Player B",
        xlab = "Player B's Card", ylab = "Average Action")
  
  plot(0 : generation, gain_A, type = "l", xlim = c(0, generation),
       main = "Average Gain/Loss (Player A)",
       xlab = "Generation", ylab = "Player A's Average Gain/Loss")
  abline(h = 0, lty = 0)
  abline(h = seq(-10, 10, 0.5), lty = 2)
  
  plot(0 : generation, call_B, type = "l", xlim = c(0, generation),
       main = "Proportion of Calls (Player B)",
       xlab = "Generation", ylab = "Average Proportion of Calls")
  abline(h = 0, lty = 0)
  abline(h = seq(-10, 10, 0.04), lty = 2)
  
} # close if-statement