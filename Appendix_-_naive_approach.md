Appendix - Naive Approach
================
Raphaël Morsomme
2019-01-10

Following the five steps for playing a hand of poker, the naive approach would use a code similar to the following:

``` r
#
# Setup
ante   <- 2
cards  <- 1 : 10
bets   <- seq(0, 20, 2)
n_card <- length(cards)
n_bet  <- length(bets )

strategy_A <- array(sample(x = bets, size = n_card, replace = T), 
                    dim = c(n_card, 1), dimnames = list(cards, "Strategy A"))
strategy_B <- array(sample(x = c("Call", "Fold"), n_card * n_bet, T),
                    dim=c(n_card, n_bet, 1), dimnames = list(cards, bets, "Strategy B"))

# Strategies of the two players
print(strategy_A)
```

    ##    Strategy A
    ## 1          20
    ## 2          12
    ## 3          14
    ## 4          10
    ## 5          12
    ## 6          20
    ## 7          14
    ## 8           4
    ## 9          14
    ## 10         10

``` r
print(strategy_B)
```

    ## , , Strategy B
    ## 
    ##    0      2      4      6      8      10     12     14     16     18    
    ## 1  "Call" "Fold" "Fold" "Call" "Call" "Call" "Fold" "Fold" "Call" "Call"
    ## 2  "Fold" "Fold" "Fold" "Fold" "Fold" "Fold" "Call" "Fold" "Fold" "Call"
    ## 3  "Call" "Fold" "Fold" "Call" "Fold" "Call" "Call" "Fold" "Fold" "Fold"
    ## 4  "Fold" "Call" "Fold" "Call" "Call" "Call" "Fold" "Fold" "Call" "Fold"
    ## 5  "Call" "Fold" "Call" "Fold" "Fold" "Call" "Call" "Fold" "Call" "Fold"
    ## 6  "Fold" "Fold" "Call" "Call" "Call" "Fold" "Fold" "Fold" "Call" "Fold"
    ## 7  "Call" "Fold" "Call" "Call" "Call" "Call" "Call" "Call" "Call" "Call"
    ## 8  "Call" "Fold" "Fold" "Fold" "Fold" "Fold" "Fold" "Fold" "Call" "Fold"
    ## 9  "Fold" "Call" "Call" "Call" "Call" "Call" "Fold" "Call" "Fold" "Call"
    ## 10 "Fold" "Fold" "Fold" "Call" "Call" "Fold" "Call" "Fold" "Fold" "Fold"
    ##    20    
    ## 1  "Fold"
    ## 2  "Fold"
    ## 3  "Call"
    ## 4  "Call"
    ## 5  "Fold"
    ## 6  "Call"
    ## 7  "Fold"
    ## 8  "Fold"
    ## 9  "Call"
    ## 10 "Call"

``` r
#
# Five Steps

# 1. Player A's Bet
card_A   <- sample(cards, 1)
bet_A    <- strategy_A[card_A]

# 2. Player B's Action
card_B   <- sample(cards, 1)
action_B <- strategy_B[card_B, match(x = bet_A, table = bets), 1]

# 3. Pot Size
if (action_B == "Fold") pot <- 2 *  ante
if (action_B == "Call") pot <- 2 * (ante + bet_A)

# 4. Winner
if(action_B == "Fold") result <- "A wins"
if(action_B == "Call"){if(card_A >  card_B) result <- "A wins"
                       if(card_A <  card_B) result <- "B wins"
                       if(card_A == card_B) result <- "draw"}

# 5. Gain/loss
if(result == "draw"  ) gain <- 0
if(result == "A wins") gain <- pot/2
if(result == "B wins") gain <- pot/2
  
# Summary
print(paste("Player A receives a", card_A, "and bets", bet_A,
            ". Player B receives a", card_B, "and decides to", action_B))
```

    ## [1] "Player A receives a 5 and bets 12 . Player B receives a 7 and decides to Call"

``` r
print(paste("The pot is", pot, "and the result of the hand is:", result))
```

    ## [1] "The pot is 28 and the result of the hand is: B wins"

It is now clear that the main difference between the two approaches is their respective speed. The *naive* approach requires us to loop through a large sunmber of hands in order to determine the average gain of two strategies opposed to one another. Given how slowly `R` handles loops, this makes this approach very inefficient. On the contrary, the *matrix-oriented* approach does not make use of loops to compute the fitness of the strategies; instead, it takes advantage of the rapidity with which `R` conducts operations on matrices.
