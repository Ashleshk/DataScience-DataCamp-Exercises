
# Chapter 4: Dates and Times in Pandas

## Loading a csv file in Pandas

```py
import pandas as pd

# Load CSV into the rides variable
rides = pd.read_csv('capital-onebike.csv', 
                    parse_dates = ['Start date', 'End date'])

# Print the initial (0th) row
print(rides.iloc[0])
```

## Making timedelta columns

```py
# Subtract the start date from the end date
ride_durations = rides['End date'] - rides['Start date']

# Convert the results to seconds
rides['Duration'] = ride_durations.dt.total_seconds()

print(rides['Duration'].head())
```

## How many joyrides ?

* Create a Pandas Series which is True when Start station and End station are the same, and assign the result to joyrides.
* Calculate the median duration of all rides.
* Calculate the median duration of joyrides.


```py
# Create joyrides
joyrides = (rides['Start station'] == rides['End station'])

# Total number of joyrides
print("{} rides were joyrides".format(joyrides.sum()))

# Median of all rides
print("The median duration overall was {:.2f} seconds"\
      .format(rides['Duration'].median()))

# Median of joyrides
print("The median duration for joyrides was {:.2f} seconds"\
      .format(rides[joyrides]['Duration'].median()))
```



## It's getting cold outside, W20529    

* Resample rides to the daily level, based on the Start date column.
* Plot the .size() of each result.

```py
# Import matplotlib
import matplotlib.pyplot as plt

# Resample rides to daily, take the size, plot the results
rides.resample('D', on = 'Start date')\
  .size()\
  .plot(ylim = [0, 15])

# Show the results
plt.show()
```


* Since the daily time series is so noisy for this one bike, change the resampling to be monthly.
```py
# Import matplotlib
import matplotlib.pyplot as plt

# Resample rides to monthly, take the size, plot the results
rides.resample('M', on = 'Start date')\
  .size()\
  .plot(ylim = [0, 150])

# Show the results
plt.show()
```

## Members vs casual riders over time

* Set monthly_rides to be a resampled version of rides, by month, based on start date.
* Use the method .value_counts() to find out how many Member and Casual rides there were, and divide them by the total number of rides per month.

```py
# Resample rides to be monthly on the basis of Start date
monthly_rides = rides.resample('M', on = 'Start date')['Member type']

# Take the ratio of the .value_counts() over the total number of rides
print(monthly_rides.value_counts() / monthly_rides.size())
```

##  Combining groupby() and resample()

* Complete the .groupby() call to group by 'Member type', and the .resample() call to resample according to 'Start date', by month.
* Print the median Duration for each group.


```py
# Group rides by member type, and resample to the month
grouped = rides.groupby('Member type')\
  .resample('M', on='Start date')

# Print the median duration for each group
print(grouped['Duration'].median())
```

```
   Member type  Start date
    Casual       2017-10-31    1636.0
                 2017-11-30    1159.5
                 2017-12-31     850.0
    Member       2017-10-31     671.0
                 2017-11-30     655.0
                 2017-12-31     387.5
    Name: Duration, dtype: float64
```


## Additional datetime methods in Pandas

### Timezones in Pandas

```py
# Localize the Start date column to America/New_York
rides['Start date'] = rides['Start date'].dt.tz_localize('America/New_York', ambiguous='NaT')

# Print first value
print(rides['Start date'].iloc[0])
```
```
<script.py> output:
    2017-10-01 15:23:25-04:00
```

```py
# Localize the Start date column to America/New_York
rides['Start date'] = rides['Start date'].dt.tz_localize('America/New_York', 
                                						 ambiguous='NaT')

# Print first value
print(rides['Start date'].iloc[0])

# Convert the Start date column to Europe/London
rides['Start date'] = rides['Start date'].dt.tz_convert('Europe/London')

# Print the new value
print(rides['Start date'].iloc[0])
```

```
 2017-10-01 15:23:25-04:00
    2017-10-01 20:23:25+01:00
```
==================================================================================

## How long per weekday?

```py

# Add a column for the weekday of the start of the ride
rides['Ride start weekday'] = rides['Start date'].dt.day_name()

# Print the median trip time per weekday
print(rides.groupby('Ride start weekday')['Duration'].median())
```

```
<script.py> output:
    Ride start weekday
    0    810.5
    1    641.5
    2    585.0
    3    652.0
    4    724.5
    5    462.0
    6    902.5
    Name: Duration, dtype: float64
```


===================================================================================

## How long between rides?


```py
# Shift the index of the end date up one; now subract it from the start date
rides['Time since'] = rides['Start date'] - (rides['End date'].shift(1))

# Move from a timedelta to a number of seconds, which is easier to work with
rides['Time since'] = rides['Time since'].dt.total_seconds()

# Resample to the month
monthly = rides.resample('M', on='Start date')

# Print the average hours between rides each month
print(monthly['Time since'].mean()/(60*60))
```

```
 Start date
    2017-10-31    5.519
    2017-11-30    7.256
    2017-12-31    9.202
    Freq: M, Name: Time since, dtype: float64
```










