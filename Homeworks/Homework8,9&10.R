library(stringr)
library(readxl)
library(dplyr)
library(tidyverse)
library(ggplot2)
library(skimr)
library(kableExtra)
library(lubridate)
library(devtools)
parenvs(all = TRUE)

# download and load the deck.csv file to complete the following exercises
deck <- read.csv('~/Documents/DATA/Data 332/files given/deck.csv')

# Chapter 8 
#the S3 system
num <- 1000000000
print(num)

#to desplay time
class(num) <- c("POSIXct", "POSIXt")
print(num)

# to see an object’s attributes with attribute
attributes(deck)
row.names(deck)

#to change an attribute’s value:
row.names(deck) <- 101:152

# to give an object a new attribute altogether
levels(deck) <- c("level 1", "level 2", "level 3")
attributes(deck)

# Exercise 1, (Modify play to return a prize that contains the symbols associated with it as an attribute named symbols)
#from chap 6&7
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}
score(c("DD", "DD", "DD"))

play <- function() {
  symbols <- get_symbols()
  print(symbols)
  score(symbols)
}
# to generate a prize and set its attributes in one step with the structure function
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}
#to write your own functions that lookup and use the attribute
play <- function() {
  symbols <- get_symbols()
  prize <- score(symbols)
  attr(prize, "symbols") <- symbols
  prize
}
one_play <- play()

slot_display <- function(prize){
  symbols <- attr(prize, "symbols")
  symbols <- paste(symbols, collapse = " ")
  cat(string)
}

slot_display(one_play)
#We can use one_play’s symbols attribute to do the job
symbols <- attr(one_play, "symbols")
symbols

symbols <- paste(symbols, collapse = " ")
symbols

prize <- one_play
string <- paste(symbols, prize, sep = "\n$")
string
# We can use slot_display to manually clean up the output of play
slot_display(play())
slot_display(play())

# Generic function
print(pi)
print(head(deck))
print.POSIXct
print.factor
methods(print)

# Exercise 2, Write a new print method for the slots class. The method should call slot_display to return well-formatted slot-machine output.
print.slots <- function(x, ...)
{ slot_display(x)
}
one_play


# Exercise 3, Modify the play function so it assigns slots to the class attribute of its output:
play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols)
}

play <- function() {
  symbols <- get_symbols()
  structure(score(symbols), symbols = symbols, class = "slots")
}

class(play())

# Chapter 9
#old die
die <- c(1, 2, 3, 4, 5, 6)
rolls <- expand.grid(die, die)
rolls
rolls$value <- rolls$Var1 + rolls$Var2
head(rolls, 3)

prob <- c("1" = 1/8, "2" = 1/8, "3" = 1/8, "4" = 1/8, "5" = 1/8, "6" = 3/8)
prob
rolls$Var1
#The expand.grid function
rolls <- expand.grid(die, die)

#three-step process for calculating these probabilities in R
rolls$prob1 <- prob[rolls$Var1]
head(rolls, 3)

rolls$prob2 <- prob[rolls$Var2]
head(rolls, 3)

rolls$prob <- rolls$prob1 * rolls$prob2
head(rolls, 3)
sum(rolls$value * rolls$prob)

# Exercise 1
#Use expand.grid to make a data frame that contains every possible combination of three symbols from the wheel vector
wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
combos <- expand.grid(wheel, wheel, wheel, stringsAsFactors = FALSE)
combos

get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0")
  sample(wheel, size = 3, replace = TRUE,
         prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

# Exercise 2
#Isolate the previous probabilities in a lookup table. What names will you use in your table?
prob <- c("DD" = 0.03, "7" = 0.03, "BBB" = 0.06,
          "BB" = 0.1, "B" = 0.25, "C" = 0.01, "0" = 0.52)


combos$prob1 <- prob[combos$Var1]
combos$prob2 <- prob[combos$Var2]
combos$prob3 <- prob[combos$Var3]
head(combos, 3)

# Exercise 3, Calculate the overall probabilities for each combination
combos$prob <- combos$prob1 * combos$prob2 * combos$prob3
head(combos, 3)
sum(combos$prob)
symbols <- c(combos[1, 1], combos[1, 2], combos[1, 3])
score(symbols)

# For loops

for (value in c("My", "first", "for", "loop")) {
  print("one run")
}

for (value in c("My", "second", "for", "loop")) {
  print(value)
}

for (word in c("My", "second", "for", "loop")) { print(word)
}
for (string in c("My", "second", "for", "loop")) {
  print(string)
}
for (i in c("My", "second", "for", "loop")) {
  print(i)
}

#The next loop will fill it with strings
chars <- vector(length = 4)
words <- c("My", "fourth", "for", "loop")
for (i in 1:4) {
  chars[i] <- words[i]
}
chars

# Exercise 4, Construct a for loop that will run score on all 343 rows of combos.
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}
head(combos, 3)

# Exercise 5, Calculate the expected value of the slot machine when it uses the new score function.
for (i in 1:nrow(combos)) {
  symbols <- c(combos[i, 1], combos[i, 2], combos[i, 3])
  combos$prize[i] <- score(symbols)
}

sum(combos$prize * combos$prob)

# While loops
plays_till_broke <- function(start_with) { cash <- start_with
n <- 0
while (cash > 0) {
  cash <- cash - 1 + play()
  n <- n + 1 }
n
}
plays_till_broke(100)

#repeat Loops
plays_till_broke <- function(start_with) { cash <- start_with
n<-0
repeat {
  cash <- cash - 1 + play() n<-n+1 
  if(cash<=0){
    break
  } }
n
}
plays_till_broke(100)


