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
    * Place the hypothesis testing workflow steps in order from first to last.
    * Answer
        * Identify population parameter that is hypothesized about.
        * Specify the null and alternative hypotheses.
        * Determine (standardized) test statistic and corresponding null distribution.
        * Conduct hypothesis test in Python.
        * Measure evidence against the null hypothesis.
        * Make a decision comparing evidence to significance level.
        * Interpret the results in the context of the original problem.

2. Two sample mean test statistic

```py
# Calculate the numerator of the test statistic
numerator = xbar_yes - xbar_no

# Calculate the denominator of the test statistic
denominator = np.sqrt(s_no **2 / n_no + s_yes ** 2 / n_yes)

# Calculate the test statistic
t_stat = numerator / denominator

# Print the test statistic
print(t_stat)
```

3. Calculating p-values from t-statistics

* Terrific t! Using a sample standard deviation to estimate the standard error is computationally easier than using bootstrapping. However, to correct for the approximation, you need to use a t-distribution when transforming the test statistic to get the p-value.

* As you increase the degrees of freedom, the t-distribution PDF and CDF curves get closer to those of a normal distribution. ✔

* What type of test does the alternative hypothesis indicate that we need? --Ans --Left-tailed

* erspicacious p-value predictions! When the standard error is estimated from the sample standard deviation and sample size, the test statistic is transformed into a p-value using the t-distribution.

```py 
# Calculate the degrees of freedom
degrees_of_freedom = n_no + n_yes - 2

# Calculate the p-value from the test stat
p_value = t.cdf(t_stat, df = degrees_of_freedom)

# Print the p_value
print(p_value)

```

4. **Paired t-tests**
* Is pairing needed?
    * t-tests are used to compare two sample means. However, the test involves different calculations depending upon whether the two samples are paired or not. To make sure you use the correct version of the t-test, you need to be able to identify pairing.
    * **Paired**
        * To test the effectiveness of a new elementary school study technique, pre- and post-tests are given to the same random sample of students.
        * Scientists wish to understand whether older children like sugar less than younger children. Siblings pairs were surveyed on their sugar preferences.
    * **Not paired**
        * To understand how location affects income, a survey of adults living in Budapest and another survey of adults living in London were conducted.
        * To test the effectiveness of a new elementary school study technique, pre- and post-tests are given to two different random samples of students.

```py
# Calculate the differences from 2012 to 2016
sample_dem_data['diff'] = sample_dem_data['dem_percent_12'] - sample_dem_data['dem_percent_16']

# Find the mean of the diff column
xbar_diff = sample_dem_data['diff'].mean()

# Find the standard deviation of the diff column
s_diff = sample_dem_data['diff'].std()

# Plot a histogram of diff with 20 bins
sample_dem_data['diff'].hist(bins = 20)
plt.show()
```

```PY
# Conduct a t-test on diff
test_results = pingouin.ttest(x=sample_dem_data['diff'], 
                              y=0, 
                              alternative="two-sided")

# Conduct a paired t-test on dem_percent_12 and dem_percent_16
paired_test_results = pingouin.ttest(x=sample_dem_data['dem_percent_12'],
                                    y=sample_dem_data['dem_percent_16'],
                                    paired=True,
                                    alternative='two-sided')



                              
# Print the paired test results
print(paired_test_results)
```

Using .ttest() lets you avoid manual calculation to run your test. When you have paired data, a paired t-test is preferable to the unpaired version because it reduces the chance of a false negative error.


5. ANOVA 

```py
# Calculate the mean pack_price for each shipment_mode
xbar_pack_by_mode = late_shipments.groupby("shipment_mode")['pack_price'].mean()

# Calculate the standard deviation of the pack_price for each shipment_mode
s_pack_by_mode = late_shipments.groupby("shipment_mode")['pack_price'].std()

# Boxplot of shipment_mode vs. pack_price
sns.boxplot(x= 'pack_price',
            y = 'shipment_mode',
            data = late_shipments)
plt.show()
```

6. Conducting an ANOVA test
*   The box plots made it look like the distribution of pack price was different for each of the three shipment modes. However, it didn't tell us whether the mean pack price was different in each category. To determine that, we can use an ANOVA test. The null and alternative hypotheses can be written as follows.
    * Ho -: Pack prices for every category of shipment mode are the same.
    * h1 -: Pack prices for some categories of shipment mode are different.

Use a significance level of 0.1.

late_shipments is available and pingouin has been loaded.
```py
# Run an ANOVA for pack_price across shipment_mode
anova_results = pingouin.anova(data= late_shipments, 
                               dv= 'pack_price', 
                               between='shipment_mode')



# Print anova_results
print(anova_results)
```

7. Pairwise t-tests
The ANOVA test didn't tell you which categories of shipment mode had significant differences in pack prices. To pinpoint which categories had differences, you could instead use pairwise t-tests.

```py
# Modify the pairwise t-tests to use Bonferroni p-value adjustment
pairwise_results = pingouin.pairwise_ttests(data=late_shipments, 
                                            dv="pack_price",
                                            between="shipment_mode",
                                            padjust="bonf")

# Print pairwise_results
print(pairwise_results)
```
----------------------------------------------------------------------------------------------------------------------------------------------------------------

