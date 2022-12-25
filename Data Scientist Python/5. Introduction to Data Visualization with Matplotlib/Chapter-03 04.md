## Bar chart

```python
fig, ax = plt.subplots()

# Plot a bar-chart of gold medals as a function of country
ax.bar(medals.index, medals["Gold"])

# Set the x-axis tick labels to the country names
ax.set_xticklabels(medals.index, rotation =90)

# Set the y-axis label
ax.set_ylabel("Number of medals")

plt.show()
```

## Stacked Bar Chart

```python
# Add bars for "Gold" with the label "Gold"
ax.bar(medals.index, medals["Gold"], label="Gold")

# Stack bars for "Silver" on top with label "Silver"
ax.bar(medals.index, medals["Silver"], bottom=medals["Gold"], label="Silver")

# Stack bars for "Bronze" on top of that with label "Bronze"
ax.bar(medals.index, medals["Bronze"], bottom=medals["Gold"] + medals["Silver"],label="Bronze")

# Display the legend
ax.legend()

plt.show()
```

## histogram

```python
fig, ax = plt.subplots()
# Plot a histogram of "Weight" for mens_rowing
ax.hist(mens_rowing["Weight"] )

# Compare to histogram of "Weight" for mens_gymnastics
ax.hist(mens_gymnastics["Weight"]  )

# Set the x-axis label to "Weight (kg)"
 
ax.set_xlabel("Weight (kg)")
ax.set_ylabel("# of observations")
# Set the y-axis label to "# of observations"
 

plt.show()
```

## Custom Histogram

```python
fig, ax = plt.subplots()

# Plot a histogram of "Weight" for mens_rowing
ax.hist(mens_rowing["Weight"],label="Rowing",bins=5,histtype="step")

# Compare to histogram of "Weight" for mens_gymnastics
ax.hist(mens_gymnastics["Weight"],label="Gymnastics",bins=5,histtype="step")

ax.set_xlabel("Weight (kg)")
ax.set_ylabel("# of observations")

# Add the legend and show the Figure
ax.legend()
plt.show()
```



## Adding error-bars to a bar chart

```python
fig, ax = plt.subplots()

# Add a bar for the rowing "Height" column mean/std
ax.bar("Rowing", mens_rowing["Height"].mean(), yerr=mens_rowing["Height"].std())

# Add a bar for the gymnastics "Height" column mean/std
ax.bar("Gymnastics",mens_gymnastics["Height"].mean(),yerr=mens_gymnastics["Height"].std())

# Label the y-axis
ax.set_ylabel("Height (cm)")

plt.show()
```


## Adding error-bars to plots

```python
fig, ax = plt.subplots()

# Add Seattle temperature data in each month with error bars
ax.errorbar(seattle_weather["MONTH"],seattle_weather["MLY-TAVG-NORMAL"],yerr=seattle_weather["MLY-TAVG-STDDEV"])

ax.errorbar(austin_weather["MONTH"],austin_weather["MLY-TAVG-NORMAL"],yerr=austin_weather["MLY-TAVG-STDDEV"])

ax.set_ylabel("Temperature (Fahrenheit)")

plt.show()
```


## Box-Plots 

```python
fig, ax = plt.subplots()

# Add a boxplot for the "Height" column in the DataFrames
ax.boxplot([mens_rowing["Height"], mens_gymnastics["Height"]])
ax.set_xticklabels(["Rowing", "Gymnastics"])
ax.set_ylabel("Height (cm)")

plt.show()
```


## Scatter Plot

```python
fig, ax = plt.subplots()

# Add data: "co2" on x-axis, "relative_temp" on y-axis
ax.scatter(climate_change["co2"], climate_change["relative_temp"])
ax.set_xlabel("CO2 (ppm)")
ax.set_ylabel("Relative temperature (C)")
plt.show()

plt.show()
```


## Color index in Scatter Plot

```python
fig, ax = plt.subplots()

# Add data: "co2", "relative_temp" as x-y, index as color
fig, ax = plt.subplots()

# Add data: "co2" on x-axis, "relative_temp" on y-axis
ax.scatter(climate_change["co2"], climate_change["relative_temp"], c=climate_change.index)
ax.set_xlabel("CO2 (ppm)")
ax.set_ylabel("Relative temperature (C)")
plt.show()

```
## Saving Plots --Different file formats
```python
fig.savefig("gold_medals.jpg")
fig.savefig("gold_medals.jpg", quality=50)
fig.savefig("gold_medals.svg").
fig.savefig("gold_medals.png", dpi=300)

fig.set_size_inches([5, 3])
```
---------------------------------------------------------------------------------------

## Unique Values of a column

```python
# Extract the "Sport" column
sports_column = summer_2016_medals["Sport"]

# Find the unique values of the "Sport" column
sports = summer_2016_medals["Sport"].unique()

# Print out the unique sports values
print(sports)
```


## Automate your visualization

```python
fig, ax = plt.subplots()

# Loop over the different sports branches
for sport in sports:
  # Extract the rows only for this sport
  sport_df = summer_2016_medals[summer_2016_medals["Sport"] == sport]
  # Add a bar for the "Weight" mean with std y error bar
  ax.bar(sport, sport_df["Weight"].mean(),
yerr=sport_df["Weight"].std())

ax.set_ylabel("Weight")
ax.set_xticklabels(sports, rotation=90)

# Save the figure to file
fig.savefig("sports_weights.png")

```










