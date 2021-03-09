# install packages
install.packages("ipw")
install.packages("sandwich")
install.packages("survey")

# load packages
library(tableone)
library(Matching)
library(ipw)
library(survey)

# Now load the lalonde data (which is in the MatchIt package):
library(MatchIt)
data(lalonde)

# The data have n=614 subjects and 10 variables
dim(lalonde)
View(lalonde)
colnames(lalonde)
attach(lalonde)

# create 2 new variables
black  = as.numeric(lalonde$race == 'black')
hispan = as.numeric(lalonde$race == 'hispan')

# new dataset
mydata = cbind(age, educ, black, hispan, married, nodegree, re74, re75, re78, treat)
mydata = data.frame(mydata)

# confounding covariates
xvars <- c("age", "educ", "black", "hispan", "married", "nodegree", "re74", "re75")

#look at a table 1
table1<- CreateTableOne(vars=xvars,strata="treat", data=mydata, test=FALSE)
## include standardized mean difference (SMD)
print(table1,smd=TRUE)

# fit a propensity score model. logistic regression
psmodel<-glm(treat~age+educ+black+hispan+married+nodegree+re74+re75,
    family=binomial(),data=mydata)

# create propensity score
pscore <- psmodel$fitted.values
summary(pscore)

#create weights
ps <- pscore
weight<-ifelse(treat==1,1/(ps),1/(1-ps))
summary(weight)

#apply weights to data
weighteddata<-svydesign(ids = ~ 1, data =mydata, weights = ~ weight)

#weighted table 1
weightedtable <-svyCreateTableOne(vars = xvars, strata = "treat", 
                                 data = weighteddata, test = FALSE)

## Show table with SMD
print(weightedtable, smd = TRUE)

#fit a marginal structural model 
msm <- (svyglm(re78 ~ treat, design = svydesign(~ 1, weights = ~weight,
                  data =mydata)))
coef(msm)
confint(msm)


# fit propensity score model to get weights, but truncated
weightmodel<-ipwpoint(exposure= treat, family = "binomial", link ="logit",
                      denominator= ~ age+educ+black+hispan+married+nodegree+re74+re75, 
				data=mydata,trunc=.01)

#numeric summary of weights
summary(weightmodel$weights.trun)

mydata$wt<-weightmodel$weights.trun

#fit a marginal structural model (with trunc)
msm <- (svyglm(re78 ~ treat, design = svydesign(~ 1, weights = ~wt, 
                  data =mydata)))
coef(msm)
confint(msm)