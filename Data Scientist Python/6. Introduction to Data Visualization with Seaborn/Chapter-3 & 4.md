## Count plots

1. Use sns.catplot() to create a count plot using the survey_data DataFrame with "Internet usage" on the x-axis.
```python
# Create count plot of internet usage
sns.catplot(x="Internet usage",
data=survey_data,
kind="count")

# Show plot
plt.show()
```
2. Make the bars horizontal instead of vertical.
```python
# Change the orientation of the plot
sns.catplot( 
y="Internet usage", data=survey_data,
            kind="count")

# Show plot
plt.show()
```


3. Separate this plot into two side-by-side column subplots based on "Age Category", which separates respondents into those that are younger than 21 vs. 21 and older.

```python
# Separate into column subplots based on age category
sns.catplot(y="Internet usage", 
col="Age Category",data=survey_data,
            kind="count")

# Show plot
plt.show()
```

## Bar Plot

```python
# Create a bar plot of interest in math, separated by gender
sns.catplot(x="Gender",y="Interested in Math", data=survey_data,
        kind="bar")


# Show plot
plt.show()
```

## Customizing bar plots

```python
# List of categories from lowest to highest
category_order = ["<2 hours", 
                  "2 to 5 hours", 
                  "5 to 10 hours", 
                  ">10 hours"]

# Turn off the confidence intervals
sns.catplot(x="study_time", y="G3",
            data=student_data,
            kind="bar",
            order=category_order,
            ci=None)

# Show plot
plt.show()
```


## Box Plot

```python
# Specify the category ordering
study_time_order = ["<2 hours", "2 to 5 hours", 
                    "5 to 10 hours", ">10 hours"]

# Create a box plot and set the order of the categories

g = sns.catplot(x="study_time",
y="G3",
data=student_data,
kind="box",
order=study_time_order)

# Show plot
plt.show()
```

## Omitting outliers

```python
# Create a box plot with subgroups and omit the outliers
g = sns.catplot(x="internet",
y="G3",
data=student_data,
kind="box",
hue="location",
sym="")

# Show plot
plt.show()
```

## Adjusting the whiskers

```python
# Extend the whiskers to the 5th and 95th percentile
sns.catplot(x="romantic", y="G3",
            data=student_data,
            kind="box",
            whis=0.5)

# Show plot
plt.show()

# Extend the whiskers to the 5th and 95th percentile
sns.catplot(x="romantic", y="G3",
            data=student_data,
            kind="box",
            whis=[5,95])

# Show plot
plt.show()
```

## Customizing point plots

```python
# Remove the lines joining the points
sns.catplot(x="famrel", y="absences",
			data=student_data,
            kind="point",
            capsize=0.2,
            join=False)
            
# Show plot
plt.show()
```


## Point plots with subgroups

```python
# Create a point plot that uses color to create subgroups
 
sns.catplot(x="romantic", y="absences",
			data=student_data,
            kind="point",
            capsize=0.2,
            hue="school",
            join=False)
            
# Show plot
plt.show()

```


## Changing Estimator

```python
# Import median function from numpy
from numpy import median

# Plot the median number of absences instead of the mean
sns.catplot(x="romantic", y="absences",
			data=student_data,
            kind="point",
            hue="school",
            ci=None,
            estimator=median)

# Show plot
plt.show()
```


## Changing style and palette

```python
# Set the color palette to "Purples"
sns.set_style("whitegrid")


# Create a count plot of survey responses
category_order = ["Never", "Rarely", "Sometimes", 
                  "Often", "Always"]

sns.catplot(x="Parents Advice", 
            data=survey_data, 
            kind="count", 
            order=category_order)

# Show plot
plt.show()

# Change the color palette to "RdBu"
sns.set_style("whitegrid")
sns.set_palette("RdBu")

# Create a count plot of survey responses
category_order = ["Never", "Rarely", "Sometimes", 
                  "Often", "Always"]

sns.catplot(x="Parents Advice", 
            data=survey_data, 
            kind="count", 
            order=category_order)

# Show plot
plt.show()
```


## Changing the Scale

```python
# Change the context to "notebook"
sns.set_context("paper")

# Create bar plot
sns.catplot(x="Number of Siblings", y="Feels Lonely",
            data=survey_data, kind="bar")
# Show plot
plt.show()


# Change the context to "poster"
sns.set_context("poster")

# Create bar plot
sns.catplot(x="Number of Siblings", y="Feels Lonely",
            data=survey_data, kind="bar")
# Show plot
plt.show()
```



## Custom Palette
```python
# Set the style to "darkgrid"
sns.set_style(
"darkgrid"
)

# Set a custom color palette
sns.set_palette(
["#39A7D0" , "#36ADA4"]
)

# Create the box plot of age distribution by gender
sns.catplot(x="Gender", y="Age", 
            data=survey_data, kind="box")

# Show plot
plt.show()
```

## Adding a title to a FacetGrid object

```python
# Create scatter plot
g = sns.relplot(x="weight", 
                y="horsepower", 
                data=mpg,
                kind="scatter")

# Add a title "Car Weight vs. Horsepower"
g.fig.suptitle("Car Weight vs. Horsepower")

# Show plot
plt.show()
```

## Adding Axis labels

```python
# Create line plot
g = sns.lineplot(x="model_year", y="mpg_mean", 
                 data=mpg_mean,
                 hue="origin")

# Add a title "Average MPG Over Time"
g.set_title("Average MPG Over Time")

# Add x-axis and y-axis labels
g.set(xlabel="Car Model Year",
ylabel="Average MPG")


# Show plot
plt.show()
```

## Rotation

```python
# Create point plot
sns.catplot(x="origin", 
            y="acceleration", 
            data=mpg, 
            kind="point", 
            join=False, 
            capsize=0.1)

# Rotate x-tick labels
plt.xticks(rotation=90)

# Show plot
plt.show()
```

















