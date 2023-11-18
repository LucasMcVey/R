getwd()

setwd("/home/lucas/Documents/test")

getwd()

a = 100
b = 10

a + b

round(mean(1:6))
########################################

my_function <-function() {}
##################################################

roll <-function() {
  die = 1:6
  dice = sample(die, size = 2, replace = TRUE)
  sum(dice)
}

###################################################

a = roll()
x= 1:6

y=2*x


plot(x,y,col="red", type ="b", xlab= "x label", 
     ylab = "y label")

library(ggplot2)
qplot (x,y)

myfile = read.csv(file ="data.csv", sep "\t")




