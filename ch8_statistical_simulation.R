# Introduction

# One of R’s strengths is the ease with which we can carry out statistical simulation.
# It can help us understand statistics and econometrics.

# 8.2 Probability distributions

# We can easily generate synthetic data from probability distributions.

# 8.2.1 Normal Distribution

library(mosaic)

# We start with the normal distribution.We need to indicate the sample size (n), the
# mean (mu), and the standard deviation (sd).

n <- 1000
mu <- 800
sd <- 35

# We generate our variable called heights with the R functionrnorm (r for random,
# norm for normal).

heights <- rnorm(n = n, mean = mu, sd = sd)
# Print first 10 heights
heights[1:10]

# Plot the histogram

histogram(~heights, type = "percent")

# 8.2.2 Uniform Distribution

# We move to a uniform distribution with sample size n equal to 1000, lower limit a
# equal to zero and upper limit b equal to 100.

n <- 1000
a <- 0
b <- 100

# We generate our variable called measures from the uniform distribution with the
# R command runif.

measures <- runif(n = n, min = a, max = b)
measures[1:10]

# Plot the histogram
histogram(~measures, type = 'percent')

# 8.2.3 Bionomial Distribution

# We generate a variable called females from the binomial distribution. If we have
# classrooms with 30 students (N), and the probability of any single student being
# female (p) is half, what is the distribution of females per class that we observe in a
# thousand classrooms?

n <- 1000
N <- 30
p <- 0.5
females <- rbinom(n = n, size = N, prob = p)

# Plot histogram

histogram(~females, type = "percent")

# 8.3 Central Limit Theorem

# The Central Limit Theorem gives us this remarkable result: the distribution of an
# average tends to be Normal, even when the distribution from which the average is
# computed is quite different from a Normal distribution.
# Let y be our population; y consists of a thousand values from a uniform distribution
# with a minimum value of 0 and a maximum value of 100.

y <- runif(n = 1000, min = 0, max = 100)
histogram(~y, type = 'percent', breaks = 10)

# The histogram of y (Fig. 8.4) looks like that of measures (compare with Fig. 8.2).
# We first see what happens when we take samples of size 2 each.

sample(y, size = 2)

# We now take samples of size 2, calculate the mean and repeat this 50 times with
# the do function in the mosaic package. We then plot the histogram of the sample
# means (Fig. 8.5 left).
# We do the same with samples of size 100 (Fig. 8.5 right).

M.s.2.y = do(50) * mean(sample(y, 2))
histogram(~M.s.2.y, type = 'percent')
M.s.100.y = do(50) * mean(sample(y, 100))
histogram(~M.s.100.y, type = 'percent')

# 8.4 t-test

# Assume that we have wages of 48 women (n.w) and 52 men (n.m) and want to see
# how they differ. The average wage of women (mu.w) is 100, and of men (mu.m) is
# 90. We assume that the wages of men and women have the same standard deviation
# (sigma) equal to 2.
# We first give R the parameters:

n.w <- 48
n.m <- 52
mu.w <- 100
mu.m <- 90
sigma <- 2
n <- n.w + n.m

# Generating the data

y.w <- rnorm(n.w, mu.w, sigma)
y.m <- rnorm(n.m, mu.m, sigma)

# We put the men and women wage today together

wages <- c(y.w, y.m)

# Gender indicator variable
gender <- rep(c(0, 1), c(n.w, n.m))

# We use boxplots to see the variation in wages by gender (Fig. 8.6):

bwplot(factor(gender) ~ wages)

# Regression:

fit.wages <- lm(wages ~ gender)
library(arm)
display(fit.wages)

# We estimate a difference which is statistically significant. Because we generated
# the data, we known the actual value is 10. When we analyze real world data, we
# only have the data and attempt to discover an approximation to the data generating
# process.

# 8.5 Logit Regression

# If our dependent variable is qualitative we can use logit. Here we consider purchase
# (yes or no), as a function of income. When the latent variable, desire to purchase,
# which is a function of income, crosses a threshold, we purchase.
# We generate the income data and the latent variable:

income <- 1:100
late.dd <- 1 + 0.02 * income
late.star <- late.dd + rnorm(n = 100, mean = 1, sd = 0.5)

# We make a scatter plot of late.star versus late.dd (Fig. 8.7):

xyplot(late.star ~ late.dd)

# We then generate the purchase data; if late.star exceeds 2.5, we purchase. If not,
# we don’t.

purchase <- ifelse(late.star > 2.5, 1, 0)
purchase

# We make a scatter plot of purchase versus income (Fig. 8.8). We might observe
# data on whether a consumer made a purchase and the consumer’s income, but we
# don’t observe the latent variable.

xyplot(jitter(purchase) ~ income)

# We run a logit regression, with the R function glm (generalized linear model),
# setting the argument family to binomial:

mylogit <- glm(purchase ~ income, family = 'binomial')
display(mylogit)

mylo <- makeFun(mylogit)

# Plot to fit the curve

xyplot(jitter(purchase) ~ income)
plotFun(mylo, add = TRUE)
