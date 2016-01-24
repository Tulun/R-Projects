# 6.1 Introduction
# Cobb-Douglas functions are used to model production and utility. They are simple
# and versatile. The Cobb-Douglas function is used in the Solow model in Chap. 12
# and the fishing model in Chap. 13.
# According to Hoover (2012, p. 348), “The Cobb-Douglas production function
# (Y = ALaK1−a) provides a useful representation of aggregate supply.” Hoover
# (2012, p. 331) uses US data to find that aggregate supply for the US economy in 2008
# can be represented by Y = 9.63 L0.67K0.33. The units for L are million worker-hours
# per year, for K are $ billion, and for Y are $ billion.

# We can write the Cobb-Douglas Production function as
# Y = AL^a * K^1−a
# where Y is production, A is an index of technology, L is labour and K is capital.
# We see immediately that when L and K are zero, Y is zero.We will explore some
# other properties of this function graphically. We load the mosaic package.

library(mosaic)

# Let A = 5 and a = 0.7. We now plot Y as a function of L taking K to be equal to
# 20, using plotfun

plotFun(A * (L^0.7) * (K^0.3) ~ L, K=20, A=5, ylim = range(-5, 101), xlim = range(-1, 21))

# We see that as we increase L the amount of increase in Y diminishes (Fig. 6.1).
# We can now see how the curve relating aggregate production to L changes as we
# change the amount of K. We plot two curves for Y versus L; one with K = 20 and
# the other with K = 40.
# 3rd line adds a shift in A holding K constant.

plotFun(A * (L^0.7) * (K^0.3) ~ L, K=20, A=5, ylim = range(-5, 151), xlim = range(-1, 21))
plotFun(A * (L^0.7) * (K^0.3) ~ L, K=40, A=5, ylim = range(-5, 151), xlim = range(-1, 21), lty = 2, add = TRUE)
plotFun(A * (L^0.7) * (K^0.3) ~ L, K=20, A=10, ylim = range(-5, 151), xlim = range(-1, 21), lty = 3, add = TRUE)

# An increase in K shifts the Y versus L curve up—increasing K helps L become
# more productive (Fig. 6.2).

# We can see howthe curve relating aggregate production to L changes as we change
# the level of A. As A increases from 5 to 10 the Y versus L curve shifts up (Fig. 6.3).
# We think of A as the level of technology; an important way we get more output is
# through increases in A.

plotFun(A * (L^0.7) * (K^0.3) ~ L, K=20, A=5, ylim = range(-5, 151), xlim = range(-1, 21))
plotFun(A * (L^0.7) * (K^0.3) ~ L, K=20, A=10, ylim = range(-5, 151), xlim = range(-1, 21), lty = 3, add = TRUE)

# We now plot Y as a function of K taking L to be equal to 20. Again we see that
# as we increase K, the corresponding increase in Y diminishes (Fig. 6.4).

plotFun(A * (L^0.7) * (K^0.3) ~ K, L=20, A=5, ylim = range(-5, 101), xlim = range(-1, 21))

# We now plot isoquants— combinations of K and L that give us certain values of
# Y (Fig. 6.5). When using the plotFun command, we now use L & K to the right of
# the tilde:

plotFun(A * (L ^ 0.7) * (K ^ 0.3) ~ L & K, A = 5, filled = FALSE, xlim = range(0, 21), ylim = range(0, 100))

# We can use the following code to produce a three-dimensional view (Fig. 6.6).
# We use the same command that we used for the isoquants, but now indicate that we
# want a surface plotted (surface = TRUE):

plotFun(A * (L ^ 0.7) * (K ^ 0.3) ~ L & K, A = 5, filled = FALSE, xlim = range(0, 21), ylim = range(0, 100), surface = TRUE)
