head(deck)

# to extract the first row vector possessive integers.
deck[1, c(1, 2, 3)]
deck[1, c(1,2,3)]

new <- deck[1, c(1,2,3)]
new

#Negative 
deck[-(2:52), 1:3]

deck[c(-1,1), 1]

#Zero
deck[0,0]


# shows how negative integer acts opposite to possetive 
deck[-(2:52), 1:3]
# to ask for the elements you want by name
deck[1, c("face", "suit", "value")]

#Logical Values
deck[1, c(TRUE, TRUE, FALSE)]

rows <- c(TRUE, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,
          F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F, F,
          F, F, F, F, F, F, F, F, F, F, F, F, F, F)
deck[rows,]

# Exercise1( the shuffle function)
deal <- function(cards) { cards[1, ]}
deal(deck)


# Exercise 2(Use the preceding ideas to write a shuffle function. 
#shuffle should take a data frame and return a shuffled copy of the data frame.)
shuffle <- function(cards) {
  random <- sample(1:52, size = 52)
  cards[random, ]
}
deal(deck)


#Dollar Signs(R will return all of the values in the column as a vector.)

deck$value
mean(deck$value)
median(deck$value)

#more examples 
lst <- list(numbers = c(1,2), logical = TRUE, strings = c("a", "b", "c"))
lst

sum(lst$numbers)
lst[[1]]
lst[["numbers"]]