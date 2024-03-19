


#overriding values just use your value and the operator <- 
vec <- c(0,0,0,0,0,0)
#to select first value of the vector  
vec[1]
# and hers how you can change it 
vec[1] <- 1000
vec
# to replace multiple values at once
vec[c(1, 3, 5)] <- c(1, 1, 1) vec
#or
vec[4:6] <- vec[4:6] + 1 
vec
#To expand vectors that don't exist
vec[7] <- 0
vec
# We can also use NULL to remove columns from a data frame.

# To single out just the values 
deck2[c(13, 26, 39, 52), 3]

#subset the column vector
deck2$value[c(13, 26, 39, 52)]

#turning vector to true false 
vec[c(FALSE, FALSE, FALSE, FALSE, TRUE, FALSE, FALSE)]

#logical test
1>2

1>c(0,1,2)

c(1,2,3)==c(3,2,1)

c(1, 2) %in% c(3, 4, 5)

#Exercise 1(Extract the face column of deck2 and test whether each value is equal to ace. 
#As a challenge, use R to quickly count how many cards are equal to ace.)
deck2$face == "ace"
sum(deck2$face == "ace")

# we can use this method to change the value 
deck3$value[deck3$face == "ace"] <- 14
head(deck3)

#Exersise 2 (Assign a value of 1 to every card in deck4 that has a suit of hearts.)
deck4$suit == "hearts"
deck4$value[deck4$suit == "hearts"]
deck4$value[deck4$suit == "hearts"] <- 1
deck4$value[deck4$suit == "hearts"]

# to find all the queens 
deck4[deck4$face == "queen", ]

# use a Boolean operator to locate the queen of spades in your deck
deck4$face == "queen" & deck4$suit == "spades"

#Exercise 3
w <- c(-1, 0, 1)
x <- c(5, 15)
y <- "February"
z <- c("Monday", "Tuesday", "Friday")

w>0
10<x&x<20
y == "February"
all(z %in% c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
             "Saturday", "Sunday"))

#change the value of the face cards
facecard <- deck5$face %in% c("king", "queen", "jack")

#Missing Information
1 + NA
NA == 1

##na.rm test 
c(NA, 1:50)
mean(c(NA, 1:50))
mean(c(NA, 1:50), na.rm = TRUE)

#is.na test
NA == NA

c(1,2,3,NA) == NA

#a special function that can test whether a value is an NA.
is.na(NA)
vec <- c(1, 2, 3, NA)
is.na(vec)

deck5$value[deck5$face == "ace"] <- NA
head(deck5, 13)




