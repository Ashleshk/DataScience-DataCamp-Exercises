## stripplot() and swarmplot()

```python
# Create the stripplot
sns.stripplot(data=df,
         x='Award_Amount',
         y='Model Selected',
         jitter=True)

plt.show()
```

 * Create a swarmplot() of the same data, but also include the hue by Region

 ```python
 # Create and display a swarmplot with hue set to the Region
sns.swarmplot(data=df,
         x='Award_Amount',
         y='Model Selected',
         hue='Region')

plt.show()
 ```

## boxplots, violinplots and boxenplots

```python
# Create a violinplot with the husl palette
# Create a boxplot
sns.boxplot(data=df,
         x='Award_Amount',
         y='Model Selected')

plt.show()
plt.clf()
```

```python
# Create a violinplot with the husl palette
sns.violinplot(data=df,
         x='Award_Amount',
         y='Model Selected',
         palette ='husl')

plt.show()
plt.clf()
```

```python
# Create a boxenplot with the Paired palette and the Region column as the hue
sns.boxenplot(data=df,
         x='Award_Amount',
         y='Model Selected',
         palette='Paired',
         hue='Region')

plt.show()
plt.clf()
```

```python
# Show a countplot with the number of models used with each region a different color
sns.countplot(data=df,
         y="Model Selected",
         hue="Region")

plt.show()
plt.clf()
```

```python
# Create a pointplot and include the capsize in order to show caps on the error bars
sns.pointplot(data=df,
         y='Award_Amount',
         x='Model Selected',
         capsize=.1)

plt.show()
plt.clf()
```

```python
# Create a barplot with each Region shown as a different color
sns.barplot(data=df,
         y='Award_Amount',
         x='Model Selected',
         hue='Region')

plt.show()
plt.clf()
```

## Regression and residual plots

```python
# Display a regression plot for Tuition
sns.regplot(data=df,
         y='Tuition',
         x='SAT_AVG_ALL',
         marker='^',
         color='g')

plt.show()
plt.clf()

# Display the residual plot
sns.residplot(data=df,
          y='Tuition',
          x='SAT_AVG_ALL',
          color='g')

plt.show()
plt.clf()
```


## Regression plot parameters

```python
# The final plot should include a line using a 2nd order polynomial
sns.regplot(data=df,
            y='Tuition',
            x='PCTPELL',
            x_bins=5,
            order=2)

plt.show()
plt.clf()
```

## Binning data

```python
# Create a scatter plot and bin the data into 5 bins
sns.regplot(data=df,
            y='Tuition',
            x='UG',
            x_bins=5)

plt.show()
plt.clf()

# Create a regplot and bin the data into 8 bins
sns.regplot(data=df,
         y='Tuition',
         x='UG',
         x_bins=8)

plt.show()
plt.clf()
```


## Creating heatmaps


```python
# Create a crosstab table of the data
pd_crosstab = pd.crosstab(df["Group"], df["YEAR"])
print(pd_crosstab)

# Plot a heatmap of the table
sns.heatmap(pd_crosstab)

# Rotate tick marks for visibility
plt.yticks(rotation=0)
plt.xticks(rotation=90)

plt.show()
```

## Customizing Heatmap

```python
# Create the crosstab DataFrame
pd_crosstab = pd.crosstab(df["Group"], df["YEAR"])

# Plot a heatmap of the table with no color bar and using the BuGn palette
sns.heatmap(pd_crosstab, cbar=False, cmap="BuGn", linewidths= 0.3)

# Rotate tick marks for visibility
plt.yticks(rotation=0)
plt.xticks(rotation=90)

#Show the plot
plt.show()
plt.clf()
```
