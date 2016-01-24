# We briefly look at change, derivative and elasticity formulae. We then
# graph and compute functions (linear and log-log) using the mosaic package.We gain
# the ability to derive one mathematical function, often non-linear, from another. We
# are able to understand such non-linear functions better when we graph them.We see
# how we can use different functional forms while studying how the average level of
# carbon dioxide emissions per capita varies with gross national income per capita for
# different countries.

# In econometrics, we use different functional forms to study the relationship between
# variables. We often compute an elasticity on the basis of the estimated function,
# which is itself a function. Often, such estimated elasticities inform public debates or
# policy.

# Change, Derivative and Elasticity
# Often, we are interested in how variable y will change when variable x changes.
# The change in a variable x is the difference between two values of x. If x is initially
# x∗ and then is x∗∗, the change in x, is
# Change in x = x∗∗ − x∗
# Or x = x∗∗ − x∗
# Let y be a function of x:
#   y = f (x).
# The rate of change of y with respect to x is the ratio of the change in y to the
# change in x.The rate of change of a function gives us the slope of the graph of the
# function.

# The derivative of y with respect to x is
# dy/dx = lim
# h → 0
# [ f (x + h) − f (x)]/h
# The elasticity of y with respect to x is the ratio of the percent change in y divided
# by the percent change in x. Elasticity is often denoted by .  = (y/y)/(x/x) or
# in terms of the derivative,  = (x/y) dy/dx

library(mosaic)

# Linear Function

# The linear function (here, y = f (x) = a +bx) is straightforward. However, we will
# see that the elasticity of the linear function, which is itself a function, is not.
# We use the following steps.
# 1. Make the linear function (use makeFun).
# 2. Plot the linear function (use plotFun).
# 3. Compute the derivative (a function) (use D).
# 4. Plot the derivative (use ladd).
# 5. Compute the elasticity (a function) using makeFun and steps 1 and 3.
# 6. Plot the elasticity.
# We can use this ‘recipe’ for the linear function by editing the R code to also
# examine other functions, like the quadratic function. In each step, we use the mosaic
# package that we had used in Chap. 4.

# Step 1. Make the linear function (use makeFun)

y1 <- makeFun(a + b*x ~ x, a = 2, b = 2)

y2 <- makeFun(a + b*x ~ x, a = 20, b = -0.5)

# Plotting the above functions

plotFun(y1, xlim = range(0, 30), ylab = "y1, y2")
plotFun(y2, xlim = range(0, 30), add = TRUE, lty = 2, lwd = 2)

# We use a dashed line for y2 using lty (line type).We add the plot of y2 to the plot
# of y1.
# Step 3. Compute the derivative (a function) (use D)
# The D function in the mosaic package computes the derivative.

dy1.dx <- D(a + b*x ~ x, a = 2, b = 2)
dy1.dx

dy2.dx <- D(a + b*x ~ x, a = 20, b = -0.5)
dy2.dx

# The derivative of b2 is also b; here b is −0.5. Since the derivatives are themselves
# functions, the code is similar to that used in Step 2.
# Step 4. Plot the derivative (Fig. 5.2). We use the command ladd and add the
# horizontal lines (dy1/dx = 2 and dy2/dx = −0.5).

plotFun(dy1.dx, xlim = range(0, 30), ylim = range(-2, 5))
ladd(panel.abline(a = 2, b = 0, lty = 1, col = "black"))

# a here corresponds to b in makeFun

ladd(panel.abline(a = -0.5, b = 0, lty = 2, col = "black"))

# Step 5. Compute the elasticity (a function) using makeFun and substituting for x,
# y and dy/dx in the formula  = (x/y)dy/dx from steps 1 and 3.

ey1.x <- makeFun(b * x/(a + b*x) ~ x, a = 2, b = 2)
ey2.x <- makeFun(b * x/(a + b*x) ~ x, a = 20, b = -0.5)

plotFun(ey1.x, xlim = range(0, 30), ylim = range(-2, 2))
plotFun(ey2.x, xlim = range(0, 30), ylim = range(-2, 2), add = TRUE, lty = 2, lwd = 2)

# In Fig. 5.3 we see that the elasticity function corresponding to the linear function
# can be complex. It is nonlinear and changes in shape with a change in parameters
# a and b of the linear functions. With y1, when a = 2 and b = 2, the value of the
# elasticity of y1 increases rapidly and then flattens out (solid line). With y2, when
# a = 20 and b = −0.5, the elasticity of y2 first decreases gradually and then more
# rapidly (dashed line).



# Log Log functions

# In the case of the log-log function,
# ln(y) = a + b ln(x)
# dy/dx = by/x
# Elasticity = b
# We will use a property of exponentials and logs, namely that exp (log(y)) = y to
# express y in terms of x while using makeFun.
# We can repeat the steps we used for the last section.
# Step 1. Make the log-log function (use makeFun)