# Chapter - 03: Proportion Tests
1. One-sample proportion tests

```py
# Hypothesize that the proportion of late shipments is 6%
p_0 = 0.06

# Calculate the sample proportion of late shipments
p_hat = (late_shipments['late'] == "Yes").mean()

# Calculate the sample size
n = len(late_shipments)

# Calculate the numerator and denominator of the test statistic
numerator = p_hat - p_0
denominator = np.sqrt(p_0 * (1 - p_0) / n)

# Calculate the test statistic
z_score = numerator / denominator

# Calculate the p-value from the z-score
p_value = 1 - norm.cdf(z_score)


# Print the p-value
print(p_value)
```


2. Two-sample proportion tests

* Test of two proportions
    * You may wonder if the amount paid for freight affects whether or not the shipment was late. Recall that in the late_shipments dataset, whether or not the shipment was late is stored in the late column. Freight costs are stored in the freight_cost_group column, and the categories are "expensive" and "reasonable".

    * The hypotheses to test, with "late" corresponding to the proportion of late shipments for that group, 

```py
# Calculate the pooled estimate of the population proportion
p_hat = (p_hats["reasonable"] * ns["reasonable"] + p_hats["expensive"] * ns["expensive"]) / (ns["reasonable"] + ns["expensive"])

# Calculate p_hat one minus p_hat
p_hat_times_not_p_hat = p_hat * (1 - p_hat)

# Divide this by each of the sample sizes and then sum
p_hat_times_not_p_hat_over_ns = p_hat_times_not_p_hat / ns["expensive"] + p_hat_times_not_p_hat / ns["reasonable"]

# Calculate the standard error
std_error = np.sqrt(p_hat_times_not_p_hat_over_ns)

# Calculate the z-score
z_score = (p_hats["expensive"] - p_hats["reasonable"]) / std_error

# Calculate the p-value from the z-score
p_value = 1 - norm.cdf(z_score)

# Print p_value
print(p_value)
```

3. proportions_ztest() for two samples
That took a lot of effort to calculate the p-value, so while it is useful to see how the calculations work, it isn't practical to do in real-world analyses. For daily usage, it's better to use the statsmodels package.

```py
# Count the late column values for each freight_cost_group
late_by_freight_cost_group = late_shipments.groupby("freight_cost_group")['late'].value_counts()

# Create an array of the "Yes" counts for each freight_cost_group
success_counts = np.array([45, 16])

# Create an array of the total number of rows in each freight_cost_group
n = np.array([545, 455])

# Run a z-test on the two proportions
stat, p_value = proportions_ztest(count = success_counts, nobs = n, 
                                  alternative = 'larger')


# Print the results
print(stat, p_value)
```

4. Chi-square test of independence

* The chi-square distribution
    * Chi-square hypothesis tests rely on the chi-square distribution. Like the t-distribution, it has degrees of freedom and non-centrality parameters.
    * The chi-square test statistic is a square number, so it is always non-negative, so only the right tail tends to be of interest.

```py
# Proportion of freight_cost_group grouped by vendor_inco_term
props = late_shipments.groupby('vendor_inco_term')['freight_cost_group'].value_counts(normalize=True)

# Convert props to wide format
wide_props = props.unstack()

# Proportional stacked bar plot of freight_cost_group vs. vendor_inco_term
wide_props.plot(kind="bar", stacked=True)
plt.show()

# Determine if freight_cost_group and vendor_inco_term are independent
expected, observed, stats = pingouin.chi2_independence(data = late_shipments, 
                                                       x = 'vendor_inco_term',
                                                       y ='freight_cost_group')

# Print results
print(stats[stats['test'] == 'pearson']) 
```

5. Visualizing goodness of fit
* The chi-square goodness of fit test compares proportions of each level of a categorical variable to hypothesized values. Before running such a test, it can be helpful to visually compare the distribution in the sample to the hypothesized distribution.

```py
# Find the number of rows in late_shipments
n_total = len(late_shipments)

# Create n column that is prop column * n_total
hypothesized["n"] = hypothesized["prop"] * n_total

# Make a yellow bar graph of vendor_inco_term versus n
plt.bar(incoterm_counts['vendor_inco_term'], incoterm_counts['n'], color="red", alpha=0.5)

# Add blue points for hypothesized counts
plt.bar(hypothesized['vendor_inco_term'], hypothesized['n'], color ='blue',alpha=0.5)
plt.show()
```
6. Performing a goodness of fit test
The bar plot of vendor_inco_term suggests that the distribution across the four categories was quite close to the hypothesized distribution. You'll need to perform a chi-square goodness of fit test to see whether the differences are statistically significant.

```py
# Perform a goodness of fit test on vendor_inco_term
gof_test = chisquare(f_obs = incoterm_counts ['n'], f_exp = hypothesized['n'])


# Print gof_test results
print(gof_test)
```


# Non-Parametric Tests
























