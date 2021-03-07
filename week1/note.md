# 1.1 Confusion over causality
## Confusion exists
1. spurious correlation
- Causally unrelated variables might happen to be highly correlated with each other over some period of time.  
2. Anecdotes  
- People have beliefs about causal effects in their own lives.
3. Science Reporting
- Headlines often do not use the forms of the word cause, but do get interpreted causally.
4. Reverse Causality
- Even if there is a causal relationship, sometimes the direction is unclear.
- Example: urban green space and exercise

## How to clear up confusion?
The field of causal inference or causal modeling attempts to do this by proposing:
- formal definitions of causal effects
- assumptions necessary to identify causal effects from data
- rules about what variables need to be controlled for
- sensitivity analysis to determine the impact of violations of assumptions on conclusions

## A brief history
- Statisticians started working on causal modeling as far back as the 1920s.
- It became its own area of statistical research since about the 1970s
- Some highlists:
    - Re-introduction of potential outcomes; Rubin causal model (Rubin 1974)
    - Causal diagrams (Greenland and Robins 1986; Pearl 2000)
    - Propensity scores (Rosenbaum and Rubin 1983)
    - Time-dependent confounding (Robins 1986; Robins 997)
    - Optimal dynamic treatment strategies (Murphy 2003; Robins 2004)
    - Targeted learning (van der Laan 2009) related to machine learning

