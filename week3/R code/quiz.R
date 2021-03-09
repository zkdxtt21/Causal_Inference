# install packages
install.packages("tableone")
install.packages("Matching")
install.packages("MatchIt")

# load packages
library(tableone)
library(Matching)


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

##########################
#propensity score matching
#########################

# fit a propensity score model. logistic regression
psmodel<-glm(treat~age+educ+black+hispan+married+nodegree+re74+re75,
    family=binomial(),data=mydata)

# create propensity score
pscore <- psmodel$fitted.values
summary(pscore)

# set seed
set.seed(931139)

# matching
psmatch <- Match(Tr=mydata$treat, M=1, X=pscore, replace=FALSE, caliper=NULL)
matched = mydata[unlist(psmatch[c('index.treated', 'index.control')]), ]

# table 1 for matched pair
matchedtab1 <- CreateTableOne(vars=xvars, strata='treat',
					data=matched, test=FALSE)
print(matchedtab1, smd=TRUE)


# set seed
set.seed(931139)

# Re-do matching using a caliper
psmatch <- Match(Tr=mydata$treat, M=1, X=pscore, replace=FALSE, caliper=0.1)
matched = mydata[unlist(psmatch[c('index.treated', 'index.control')]), ]

# table 1 for matched pair
matchedtab1 <- CreateTableOne(vars=xvars, strata='treat',
					data=matched, test=FALSE)
print(matchedtab1, smd=TRUE)


# outcome analysis
y_trt <- matched$re78[matched$treat==1]
y_con <- matched$re78[matched$treat==0]

# pairwise difference
diffy <- y_trt - y_con

#paired t-test
t.test(diffy)



