library("ggplot2")
# qplot is qiventwo vectors of equal lengths the code will make a plot. 
x <- c(-1, -0.8, -0.6, -0.4, -0.2, 0, 0.2, 0.4, 0.6, 0.8, 1)
y<-x^3
qplot(x, y)   

# when only one vector is given to plot it makes a histogram.
x<-c(1,2,2,2,3,3) 
qplot(x, binwidth = 1)

# second example 
x2<-c(1,1,1,1,1,2,2,2,2,3,3,4)
qplot(x2, binwidth = 1)

# Exersise 1
x3 <- c(0,1,1,2,2,2,3,3,4)
qplot(x3, binwidth = 1)
#How many bars will the histogram have?  5 bars 
#Where will they appear?  bar1 [0,1) height 1, bar2 [1,2) height 2, bar3 [2,3) height 3,bar4 [3,4) height 2,bar5 [4,5) height 1


#replicate provides an easy way to repeat an R command many times
replicate(10, roll())

#simulating 10,000 dice rolls and ploting the results to help us see pattern.
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

# how to use help page 
?log10

# Exxersise 2
roll <- function() {
  die <- 1:6
  dice <- sample(die, size = 2, replace = TRUE,
  prob = c(1/8, 1/8, 1/8, 1/8, 1/8, 3/8))
  sum(dice)
}

# to visualize the new long-term behavior of your dice and check weight.
rolls <- replicate(10000, roll())
qplot(rolls, binwidth = 1)

