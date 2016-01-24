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

# Supply

pS <- makeFun((aS + (bS * q))/cS ~ q, aS = 12, bS = 2, cS = 5)

plotFun(pD, xlim = range(0, 30), ylim = range(5, 20), lty = 2)
plotFun(pD2, xlim = range(0, 30), ylim = range(5, 20), lwd = 1.5, add = TRUE)
plotFun(pS, xlim = range(0, 30), ylim = range(5, 20), add = TRUE)

# Equilibrium
# 
# At the equilibrium, D = S, or D − S = 0.
# We use the findZeros function and apply it to the excess demand:

q.equil <- findZeros(((aD - (bD * q))/cD) - ((aS + (bS * q))/cS) ~ q,
                     aD = 125, bD = 6, cD = 8, aS = 12, bS = 2, cS = 5)
q.equil

pD(q.equil)

# Fish Data

# We then plot price against quantity in a scatter plot (Fig. 4.4 left). To plot price
# against quantity we use a function or command that is in the mosaic package,
# xyplot. We also plot price against stormy (stormy weather) (Fig. 4.4 right). We
# ‘jitter’ stormy, i.e. add some random noise to help distinguish different observations;
# we ask for type = p for points and = r for regression line.

fish <- read.delim('fish.out')

xyplot(price ~ qty, data=fish)

xyplot(price ~ jitter(stormy), data = fish, type = c('p', 'r'))

# Since both supply and demand were changing, we cannot “identify” a supply
# or demand curve only from the scatter plot (Fig. 4.4, left). Graddy (2006) found
# that stormy weather shifted the supply curve; so we can identify the demand curve
# using that information (Fig. 4.4, right). In other words, stormy weather serves as an
# ‘instrumental variable’. Using only ordinary least squares, the estimated price elasticity
# of demand for fish was about −0.5; using the instrumental variables estimator,
# the estimated price elasticity was more than double that. The theoretical framework
# of demand and supply helps us see beyond the data, and using the econometric
# technique of instrumental variables helps us estimate the elasticity. We can also use
# supply and demand as a framework to think about price movements informally, as
# in the following case of the price of crude oil. We discuss elasticity in Chap. 5.

