# Introduction to Hypothesis Testing

1. Calculating the sample mean

```py
# Print the late_shipments dataset
print(late_shipments)

# Calculate the proportion of late shipments

late_prop_samp = (late_shipments['late'] == "Yes").mean()
# Print the results
print(late_prop_samp)
```

2. Calculating a z-score

```py
# Hypothesize that the proportion is 6%
late_prop_hyp = 0.06

# Calculate the standard error
std_error = np.std(late_shipments_boot_distn, ddof = 1)

# Find z-score of late_prop_samp
z_score = (late_prop_samp - late_prop_hyp)/std_error
```

3. p-values

* Calculating p-values
    * In order to determine whether to choose the null hypothesis or the alternative hypothesis, you need to calculate a p-value from the z-score.

    * You'll now return to the late shipments dataset and the proportion of late shipments.

    * The null hypothesis,is that the proportion of late shipments is six percent.

    * The alternative hypothesis,is that the proportion of late shipments is greater than six percent.


* Left tail, right tail, two tails
    * Hypothesis tests are used to determine whether the sample statistic lies in the tails of the null distribution. However, the way that the alternative hypothesis is phrased affects which tail(s) we are interested in.

    * Instructions
        * **Determine the appropriate type of hypothesis test for answering these questions.**
    * Answers
        * **Two tails** :- 
            * Is there a difference between the voting preferences of 40-year-olds and 80-year-olds?
            * Should we expect Slack and Zoom to have dissimilar mean numbers of employees over the last three years?
        * **Left tail** :-
            * Is there evidence to conclude that Belgian workers tend to have lower salaries than italian workers?
            * Are grapes lower in popularity than raisins, on average?
        * **Right tail**
            * Do hamburgers have more calories than hot dogs, on average?
            * Do cats tend to live longer than dogs?
            * Does there tend to be more than 12 fluid ounces of soda per can?

* Question
    * What type of test should be used for this alternative hypothesis?

```py
# Calculate the z-score of late_prop_samp
z_score = (late_prop_samp - late_prop_hyp) / std_error

# Calculate the p-value
p_value = 1 - norm.cdf(z_score, loc=0, scale=1)
                 
# Print the p-value
print(p_value) 
```


4. Calculating a confidence interval

```py
# Calculate 95% confidence interval using quantile method
lower = np.quantile(late_shipments_boot_distn, 0.025)
upper = np.quantile(late_shipments_boot_distn, 0.975)

# Print the confidence interval
print((lower, upper))
```


5. **Type I and type II errors**
    * For hypothesis tests and for criminal trials, there are two states of truth and two possible outcomes. Two combinations are correct test outcomes, and there are two ways it can go wrong.

    * The errors are known as false positives (or "type I errors"), and false negatives (or "type II errors").

    * **False positive (Type I) errors :**
        * Finding the defendant guilty when infact the defendant was innocent.
        * Rejecting the null hypothesis when infact the null hypothesis is true.

    * **False negative (Type II) errors :** 
        * Finding the defendant not quilty when infact the defendant did commit the crime.
        * Failing to reject the null hypothesis when infact the null hypothesis is false.

    * **Not an error**
        * Finding the defendant guilty when infact they did commit the crime.
        * Failing to reject the null hypothesis when infact the null hypothesis is true.
        * Finding the defendant not guilty when infact they were innocent.
        * Rejecting the null hypothesis when infact the null hypothesis is false.


---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

# Chapter -2 : Two-Sample and ANOVA Tests

1. Performing t-tests


# Proportion Tests


# Non-Parametric Tests
























