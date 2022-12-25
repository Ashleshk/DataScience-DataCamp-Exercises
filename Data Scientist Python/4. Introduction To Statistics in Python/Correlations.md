## Relationships between variables

1. Create a scatterplot of happiness_score vs. life_exp (without a trendline) using seaborn.
Show the plot.
```python
# Create a scatterplot of happiness_score vs. life_exp and show
import seaborn as sns
sns.scatterplot(x="life_exp", y="happiness_score", data=world_happiness)
plt.show()
```


```python
# Create scatterplot of happiness_score vs life_exp with trendline
import seaborn as sns
sns.lmplot(x="life_exp", y="happiness_score", data=world_happiness, ci=None)
plt.show()
```


```python
# Create scatterplot of happiness_score vs life_exp with trendline
sns.lmplot(x='life_exp', y='happiness_score', data=world_happiness, ci=None)

# Show plot
plt.show()

# Correlation between life_exp and happiness_score
cor = world_happiness['life_exp'].corr(world_happiness['happiness_score'])

print(cor)
```
## Transforming variables

```python
# Create log_gdp_per_cap column
world_happiness['log_gdp_per_cap'] = np.log(world_happiness['gdp_per_cap'])

# Scatterplot of log_gdp_per_cap and happiness_score
sns.scatterplot(x="log_gdp_per_cap", y="happiness_score", data=world_happiness)
plt.show()

# Calculate correlation
cor = world_happiness["log_gdp_per_cap"].corr(world_happiness["happiness_score"])
print(cor)
```


```python
```


```python
```