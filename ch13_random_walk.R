# 13.1 Introduction
# Difference equations are like differential equations with discrete adjustment. In time
# series econometrics difference equations with stochastic elements are used. Difference
# equation versions of the logistic growth equations are commonly used in
# ecology.

# In a difference equation we have a relationship between the value of a variable in
# the current period and the value in the previous period. Let us take the example of a
# difference equation for a variable x.
# xt = axt−1 + b
# This can also be written in the following form by subtracting xt−1 from both sides:
  # .xt = xt − xt−1 = (a − 1)xt−1 + b
# If xt = xt−1, then x is said to be in equilibrium or a steady state. Denoting the
# steady state by x∗, we can see that
# x∗ = b/(1 − a)
# If we know xt−1 we can calculate xt ; if we know the initial value of x we can go
# on calculating the next value. This is something computers can do very well, and in
# R we can use a loop that repeats the calculation.

# We examine a simple difference equation first; x in this period is simply 0.5 times
# x in the last period plus two.
# xt = 0.5 xt−1 + 2
# We first create a vector x with 30 elements. We give the first element of x (the
# initial value) a value of 100.

x = numeric(30)
x[1] = 100

# We then make a loop; t (which stands for time) goes from 2 to 30. Each time its
# value increases by one, we multiply the previous value of x by 0.5 and add 2.

for (t in 2:30) {
  x[t] <- 0.5 * x[t - 1] + 2
}
library(mosaic)

# To plot the values of x against time with xyplot we make a vector time which
# has the same values as t, going from 1 to 30.

time <- 1:30
xyplot(x ~ time, type = "l")

# In Fig. 13.1 we see that x drops from a value of 100 to 4. We can print the values
# of x from time = 1 to 10, and time = 20 to 30:

x[1:10]
x[20:30]

# 13.3 Stochastic Elements
# We will now add stochastic elements to the difference equations; first we examine the
# plot of white noise.We draw a random sample of size 100 from a normal distribution
# using the function rnorm.

white <- rnorm(80)
time <- 1:80

# Autocorrelation is the correlation between lagged values of a time series, for
# example, between xt and xt−1 or xt and xt−2. The acf is the graph of such correlations.
# We use the acf of white noise as a benchmark.

plot(white, type = "l", las = 1)
acf(white, las = 1, main = "")

# In Fig. 13.2 (left) we see a plot of white noise—there are random movements
# up and down. The acf of white noise (Fig. 13.2 right) shows negligible correlation
# between lags.
# We now add white noise to our difference equations, so we have xt = 0.5 xt−1 +
  # 2 + w. We simulate this and plot it (Fig. 13.3):

x = numeric(80)
x[1] = 100
w <- 10 * rnorm(80)
for (t in 2:80) {
  x[t] <- 0.5 * x[t - 1] + 2 + w[t]
}
plot(x, type = 'l', las = 1)
acf(x, main = "", las = 1)

# We can compare Fig. 13.3 with Figs. 13.1 and 13.2. Initially x drops and then it
# fluctuates. The acf shows one significant lag.

# 13.4 RandomWalk
# We now look at a random walk.
# xt = xt−1 + w

x = numeric(300)
x[1] = 200
w <- 10 * rnorm(300)
for (t in 2:300) {
  x[t] <- x[t - 1] + w[t]
}

# We plot the random walk (Fig. 13.4 left) and its acf (Fig. 13.4 right).

plot(x, type = 'l', las = 1)
acf(x, main = "")

# We can compare Fig. 13.4 with Fig. 13.2. The acf in Fig. 13.4 shows slowly
# decaying lags. In a random walk, if there is a large random shock, it persists and
# influences future values of x.

# 13.5 Fishing
# Bjorndal and Conrad (1987) modelled the open access exploitation of North Sea
# herring during the period 1963–1977. Fish populations are often modelled with a
# logistic equation.

# Denoting the fish stock with S, the intrinsic rate of growth by r, and its carrying
# capacity by L, we have: St = St−1 + r St−1(1 − (St−1/L)).
# If St−1 = 0 or L, the growth is zero. Growth in fish depends on the stock of fish.
# We first see how S changes over time if the fish are left alone, i.e. there is no harvest.
# We need to give R the formula, the values for r and L, and the value for initial S.

S = numeric(15)
S[1] = 2325000
r = 0.8
L = 3200000

# We use a loop as before, within the loop we use the formula for logistic growth
# to calculate the stock S in each period.

for (t in 2:15) {
  S[t] <- S[t - 1] + (S[t - 1] * r) * (1 -S[t - 1]/L)
}
Time <- 1:15

# We now plot S against Time (Fig. 13.5):

# The fish stock increases until it is equal to the carrying capacity (Fig. 13.5).
# We now examine the fish stock with fishing. Fishing harvest depends on the
# fish stock S2 and fishing capital, Bjorndal and Conrad (1987) use a Cobb-Douglas
# production function.We will not go into the details of the derivation, but they arrive
# at the following dynamic system that they use for a simulation:
  # Kt+1 = Kt + n(aKb−1
                # t Sg
                # t − ct /pt )
# St+1 = St + r St (1 − St /L) − aKb
# t Sg

# The equation on the top represents the adjustment of capital to profit—higher
# profits lead to an expansion of capital. We had used the lower equation earlier; it
# represents the biological growth and harvest of fish. We now have more parameters
# that we have to provide numerical values for:

S2 = numeric(15)
K = numeric(15)
S2[1] = 2325000
K[1] = 120
r = 0.8
L = 3200000
a = 0.06157
b = 1.356
g = 0.562
n = 0.1
c <- c(190380, 195840, 198760, 201060, 204880, 206880,
       215220, 277820, 382880, 455340, 565780, 686240,
       556580,721640, 857000)
p <- c(232, 203, 205, 214, 141, 128, 185, 262, 244,
        214, 384, 498, 735, 853, 1415)

# We put the two equations into a loop:

for (t in 2:15) {
  S2[t] <- S2[t - 1] + (S2[t - 1] * r) * (1 - S2[t -
          1]/L) - a * K[t - 1]^b * S2[t - 1]^g
  K[t] <- K[t - 1] + (n * (a * (K[t - 1]^(b - 1)) *
          (S2[t - 1]^g) - c[t - 1]/p[t - 1]))
}

# We plot K against S (Fig. 13.6):

xyplot(K ~ S2/10^6, type = "l")

# and S against Time (Fig. 13.7):

xyplot(S2/10^6 ~ Time, type = "l")

# We see that with open access fishing the dynamics of the fishery is dramatically
# changed from the case of no fishing. In Fig. 13.6 we see that initially fishing leads
# to an expansion of capital which over time leads to a reduction in the fishing stock.
# When capital is around 600, it starts falling but the reduction in capital is a case of
# too little, too late. We can contrast Fig. 13.7 with Fig. 13.5; in Fig.13.7 the fish die
# out.
# In their conclusions Bjorndal and Conrad (1987, pp. 83–84) write:
  # In the empirical analysis of open access systems it is important to note that non-linear difference
  # equations,with or without longer lags, are capable of more complex dynamic behaviour
  # than their continuous-time (differential equation) analogues. The lag in adjustment by both
  # the exploited species and the harvesters themselves is often a more accurate depiction of
  # dynamics, and the differential equation systems are best viewed as theoretical approximations.
  # ... If adjustment in an open access system is discrete, there is a greater likelihood of
  # overshoot, severe depletion, and possibly extinction. ... the North Sea herring fishery ... was
  # saved from more severe overfishing and possibly extinction by the closure of the fishery at
  # the end of the 1977 season.

