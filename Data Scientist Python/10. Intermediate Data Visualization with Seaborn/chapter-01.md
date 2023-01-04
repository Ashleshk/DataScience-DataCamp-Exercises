## Comparing a histogram and displot

```python
# Display pandas histogram
df['Award_Amount'].plot.hist()
plt.show()

# Clear out the pandas histogram
plt.clf()

# Display a Seaborn displot
sns.displot(df['Award_Amount'])
plt.show()

# Clear the displot
plt.clf()
```


## Plotting Histogram

```python
# Create a displot
sns.displot(df['Award_Amount'],
             bins=20)

# Display the plot
plt.show()
```

## displot of the Award Amount

```python
# Create a displot of the Award Amount
sns.displot(df['Award_Amount'],
             kind='kde',
             rug=True,
             fill=True)

# Plot the results
plt.show()
```

## Create a regression plot

```python
# Create a regression plot of premiums vs. insurance_losses
sns.regplot(data=df, x="insurance_losses", y="premiums" )

# Display the plot
plt.show()

# Create an lmplot of premiums vs. insurance_losses
sns.lmplot(data=df, x="insurance_losses", y="premiums")

# Display the second plot
plt.show()
```

## Plotting multiple variables
```python
# Create a regression plot using hue
sns.lmplot(data=df,
           x="insurance_losses",
           y="premiums",
           hue="Region")

# Show the results
plt.show()
```

## Plotting Multiple variables

```python
# Create a regression plot with multiple rows
sns.lmplot(data=df,
           x="insurance_losses",
           y="premiums",
           row="Region")

# Show the plot
plt.show()
```

## Seaborn Styles

```python
# Plot the pandas histogram
df['fmr_2'].plot.hist()
plt.show()
plt.clf()

# Set the default seaborn style
sns.set()

# Plot the pandas histogram again
df['fmr_2'].plot.hist()
plt.show()
plt.clf()
```


## Comapring Styles

```python
sns.set_style('dark')
sns.displot(df['fmr_2'])
plt.show()

plt.clf()

sns.set_style('whitegrid')
sns.displot(df['fmr_2'])
plt.show()

plt.clf()
```

## Removing spines

```python
# Set the style to white
sns.set_style('white')

# Create a regression plot
sns.lmplot(data=df,
           x='pop2010',
           y='fmr_2')

# Remove the spines
sns.despine()

# Show the plot and clear the figure
plt.show()
plt.clf()
```







































