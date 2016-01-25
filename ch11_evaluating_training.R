# 11.1 Introduction
# A running debate in statistics is whether we can reach causal conclusions with observational
# data; or is it that only experiments can help us reach causal conclusions? The
# Neyman Rubin causal framework has been very influential, and has helped clarify
# these issues.

# In the Neyman Rubin causal framework, we see the effect of a treatment by
# comparing it to a control. A unit of analysis, for example, a person, could either
# receive a treatment or not. If the person receives the treatment,we need to compare the
# resulting outcome with what the same person would have experienced had the person
# not received the treatment. This is counterfactual, and is not observed. However, if
# on average those receiving the treatment are similar to those in the control group, the
# average effect of the treatment can be calculated. A randomized experiment helps
# ensure the similarity of the treatment and control groups in respects other than the
# treatment.With observational data we could use a set of relevant covariates to match
# the treatment and control groups so that we are comparing like with like.

# In a key paper, Lalonde (1986) had shown that the experimental evaluation of a
# training programme and the econometric evaluation with observational data reached
# different conclusions. However, Dehejia and Wahba (1999) later used matching to
# show that an observational study using matching could reach similar conclusions to
# the experimental evaluation. In matching, we choose from our observations so that
# the treatment and control groups are like each other with respect to the covariates.

# 11.2 Lalonde Dataset
# We shall look at a subset of the data used by Lalonde (1986). We load the MatchIt
# package, and then the dataset called lalonde that it includes.

library(MatchIt)
library(mosaic)
data(lalonde)
trellis.par.set(theme.mosaic(bw = TRUE))

# We can look at the help for the dataset lalonde with ?lalonde.We examine the
# structure of the lalonde dataset.

str(lalonde)

# There are 614 observations. We want to know whether the treatment (treat)
# increased the earnings in 1978 (re78)? The treatment was a labour training programme
# that provided work experience for 6 to 18 months to people with economic
# and social problems.
# We now use a conditional density plot (smoothed histogram, Fig. 11.1) to see the
# distribution of age in the treatment and control group. We see that the treatment and
# control groups differ in their balance and do not overlap completely. The balance of
# the distribution with respect to whether the race of the person is black is also different
# in the treatment and control groups (Fig. 11.1).

densityplot(~age,groups=factor(treat), data=lalonde, col=c('gray30', 'black'), auto.key = TRUE)
histogram(~factor(black)|factor(treat), data=lalonde, type = 'percent')

# We can also use the favstats command in the mosaic package to get our
# favourite descriptive statistics for the treatment and control group.

favstats(age, data = lalonde, groups = treat)
favstats(black, groups = treat, data = lalonde)

# Themaximum age in the treatment group is 48; in the control group it is 55. About
# 84% of the treatment group is black compared to only 20% of the control group.

# 11.3 Matching Treatment and Control
# We will now match the data, using functions in the matchit package. We will not
# go into the details of matching; we can think of it intuitively. Let an observation in
# the treatment group be of a person who is a 35 year old black. Let there be 3 control
# observations we could match the treatment observation to: (1) a 20 year old black,
# (2) a 32 year old white, and (3) a 32 year old black. We would match the treatment
# observation to the third control observation who is closest in terms of age and race.
# Matching has to account for a number of covariates. There are different ways of
# matching, and in our example we will use the coarsened exact matching technique
# suggested by Ho et al. (2011), who are also the authors of the MatchIt package

# We now use the matchit function to match the data using the coarsened exact
# matching method.

m.out <- matchit(treat ~ age + educ + black + hispan + married + nodegree + re74 + re75, data = lalonde, method = 'cem')
m.out

# The original data has 429 observations in the control group and 185 observations
# in the treatment group; after matching there are 78 observations in the control group
# and 68 observations in the treated group.

# Since we have many covariates that we are looking at, we can use the propensity
# score to summarize the probability of being in the treatment group as a function of
# covariates. We can plot histograms that show how the propensity score balance has
# improved (Fig. 11.2). This is a function written into the MatchIt package.

plot(m.out, type = 'hist')

# We can recover the data:

m.data <- match.data(m.out)

# We can also see that the balance has improved among the treatment and control
# groups with respect to age and race (Fig. 11.3, compare with Fig. 11.1).

densityplot(~age, groups=factor(treat),data=m.data,col=c("grey30","black"), auto.key=TRUE)
histogram(~factor(black)|factor(treat),data=m.data,type='percent')
favstats(age,data=m.data,groups=treat)

# 11.4 Comparing Treatment and Control
# One advantage of matching is that we do not look at the outcome variable while
# matching; we only check if we have achieved better balance and reduced overlap.
# We will now compare the difference in earnings between the treatment and control
# group, before and after matching. We first use favstats:

favstats(re78, data = lalonde, groups = treat)

favstats(re78, data = m.data, groups = treat)

# Before matching the control group has higher earnings, whereas after matching
# the treatment group has higher earnings. We run simple regressions, and plot the
# results (Figs. 11.4 and 11.5):

fit1 <- lm(re78 ~ treat, data = lalonde)
library(arm)
display(fit1)

fit.1 <- makeFun(fit1)
xyplot(re78 ~ jitter(treat),data=m.data, pch =1 )
plotFun(fit.1(treat) ~ treat,add=TRUE)
fit2 <- lm(re78 ~ treat,data=m.data)
display(fit2)

fit.2 <- makeFun(fit2)
xyplot(re78 ~ jitter(treat),data=m.data,pch=1)
plotFun(fit.2(treat) ~ treat,add=TRUE)

# Ho et al. (2011) see matching as a form of preprocessing of the data, not as a form
# of analysis. To make the comparison doubly robust, they advocate both matching
# before analysis, and adjusting for covariates after matching.

fit3 <- lm(re78 ~ treat + age + educ + black + hispan + married + nodegree + re74 + re75, data = m.data)
display(fit3)

# Aftermatching the data, we ran a simple regression of earnings on treatment (fit2),
# and another regression of earnings on treatment with other covariates (fit3). We see
# that there is not much difference between the estimate of treatment effects in the
# models fit2 (1001) and fit3 (1012). As Ho et al. (2011) point out, with matching we
# need to worry less about whether we have specified the model correctly. The crucial
# issue is whether the covariates we have matched for and adjusted for, are the right
# ones.