# Chapter 10, Vectorized Code
abs_loop <- function(vec){
  for (i in 1:length(vec)) {
    if (vec[i] < 0) { vec[i] <- -vec[i]
    }
  }
  vec
}

#vectorized version of abs_loop
abs_sets <- function(vec){
  negs <- vec < 0
  vec[negs] <- vec[negs] * -1
  vec
}

#To compare abs_loop and abs_set
long <- rep(c(-1, 1), 5000000)

# system.time to measure how much time it takes each function to evaluate long
system.time(abs_loop(long))
system.time(abs_sets(long))

# Exercise 1, Many preexisting R functions are already vectorized and have been optimized to per‐ form quickly.
system.time(abs(long))

#How to Write Vectorized Code
vec <- c(1, -2, 3, -4, 5, -6, 7, -8, 9, -10)
vec < 0
vec[vec < 0]
vec[vec < 0] * -1

# Exercise 2, The following function converts a vector of slot symbols to a vector of new slot symbols.
change_symbols <- function(vec){ for (i in 1:length(vec)){
  if (vec[i] == "DD") { vec[i] <- "joker"
  } else if (vec[i] == "C") { vec[i] <- "ace"
  } else if (vec[i] == "7") { vec[i] <- "king"
  }else if (vec[i] == "B") { vec[i] <- "queen"
  } else if (vec[i] == "BB") { vec[i] <- "jack"
  } else if (vec[i] == "BBB") { vec[i] <- "ten"
  } else {
    vec[i] <- "nine"
  } }
  vec
}
vec <- c("DD", "C", "7", "B", "BB", "BBB", "0")
change_symbols(vec)
many <- rep(vec, 1000000)
system.time(change_symbols(many))

#create a logical test that can identify each case
vec[vec == "DD"]
vec[vec == "C"]
vec[vec == "7"]
vec[vec == "B"]
vec[vec == "BB"] 
vec[vec == "BBB"] 
vec[vec == "0"]

vec[vec == "DD"] <- "joker"
vec[vec == "C"] <- "ace"
vec[vec == "7"] <- "king"
vec[vec == "B"] <- "queen"
vec[vec == "BB"] <- "jack"
vec[vec == "BBB"] <- "ten"
vec[vec == "0"] <- "nine"

change_vec2 <- function(vec){
  tb <- c("DD" = "joker", "C" = "ace", "7" = "king", "B" = "queen",
          "BB" = "jack", "BBB" = "ten", "0" = "nine")
  unname(tb[vec])
}
system.time(change_vec(many))

# How to write fast for loops in R

system.time(
  output <- rep(NA, 1000000),
  for (i in 1:1000000) {
    output[i] <- i + 1
  }
)


system.time(
  output <- NA,
  for (i in 1:1000000) {
    output[i] <- i + 1
  }
)

# Vectorized code in practice
winnings <- vector(length = 1000000)
for (i in 1:1000000) {
  winnings[i] <- play()
}
mean(winnings)

# Exercise 1, Study the model score_many function until you are satisfied that you understand how it works and could write a similar function yourself
# symbols should be a matrix with a column for each slot machine window
score_many <- function(symbols) {
  # Step 1: Assign base prize based on cherries and diamonds --------- ## Count the number of cherries and diamonds in each combination cherries <- rowSums(symbols == "C")
  diamonds <- rowSums(symbols == "DD")
  ## Wild diamonds count as cherries
  prize <- c(0, 2, 5)[cherries + diamonds + 1]
  ## ...but not if there are zero real cherries
  ### (cherries is coerced to FALSE where cherries == 0) prize[!cherries] <- 0
  # Step 2: Change prize for combinations that contain three of a kind
  same <- symbols[, 1] == symbols[, 2] &
    symbols[, 2] == symbols[, 3]
  payoffs <- c("DD" = 100, "7" = 80, "BBB" = 40,
               "BB" = 25, "B" = 10, "C" = 10, "0" = 0)
  prize[same] <- payoffs[symbols[same, 1]]
  # Step 3: Change prize for combinations that contain all bars ------
  bars <- symbols == "B" | symbols ==  "BB" | symbols == "BBB"
  all_bars <- bars[, 1] & bars[, 2] & bars[, 3] & !same
  prize[all_bars] <- 5
  # Step 4: Handle wilds ---------------------------------------------
  ## combos with two diamonds
  two_wilds <- diamonds == 2
  ### Identify the nonwild symbol
  one <- two_wilds & symbols[, 1] != symbols[, 2] &
    symbols[, 2] == symbols[, 3]
  two <- two_wilds & symbols[, 1] != symbols[, 2] &
    symbols[, 1] == symbols[, 3]
  three <- two_wilds & symbols[, 1] == symbols[, 2] &
    symbols[, 2] != symbols[, 3]
  ### Treat as three of a kind
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  ## combos with one wild
  one_wild <- diamonds == 1
  ### Treat as all bars (if appropriate)
  wild_bars <- one_wild & (rowSums(bars) == 2)
  prize[wild_bars] <- 5
  ### Treat as three of a kind (if appropriate)
  one <- one_wild & symbols[, 1] == symbols[, 2]
  two <- one_wild & symbols[, 2] == symbols[, 3]
  three <- one_wild & symbols[, 3] == symbols[, 1]
  prize[one] <- payoffs[symbols[one, 1]]
  prize[two] <- payoffs[symbols[two, 2]]
  prize[three] <- payoffs[symbols[three, 3]]
  # Step 5: Double prize for every diamond in combo ------------------
  unname(prize * 2^diamonds)
}
system.time(play_many(10000000))
