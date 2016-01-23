# This chapter covers supply and demand.

# 4.2 Supply and Demand in General
# Let the quantity demanded D be given by:
#   D = αD − βD P
# Similarly for supply S:
#   S = αS + βS P
# At equilibrium, demand=supply, i.e. D = S. This gives us the equilibrium price:
#   P∗ = (αD − αS)/(βD + βS)
# We will use R to graph demand and supply and compute the equilibrium, using
# the mosaic package.

#Mosaic is a package that extends R's vanilla functions.

#Syntax for installing packages: install.packages('nameofpackage')

library(mosaic)

# We set up an inverse demand function, pD = (125 − 6q) / 8.We have to provide this
# equation in the specific format required:

pD <- makeFun(( aD - (bD * q) ) / cD ~ q, aD = 125, bD = 6, cD = 8)

pD(20)

# So, when q = 20, pD = 0.625. We will now plot the inverse demand function

plotFun(pD, xlim = range(0, 30), ylim = range(5, 20), lty = 2, lwd = 1.5)

# The command plotFun plots the curve, pD above tells it what has to be plotted,
# xlim stands for the limits of x, ylim similarly. We can get a dotted line by using
# lty = 2; lty stands for line type. We use lwd to adjust the width of the line.

# We make and plot another demand function, denoted by pD2 below; the only
# difference with pD is that aD is now equal to 150.

pD2 <- makeFun(( aD - (bD * q) ) / cD ~ q, aD = 150, bD = 6, cD = 8)

plotFun(pD2, xlim = range(0, 30), ylim = range(5, 20), lwd = 1.5, add = TRUE)


