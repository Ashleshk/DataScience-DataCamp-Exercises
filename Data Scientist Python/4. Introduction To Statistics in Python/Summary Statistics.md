## Mean and median
1. Import numpy with the alias np.
    - Create two DataFrames: one that holds the rows of food_consumption for 'Belgium' and another that holds rows for 'USA'. Call these be_consumption and usa_consumption.
    - Calculate the mean and median of kilograms of food consumed per person per year for both countries.

```python
# Import numpy with alias np
import numpy as np

# Filter for Belgium
be_consumption = food_consumption[food_consumption['country']=='Belgium']

# Filter for USA
usa_consumption = food_consumption[food_consumption['country']=='USA']

# Calculate mean and median consumption in Belgium
print(be_consumption.mean())
print(be_consumption.median())

# Calculate mean and median consumption in USA
print(usa_consumption.mean())
print(usa_consumption.median())
```
2. Problem-2 
    - Subset food_consumption for rows with data about Belgium and the USA.
    - Group the subsetted data by country and select only the consumption column.
    - Calculate the mean and median of the kilograms of food consumed per person per year in each country using .agg()

```python
# Import numpy as np
import numpy as np

# Subset for Belgium and USA only
be_and_usa = food_consumption[(food_consumption["country"]=='Belgium' ) | (food_consumption["country"]=='USA' )]

# Group by country, select consumption column, and compute mean and median
print(be_and_usa.groupby("country")["consumption"].agg([np.mean,np.median]))
```


## Mean vs. median

```python
# Import matplotlib.pyplot with alias plt
import matplotlib.pyplot as plt

# Subset for food_category equals rice
rice_consumption = food_consumption[food_consumption["food_category"]=='rice']

# Histogram of co2_emission for rice and show plot
rice_consumption["co2_emission"].hist()
plt.show()

# Subset for food_category equals rice
rice_consumption = food_consumption[food_consumption['food_category'] == 'rice']

# Calculate mean and median of co2_emission with .agg()
print(rice_consumption.agg([np.mean,np.median]))
```


## Quartiles
1. Calculate the quartiles of co2_emission
```python
# Calculate the quartiles of co2_emission
print(np.quantile(food_consumption["co2_emission"],[0,0.25,0.5,0.75,1]))
```

2. Calculate the six quantiles that split up the data into 5 pieces (quintiles) of the co2_emission column of food_consumption.
```python
# Calculate the quintiles of co2_emission
print(np.quantile(food_consumption['co2_emission'], [0, 0.2, 0.4, 0.6, 0.8, 1]))
```

3. Calculate the eleven quantiles of co2_emission that split up the data into ten pieces (deciles).
```python
# Calculate the deciles of co2_emission
print(np.quantile(food_consumption['co2_emission'], [0, 0.1, 0.2, 0.3,0.4,0.5,0.6, 0.7,0.8,0.9, 1]))
```




## Variance and standard deviation

```python
# Print variance and sd of co2_emission for each food_category
print(food_consumption.groupby("food_category")["co2_emission"].agg([np.var, np.std]))

# Import matplotlib.pyplot with alias plt
import matplotlib.pyplot as plt

# Create histogram of co2_emission for food_category 'beef'
food_consumption[food_consumption["food_category"]=='beef']["co2_emission"].hist()
plt.show()

# Create histogram of co2_emission for food_category 'eggs'
food_consumption[food_consumption["food_category"]=='eggs']["co2_emission"].hist()
plt.show()


```


## Finding outliers using IQR

```python
# Calculate total co2_emission per country: emissions_by_country
emissions_by_country = food_consumption.groupby('country')['co2_emission'].sum()

# Compute the first and third quantiles and IQR of emissions_by_country
q1 = np.quantile(emissions_by_country, 0.25)
q3 = np.quantile(emissions_by_country, 0.75)
iqr = q3 - q1

# Calculate the lower and upper cutoffs for outliers
lower = q1 - 1.5 * iqr
upper = q3 + 1.5 * iqr

# Subset emissions_by_country to find outliers
outliers = emissions_by_country[(emissions_by_country  < lower)|(emissions_by_country > upper)]
print(outliers)
```



## Finding Probability
Calculate the probability of selecting a deal for the different product types by dividing the counts by the total number of deals Amir worked on. Save this as probs.

```python
# Count the deals for each product
counts = amir_deals['product'].value_counts()

# Calculate probability of picking a deal with each product
probs = counts/counts.sum()
print(probs)
```



## Random Sampling

1. Set the random seed to 24.
Take a sample of 5 deals without replacement and store them as sample_without_replacement.
```python
# Set random seed
np.random.seed(24)

# Sample 5 deals without replacement
sample_without_replacement = amir_deals.sample(5)
print(sample_without_replacement)

# Sample 5 deals with replacement
sample_with_replacement = amir_deals.sample(5, replace =True)
print(sample_with_replacement)
```





