

#Exercise
2 + 2

4 * 3

12 - 6

6 / 3

# Objects ecercise 
die <- 1:6

die * 2

die / 2

#vector math
die + 1:3

#inner multiplication
die %*% die

#outer multiplication
die %o% die

#Functions excersise 
round(mean(die))

#to assign your own decimal digits
round(3.1415, digits = 2)

#simulating a roll of die
sample(x = die, size = 2)

#Sample with Replacement(so die is generated like real life and reppetion can occur )
sample(die, size = 2, replace = TRUE)

# to add up the dice,and feed our result straight into the sum function
dice <- sample(die, size = 2, replace = TRUE)
dice

# to get sum
sum(dice)

#Writing my own Functions to re-roll our dice.
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE) 
  sum(dice)
}
# then just roll to call
roll()

#Arguments(make sure to add object in function)
roll2 <- function(bones) {
  dice <- sample(bones, size = 2, replace = TRUE) 
  sum(dice)
}

#then call by assigning values to the oobject
roll2(bones = 1:4)

#
