# Chapter 10
# Carbon and Forests: Graphs and Regression

# Forests help store carbon, and, in developing countries, are a source of livelihoods
# for rural people.We will examine data on carbon storage and forest livelihoods used
# by Chhatre and Agrawal (2009). This dataset was put together by the International
# Forestry Resources and Institutions (IFRI) network.

# 10.2 Graphs

library(mosaic)

# We then load the dataset that can be downloaded from the web as we discussed
# in an earlier chapter. It is in a file with a comma separated variable (csv) format.

ifri <- read.csv('ifri_car_liv.csv')

# We rename the two key variables to make the results easier to understand; zbio is
# renamed carbon, and zliv is renamed liveli:

ifri$carbon <- ifri$zbio
ifri$liveli <- ifri$zliv

# On examining the data object in R Studio, we found that there were some rows
# of missing values that had crept in beyond the 80th observation (there are 80
# observations in the original dataset). We can easily subset the data by selecting
# the first 80 rows:

ifri <- ifri[1:80, ]

# We create ‘factors’ from the ownership and rulematch variables, so that the graphs
# are more informative.

# viewing top 6 rows

ifri$f_own <- factor(ifri$ownstate, labels = c('Community', 'State'))
ifri$f_rule <- factor(ifri$rulematch, labels = c('Low', 'High'))

# The variable liveli is an index of forest livelihoods (based on fractions of subsistence
# needs like firewood, fodder etc. met from the forest).We examine its histogram
# (Fig. 10.1):

histogram(~liveli, data = ifri, type = 'percent')

# The variable carbon represents carbon storage (standardized), and is based on
# basal area of trees per hectare. We examine its histogram (Fig. 10.2):

histogram(~carbon, data = ifri, type = 'percent')

# There is substantial variation in carbon storage and livelihoods index in the sample.
# We look at the scatterplot of carbon and liveli (Fig. 10.3):

xyplot(carbon ~ liveli, data = ifri, type = c('p', 'smooth', 'r'))

# There is a very low correlation between liveli and carbon (Fig. 10.3); this is a key
# observation. Some forests have high levels of both carbon and liveli, some have low
# levels of both, and some have low or high levels of either.We are interested in seeing
# how the levels of livelihoods and carbon vary among forests with different forest
# sizes, with ownership by community or state, and by perception of rules by forest
# users.

# We use conditional plots and multiple regression to delve deeper into Fig. 10.3.
# We will see how the average level of carbon varies with livelihoods, conditional on
# other variables. Cleveland (1993) showed that conditional plots were a key technique
# to visualize data, and in R the mosaic package builds on the lattice package to provide
# this facility.

# We examine the scatterplot of carbon versus liveli conditional on lnfsize; ‘cutting’
# lnfsize into four groups with an equal number of observations (Fig. 10.4):

xyplot(carbon ~ liveli | cut(lnfsize, 4), data = ifri, type = c('p', 'smooth', 'r'), layout = c(4, 1), span = 1)

# In the code above we used layout to get a one row, four column layout, and span to
# change the amount of smoothing.We see that the average level of carbon conditional
# on liveli varies a little with the log of forest size, being higher with higher levels of the
# log of forest size.We now examine the scatterplot of carbon versus liveli conditional
# on both ownstate and rulematch (Fig. 10.5):

xyplot(carbon ~ liveli | f_own + f_rule, data = ifri, type = c('p', 'r', 'smooth'), layout = c(4, 1), span = 0.8)

# The slope of average value of carbon versus liveli appears to be negative for
# community ownership and positive for state ownership in Fig. 10.5.

# 10.3 Multiple Regression

# Figures 10.4 and 10.5 suggest that forest size, rules and ownership affect the average
# level of carbon conditional on livelihoods. Therefore, we now run a multiple regression
# to see how the average value of carbon varies with liveli when it is interacted
# with lnfsize, rulematch and ownstate.

# We run the regression with the lm command, and use colons for interactions
# between variables:

mod1 <- lm(carbon ~ liveli + ownstate + liveli:ownstate + rulematch + lnfsize + lnfsize:liveli + liveli:rulematch, data = ifri)

# Displaying regression

library(arm)
display(mod1)

# We can get a figure that shows the coefficients and the confidence intervals
# (Fig. 10.6) using the mplot command in the mosaic package:

mod.1 <- makeFun(mod1)
mplot(mod1, which = 7)

# Although the coefficient of ownstate is not statistically significant, the interaction
# of liveli and ownstate is statistically significant (Fig. 10.6). Although the interactions
# of liveli and lnfsize and liveli and rulematch are not statistically significant, the
# coefficients of liveli, rulematch and lnfsize are statistically significant.
# We can plot the residuals versus fitted points with mplot and can also plot the
# histogram of residuals. We find there are no strong patterns in the residuals and the
# distribution of residuals is reasonable (Fig. 10.7)

mplot(mod1, which = 1)

histogram(~resid(mod1), breaks = 10, fit = 'normal', type = 'density')

# To better interpret the deterministic part of the model, which has several interactions,
# we should plot graphs (Gelman and Hill 2007). First, we use xyplot to
# plot the scatter of points of carbon versus liveli. Second, we use plotFun to plot
# the line of fit of mod1 of carbon versus liveli, with lnfsize = 5, ownstate = 0.5
# and rulematch = 0.5. Third, we plot another line of fit, changing only lnfsize to 9.
# Fourth, we use ladd to label the lines (Fig. 10.8). This gives us the following chunk
# of code:

xyplot(carbon ~ liveli, data = ifri, col = 'gray60')
plotFun(mod.1(liveli, lnfsize = 5, ownstate = 0.5, rulematch = 0.5) ~ liveli, add = TRUE, lty = 1)
plotFun(mod.1(liveli, lnfsize = 9, ownstate = 0.5, rulematch = 0.5) ~ liveli, add = TRUE, lty = 2)
ladd(grid.text('high lnfsize', x = 1, y = 1, default.units = 'native'))
ladd(grid.text('low lnfsize', x = 0, y = 1, default.units = 'native'))

# In Fig. 10.8 we see that higher forest size is associated with higher carbon storage
# and livelihoods.
# We now vary ownstate, and modify the code used above to produce Fig. 10.9.

xyplot(carbon ~ liveli, data = ifri, col = 'gray60')
plotFun(mod.1(liveli, lnfsize = 7, ownstate = 0, rulematch = 0.5) ~ liveli, add = TRUE, lty = 1)
plotFun(mod.1(liveli, lnfsize = 7, ownstate = 1, rulematch = 0.5) ~ liveli, add = TRUE, lty = 2)
ladd(grid.text('State', x = 1.7, y = 0.5, default.units = 'native'))
ladd(grid.text('Community', x = 0, y = 1.5, default.units = 'native'))

# In Fig. 10.9 we see that in community owned forests, there is a negative association
# between carbon storage and livelihoods, while there is virtually no association
# between them in state owned forests. Some community owned forests have relatively
# high levels of carbon storage and low levels of livelihoods.
# We now vary rulematch, and modify the code used above to produce Fig. 10.10

xyplot(carbon ~ liveli, data = ifri, col = 'gray60')
plotFun(mod.1(liveli, lnfsize = 7, ownstate = 0.5, rulematch = 0) ~ liveli, add = TRUE, lty = 1)
plotFun(mod.1(liveli, lnfsize = 7, ownstate = 0.5, rulematch = 1) ~ liveli, add = TRUE, lty = 2)
ladd(grid.text('High rulematch', x = 1, y = 1, default.units = 'native'))
ladd(grid.text('Low rulematch', x = 0, y = -1, default.units = 'native'))

# In Fig. 10.10 we see that a higher level of rule match (local users perceive rules
# to be appropriate) is associated with higher levels of carbon storage and livelihoods.

