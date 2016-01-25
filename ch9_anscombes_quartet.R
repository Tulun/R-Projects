# 9.1 Introduction
# In 1973, the statistician Anscombe published a lovely paper in which he argued that
# we should use statistical graphs (p.17):
  # A computer should make both calculations and graphs. Both sorts of output should be
# studied; each will contribute to understanding. ... Most kinds of statistical calculation rest on
# assumptions about the behavior of the data. Those assumptions may be false, and then the
# calculations may be misleading. We ought always to try to check whether the assumptions
# are reasonably correct; and if they are wrong we ought to be able to perceive in what ways
# they are wrong. Graphs are very valuable for these purposes.
# Anscombe (1973) provided some synthetic data to illustrate this. Anscombe’s
# data illustrates the importance of visualization, of examining the data graphically.

# 9.2 The Data: 4 Sets of xs and ys
# R comes with some datasets; one of these is anscombe. We call the dataset ans and
# see what it contains:

ans <- anscombe
ans

# The xs have means = 9 and standard deviations = 3.317 as can be verified by
# using the functionsmean andsd. The ys have means = 7.5 and standard deviations
# = 2.03.

# 9.3 Same Regressions of ys on xs

# When we regress y1 on x1 and y2 on x2 etc. using lm, and see the output with
# display the coefficients and other regression output are the same:

fit1 <- lm(y1 ~ x1, data = ans)
fit2 <- lm(y2 ~ x2, data = ans)
fit3 <- lm(y3 ~ x3, data = ans)
fit4 <- lm(y4 ~ x4, data = ans)
library(arm)
display(fit1)
display(fit2)
display(fit3)
display(fit4)

# 9.4 Very Different Scatter Plots

library(mosaic)

# We use xyplot to plot scatters for the 4 sets of ys and xs and choose points (p) and
# regression lines (r):

xyplot(y1 ~ x1, data = ans, type = c('p', 'r'))
xyplot(y2 ~ x2, data = ans, type = c('p', 'r'))
xyplot(y3 ~ x3, data = ans, type = c('p', 'r'))
xyplot(y4 ~ x4, data = ans, type = c('p', 'r'))

# When we examine the lines of fit they are the same, but the scatter plots are very
# different (Fig. 9.1). In Fig. 9.1, a quadratic term should be used for y2 versus x2
# because there is curvature. In the scatter of y3 against x3, one outlying point is tilting
# the fitted line upwards. In the scatter of y4 against x4, if we drop the extreme point,
# there is no relationship between y4 and x4.
# We choose (p) and loess smoother lines (smooth) to get Fig. 9.2.

xyplot(y1 ~ x1, data = ans, type = c('p', 'smooth'))
xyplot(y2 ~ x2, data = ans, type = c('p', 'smooth'))
xyplot(y3 ~ x3, data = ans, type = c('p', 'smooth'))
xyplot(y4 ~ x4, data = ans, type = c('p', 'smooth'))

# What is also notable is that the smoother lines in Fig. 9.2 do not deceive us the
# way linear regression did.