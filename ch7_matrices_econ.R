# We use matrices to store data and matrix manipulations underlie econometric estimation.
# They help us generalize formulae to many variables.

# We start with a vector x, which has the following elements:

x <- c(1, 1.25, 2, 2.5, 3)

# mean of X, xbar:

mean(x)

# The formula for the variance of x is varx = [1/(n − 1)]n
# i=1(xi − x)2
# We can first calculate a vector of the deviation of each value of x from the mean
# of x, square the deviations, add them up, and then divide by n − 1.
# We can get the value of n by using the command length:

length(x)

# The deviations of values of x from their mean is given by:

dev.x <- x - mean(x)
dev.x

# To square these values and add the squared values we multiply the transpose of
# dev.x by dev.x, using not star but % * %, the symbol for matrix multiplication in R.

t(dev.x) %*% dev.x

# We can check that the variance of x has been calculated correctly by using the R
# function for variance, var, directly:

var(x)

# We input a vector y now
y <- c(1.5, 2.5, 3.4, 3.5, 4)

# The covariance of y and x is given by covxy = [1/(n −1)]n
# i=1(yi − y)(xi −x)
# It is easy to modify the code that we used to calculate the variance of x above to
# calculate the covariance of y and x:

mean(y)
length(y)

dev.y <- y - mean(y)
dev.y

covar_calc_yx <- t(dev.y) %*% dev.x/(length(y) - 1)
covar_calc_yx

# We now calculate the covariance of y and x using the R function for covariance
# directly:
cov(y, x)

#xy plot
library(mosaic)

xyplot(y ~ x)

# Figure 7.1 shows that x and y are positively correlated. We use the cor function
# and then calculate the correlation:

cor(y, x)

# Simple Matrix Operations with R

# A matrix is an array of numbers with rows and columns.We use thematrix command
# to make a matrix. We indicate the number of columns with ncol:

A <- matrix(c(2, 3, 3, 4), ncol = 2)
A

B <- matrix(c(2, 3, 4, 5), ncol = 2)
B

# The number of columns was two in A and B.
# We can add the matrices A and B.

M <- B + A
M

The transpose of a matrix simply switches the rows and columns:
t(A)
t(B)

# We can usematrices to represent a set of equations compactly; let us say 2w+3z =
# 7 and 3w + 4z = 10. We can represent this with matrices as A D = C. Here D is a
# column vector with elements w and z and C is also a column vector with elements 7
# and 10. Since AD = C, D = A −1C.We multiply matrices with the symbol percent
# star percent, and invert by using ‘solve’ in R.

C = c(7, 10)
D <- solve(A) %*% C
D

# 7.4 Regression

# We make a data frame called Dat as a different object but with the same values as y
# and x from Sect. 7.2. In the data frame Dat they are called Response and Predictor
# (Response and Predictor variables).

Cons = c(1, 1, 1, 1, 1)
Dat <- data.frame(Response = y, Cons = Cons, Predictor = x)
X <- cbind(Cons, x)
Dat

# We regress Response on Predictor:

fit <- lm(Response ~ Predictor, data = Dat)
coef(fit)

# We can use the following formulae for the coefficients of a simple bivariate regression:

b1 = cov(y, x)/var(x)
b1

b0 = mean(y) - (b1 * mean(x))
b0

# We can also use the matrix formula for least squares; B = (X^t X)^−1 X^t *y

matcoeff <- solve(t(X) %*% X) %*% t(X) %*% y
matcoeff

# We plot the scatter and line of fit below (Fig. 7.2).

fitM <- makeFun(fit)
xyplot(Response ~ Predictor, data = Dat)
plotFun(fitM, add = TRUE)