## Going forward
causal inference from observational studies and natural experiments.
(don't focus on randomized trials)  
- Causal inference requires making some untestable assumptions (referred to as causal assumptions)
- Cochran (1972) concludes:  
    - demands a good deal of humility
    - groping toward the truth
  
  
---

# 1.2 Potential outcomes and counterfactuals
## Treatment and Outcomes
Suppose we are interested in the causal effect of some treatment A on some outcome Y.  

- Treatment examples:
    - A = 1 if receive influenza vaccine; A = 0 otherwise
    - A = 1 if take statins; A = 0 otherwise
    - A = 1 if receive active drug; A = 0 if receive placebo
- Outcome exampels:
    - Y = 1 if develop cardiovascular disease within 2 years; Y = 0 otherwise
    - Y = time until death

## Potential Outcomes
Think of potential outcomes as the outcomes we would see under each possible treatment option

Notation $Y^a$ is the outcome that would be observed if treatment was set to A = a.

Each person has potential outcomes Y^0 and Y^1.

## Counterfactuals
Conterfactual outcomes are ones that would have been observed, had the treatment been different.  
- Examples: 
    - If my treatment was A = 1, then my counterfactual outcome is Y^0.
    - If my treatment was A = 0, then my counterfactual outcome is Y^1.

## Potential outcomes and counterfactuals
- **Before** the treatment decision is made, any outcome is a potential outcome: Y^0 and Y^1.
- **After** the study, there is an observed outcome, Y = Y^A, and counterfactual outcomes Y^(1-A). 

Counterfactual outcomes are typically assumed to be the same as potential outcomes. (use interchangeably)

---
# 1.3 Hypothetical interventions
## Intervention
It is cleanest to think of causal effects of interventions or actions.
- Causal effects of variables that can be manipulated.

Cuasual effects of (hypothetical) interventions are generally well defined.
- Outcome if prescribed drug A vesus outcome if prescribed drug B.

## One Version of Treatment
It is common to assume there are no hidden versions of treatment.
- Example: causal effect of BMI(body mass index) on health outcomes. 
- Problems:
    - many potential ways to achieve a BMI of a particular value, may be associated with outcomes.
- Solutions:
    Weight is not directly manipulable. Better to use interventions that aim at manipulating weight.

## Immutable variables
It is also less clear what a causal effect of an immutable vairable would mean. (do not fit as cleanly in the potential outcomes framework)
- Example: Race, gender, age.

## Manipulable Vs Not Manipulable
1. Race -> Name on resume
2. Obesity -> Bariatric surgery
3. Socioeconomic status -> Gift of money

## Causal Effects
focus on treatments/exposures that could be thought of as interventions.  
- Treatments that we can imagine being randomized(manipulated) in a hypothetical trial

Reasons:  
- their meaning is well defined
- potentially actionable

### What are Causal effects?
In general: A had a causal effect on Y if Y^1 differs from Y^0.

## Fundamental Problem of Causal Inference

We can only observe one potential outcome for each person. (unit level causal effects)  
But we can estimate population level causal effects with certain assumptions.

---
# 1.4 Causal Effects
## Average Causal Effect
- Hypothetical Worlds
![ace_hypo](average_causal_effect.png
)  
Average Causal Effect = E(Y^1 - Y^0)  
- Real World
![ace_real](ace_real.png
)  
Average Causal Effect = E(Y^1 - Y^0) != E(Y|A=1) - E(Y|A=0)

Examples:
- Regional (A=1) versus general (A=0) anesthesia for hip fracture surgery on risk of major pulmonary complications
- Treatment is thiazide diuretic (A=1) or no treatment (A=0) among hypertensive patients. Outcome (Y) is systolic blood pressure.

## Conditioning on, versus setting, treatment

In general, E(Y^1 - Y^0) != E(Y|A=1) - E(Y|A=0).  
Conditioning means restricting to the subpopulation of people who actually had A = 1.  
E(Y|A=1) - E(Y|A=0) is generally not a causal effect, because it is comparing two different populations of people.

## Other Causal Effects
- E(Y^1 / Y^0): causal relative risk
- E(Y^1 - Y^0 | A=1): causal effect of treatment on the treated.
![cet](cet.png
)  
- E(Y^1 - Y^0 | V=v): average causal effect in the subpopulation with covariate V=v

## Challenges
-  
- What assumptions are necessary to estimate causal effects from observed data?

---
# 1.5 Causal Assumptions

## Identifiability
Identifiability of causal effects requires making some untestable assumptions. These are generally called causal assumptions.

The most common are:
- Stable Unit Treatment Value Assumption (SUTVA)
- Consistency
- Ignorability
- Positivity

Assumptions will be about the observed data: Y, A, and a set of pre-treatment covariates X.

### (a) SUTVA (Stable Unit Treatment Value Assumption (SUTVA))

- No interference:
    - Units do not interfere with each other
    - Treatment assignment of one unit does not affect that outcome of another unit
    - Spillover or contagion are also terms for interference
- One version of treatment

SUTVA allows us to write potential outcome for the ith person in terms of only that person's treatments.

### (b) Consistency Assumption

The potential outcome under treatment A=a, Y^a is euqal to the observed outcome if the actual treatment received is A=a.

Y = Y^a if A = a for all a

### (c) Ignorability Assumption (No Unmeasured Confounders' Assumption)

Given pre-treatment covariates X, treatment assignment is independent from the potential outcomes.

Y0, Y1 is independent to A|X

Among people iwth the same values of X, we can think of treatment A as being randomly assigned.

### (d) Positivity Assumption

For every set of values for X, treatment assignment was not deterministic:  
P(A=a|X=x) > 0 for all a and x

Otherwise, we would have no observed values of Y for one of the treatment groups for those value of X.

## Observed Data and Potential Outcomes
E(Y|A=a, X=x) involves only obsered data.
- E(Y|A=a, X=x) = E(Y^a | A=a, X=x) by consistency.
- E(Y|A=a, X=x) = E(Y^a|X=x) by ignorability.  
If we want a marginal causal effect, we can average over X.

---
# 1.6 Stratification

## Conditioning and Marginalizing
Under certain causal assumptions, we have E(Y|A=a, X=x) = E(Y^a|X=x).  
If we want a marginal causal effect, we can average over the distribution of X.
Suppose there is a single categorical X variable. Then,  
E(Y^a) = Sum_x(E(Y|A=a, X=x) * P(X=x)) (standardization)

## Standardization
Standardization involves stratifying and then averaging.
- obtain a treatment effect within each stratum and then pool across stratum, weighting by the probability(size) of each stratum.
- From data, you could estimate a treatment effect by computing means under each treatment within each stratum, and then pooling across stratum.

## Problems with Standardization
Typicaaly, there will be many X variables needed to achieven ignorability.  
Then stratification would lead to many empty cells.  
We need alternatives to standardization.

---
# 1.7 Incident User and Active Comparator Designs

## Cross-Sectional Look at Treatments
- There maybe selection bias that is very difficult to control for. 
- Lingering treatment effect

## Incident User Design
- Incident user designs restrict the treated population to those newly initiating treatment (new user design).
- If the comparison is no treatment, it is not obvious when follow-up should start no treatment group.
- Having an active comparator makes this much clearner.

## Active Comparator Desgin
- Active comparator designs tend to involve much less confounding.
- However, the causal question is more narrow.

## Combine Them
Incident user design with active comparator is mostly used in causal inference.

## Other Considerations
- It is not always possible to implement an incident user design. (e.g. causal effect of air pollution)
- Sometimes no treatment (unexposed) is the comparison group of interest. (smoker vs non-smoker) Don't have a active comparator.
- Causal methods exist that can handle time-varing treatments. (e.g. causal effect of treatment regimens over time)
