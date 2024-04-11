## chap 6
#Working with Environments
#as.environment takes an environment name and returns the corresponding environment:
as.environment("package:stats")
globalenv()
baseenv()
emptyenv()

#look up an environment’s parent with parent.env
parent.env(globalenv())

#You can view the objects saved in an environment with ls or ls.str
ls(emptyenv())
ls(globalenv())

# use R’s $ syntax to access an object in a specific environment
head(globalenv()$deck, 3)

#use the assign function to save an object into a particular environment
assign("new", "Hello Global", envir = globalenv())
globalenv()$new


#show environment 
show_env <- function(){ list(ran.in = environment(),
                             parent = parent.env(environment()),
                             objects = ls.str(environment()))
}

show_env()
#to look up a function’s origin environment by running environment on the function
environment(show_env)

# R will store any objects created by show_env in its runtime environment. 
show_env <- function(){ a<-1
b<-2
c<-3
list(ran.in = environment(),
     parent = parent.env(environment()),
     objects = ls.str(environment()))
}
show_env()

# put a second type of object in a runtime environment
foo <- "take me to your runtime"
show_env <- function(x = foo){ list(ran.in = environment(),
                                    parent = parent.env(environment()),
                                    objects = ls.str(environment()))
}
show_env()

#Exercise1 (Will R be able to find deck and return an answer when I call the new version of deal, such as deal())
deal <- function() { deck[1, ]
}
environment(deal)

deal()
#The following code will save a prisitine copy of deck and then remove the top card:
DECK <- deck
deck <- deck[-1, ]
head(deck, 3)

#adding a code to deal
deal <- function() { 
  card <- deck[1, ] 
  deck <- deck[-1, ] 
  card
}

#Exercise 2(Rewrite the deck <- deck[-1, ] line of deal to assign deck[-1, ] to an object named deck in the global environment. Hint: consider the assign function.)
deal <- function() {
  card <- deck[1, ]
  assign("deck", deck[-1, ], envir =  parent.env(environment()))
  return(card)
}

deal()

#Exercise 3 
shuffle <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir =  parent.env(environment())())
}


setup <- function(deck) {
  DECK <- deck
  DEAL <- function() {
    card <- deck[1, ]
    assign("deck", deck[-1, ], envir = parent.env(environment()))
    return(card)
}
SHUFFLE <- function(){
  random <- sample(1:52, size = 52)
  assign("deck", DECK[random, ], envir = parent.env(environment()))
  assign("deck", deck[-1, ], envir = .GlobalEnv)
}
list(deal = DEAL, shuffle = SHUFFLE)
}
cards <- setup(deck)

deal <- cards$deal

shuffle <- cards$shuffle

## chapter 7

# to generate the symbols used in your slot machine
get_symbols <- function() {
  wheel <- c("DD", "7", "BBB", "BB", "B", "C", "0") 
  sample(wheel, size = 3, replace = TRUE,
    prob = c(0.03, 0.03, 0.06, 0.1, 0.25, 0.01, 0.52))
}

get_symbols()

#To create your play function
#Sequential Steps
play <- function() {
  # step 1: generate symbols
  symbols <- get_symbols()
  # step 2: display the symbols
  print(symbols)
  # step 3: score the symbols
  score(symbols)
}

#if Statements that ensures some object, num, is positive:
num <- -2

if(num<0){
  num<-num*-1
}
num

#example 2 
num <- -1

if(num<0){
  print("num is negative.") 
  print("Don't worry, I'll fix it.") 
  num<-num*-1
  print("Now num is positive.")
}
num
#else Statements example
a <- 1 
b <- 1

if (a > b) { 
  print("A wins!")
} else if (a < b) { 
  print("B wins!")
} else { 
  print("Tie.")
}

# Exercise 1
symbols <- c("7", "7", "7")

symbols

all(symbols == symbols[1])


#use if and else to link the subtasks in your slot-machine function
same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]

# Exercise 2
symbols <- c("B", "BBB", "BB")

symbols[1] == "B" | symbols[1] == "BB" | symbols[1] == "BBB" &
  symbols[2] == "B" | symbols[2] == "BB" | symbols[2] == "BBB" &
  symbols[3] == "B" | symbols[3] == "BB" | symbols[3] == "BBB"

# Exercise 3(How can you tell which elements of a vector named symbols are a C? Devise a test and try it out.)
symbols <- c("C", "DD", "C")
symbols == "C"

# Challenge 4(How might you count the number of Cs in a vector named symbols? Remember R’s coercion rules.)
sum(symbols == "C")

#Exercise 4
#To calculate Initial Prize:
# If all symbols are the same, we know the prize based on the first symbol according to the payouts table.
# If there are all "B", "BB", or "BBB" symbols (bars is TRUE), the prize is set to 5.
# If none of the above conditions is met, the number of cherries (C) is counted, and the prize is determined based on the number of cherries.
# Adjusting Prize:
# The number of diamonds collected is counted.
# initial prize is multiplied by 2 (prize * 2 ^ diamonds)

same <- symbols[1] == symbols[2] && symbols[2] == symbols[3]
bars <- symbols %in% c("B", "BB", "BBB")
if (same) {
  payouts <- c("DD" = 100, "7" = 80, "BBB" = 40, "BB" = 25, 
    "B"=10,"C"=10,"0"=0) 
  prize <- unname(payouts[symbols[1]])
} else if (all(bars)) { 
  prize <- 5
}else{
  cherries <- sum(symbols == "C") 
  prize <- c(0, 2, 5)[cherries + 1]
}
diamonds <- sum(symbols == "DD")
prize * 2 ^ diamonds