y1 <- makeFun(exp(a + b*log(x)) ~ x, a = 1.5, b = 1.8)
y2 <- makeFun(exp(a + b*log(x)) ~ x, a = 1.5, b = -1.1)

plotFun(y1, xlim = range(0, 30))
plotFun(y2, xlim = range(0, 30), ylim = range(0, 5), lty = 2, lwd = 2)

# Step 3. Compute the derivative (a function) (use D)
# The D function in the mosaic package computes the derivative.

dy1.dx <- D(exp(a + b*log(x)) ~ x, a = 1.5, b = 1.8)
dy1.dx

dy2.dx <- D(exp(a + b*log(x)) ~ x, a = 1.5, b = -1.1)
dy2.dx

# Step 4: Plot the derivative.

plotFun(dy1.dx, xlim = range(0, 30), ylim = range(0, 120))
plotFun(dy2.dx, xlim = range(0, 30), ylim = range(1, -6), lty = 2, lwd = 2)

# Step 5. Compute the elasticity (a function) using makeFun and steps 1 and 3.

ey1.x <- makeFun(b ~ x, b = 1.8)
ey2.x <- makeFun(b ~ x, b = -1.1)
ey1.x
ey2.x

plotFun(ey1.x, xlim = range(0, 30))
ladd(panel.abline(a = 1.8, b = 0, col = "black"))
# a here is b in the makeFun

plotFun(ey2.x, xlim = range(0, 30), lty = 2, lwd = 2)
ladd(panel.abline(a = -1.1, b = 0, col = "black", lty = 2))

# Functions with data

# We need to choose a functional form when fitting a regression; looking at the data
# helps.
# If we are looking at the bivariate association between carbon dioxide (CO2) emissions
# and per capita Gross National Income (GNI), we would plot a scatter and then
# see how the line fits.
# We can download this data for the year 2000 from the World Bank (2014) online
# Databank,World Development Indicators, as a csv file. CO2 emissions are in metric
# tons per capita, GNI (Gross National Income) per capita are in purchasing power
# parity constant 2005 international dollars. We read the data into R Studio.

CO2 <- read.csv("ch5_data.csv", header = TRUE)
xyplot(CO2pc ~ GNIpc, data = CO2, ylim = c(0, 30))

# We fit a linear function and plot it. To fit a linear function, we use the lm function,
# creating an object that we name mod1. The syntax is similar to the makeFun function. We divide GNIpc by 1000 to get a reasonable size of coefficient, and use I
# in the model formula.

# We could use the summary function to see the regression output but prefer the
# display function in the arm package.

mod1 <- lm(CO2pc ~ I(GNIpc/1000), data = CO2)

display(mod1)

# We use makeFun on the linear model object mod1 to create CO2mod which we
# will use for plotting. We first plot the points and then the regression line (Fig. 5.9).
# We use makeFun on mod1, to make CO2mod, and that is used by plotFun.

CO2mod <- makeFun(mod1)
xyplot(CO2pc ~ GNIpc, data = CO2, ylim = c(0, 30))
plotFun(CO2mod(GNIpc) ~ GNIpc, add = TRUE)

# We use makeFun on the linear model object mod1 to create CO2mod which we
# will use for plotting. We first plot the points and then the regression line (Fig. 5.9).
# We use makeFun on mod1, to make CO2mod, and that is used by plotFun.

# clustering (Fig. 5.10 left). The histogram of the residuals shows a spike in the centre
# (Fig. 5.10 right).

xyplot(resid(mod1) ~ fitted(mod1), type = c("p", "smooth"))
histogram(~resid(mod1), fit = "normal")

# We could use a log-log function instead of a linear function. When we look at the
# histograms of the variables we see that both are very positively skewed (Figs. 5.11
# and 5.12). When we take the log of the variables, their histograms more closely
# resemble a normal distribution.

histogram(~CO2pc, data = CO2, fit = "normal")
histogram(~log(CO2pc), data = CO2, fit = "normal")

histogram(~GNIpc, data = CO2, fit = "normal")
histogram(~log(GNIpc), data = CO2, fit = "normal")

# We fit the log-log function

l.CO2pc <- log(CO2$CO2pc)
l.GNIpc <- log(CO2$GNIpc)
mod2 <- lm(l.CO2pc ~ l.GNIpc, data = CO2)
display(mod2)

# We make a scatter plot of log of CO2 per capita versus log of GNI per capita.We
# choose type p for points and r for regression line.We also make another scatter plot,
# but choose smooth for a loess nonparametric smoother.

xyplot(l.CO2pc ~ l.GNIpc, data = CO2, type = c("r", "p"))
xyplot(l.CO2pc ~ l.GNIpc, data = CO2, type = c('p', 'smooth'))