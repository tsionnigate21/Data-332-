#asking R what type of object an object is with typeof
die <- c(1,2,3,4,5,6)
typeof(die)

# saving integers in R with L
int <- c(-1L, 2L, 4L)
typeof(int)

# creating character in R 
text <- c("Hi", "Tsion")
text
# Exercise 1: Can you spot the difference between a character string and a number? Yes 
#Here’s a test: Which of these are character strings and which are numbers? 1, "1", "one".  1 is a number/double, and  "1", "one" are strings 

#Exercise 2:
names <- c("Ace", "king", "Queen", "Jack", "ten")
names
typeof(names)

# nameing our vestor die 
names(die) <- c("one", "two", "three", "four", "five", "six")
names(die)

#To remove the names attribute, set it to NULL
names(die) <- NULL
die

#Exercise 3 
royal_matrix <- matrix(c("ace", "king", "queen", "jack", "ten", "spades", "spades", "spades", "spades", "spades"), ncol = 2, byrow = TRUE)
rownames(royal_matrix) <- 1:5

print(royal_matrix)


# 
gender <- factor(c("male", "female", "female", "male"))
# to see the type 
typeof(gender)
# to add a levels attribute to the integer
attributes(gender)
#To see  how R is storing your factor with unclass
unclass(gender)
#To convert a factor to a character string with the as
as.character(gender)

#Exercise 4
card <- c("ace", "hearts", 1) 
card

#Exercise 5
card <- list("ace", "hearts", 1) 
card

#To set a name that describes the vector.
df <- data.frame(face = c("ace", "two", "six"),
                 suit = c("clubs", "clubs", "clubs"), value = c(1, 2, 3))
df
