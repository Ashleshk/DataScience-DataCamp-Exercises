# Analyzing the effect of weather on policing

```py
# Read 'weather.csv' into a DataFrame named 'weather'
weather = pd.read_csv('weather.csv')

# Describe the temperature columns
print(weather[['TMIN', 'TAVG', 'TMAX']].describe())

# Create a box plot of the temperature columns
weather[['TMIN', 'TAVG', 'TMAX']].plot(kind='box')

# Display the plot
plt.show()
```
```    
              TMIN         TAVG         TMAX
count  4017.000000  1217.000000  4017.000000
mean     43.484441    52.493016    61.268608
std      17.020298    17.830714    18.199517
min      -5.000000     6.000000    15.000000
25%      30.000000    39.000000    47.000000
50%      44.000000    54.000000    62.000000
75%      58.000000    68.000000    77.000000
max      77.000000    86.000000   102.000000
/usr/local/lib/python3.7/dist-packages/numpy/core/_asarray.py:83: VisibleDeprecationWarning: Creating an ndarray from ragged nested sequences (which is a list-or-tuple of lists-or-tuples-or ndarrays with different lengths or shapes) is deprecated. If you meant to do this, you must specify 'dtype=object' when creating the ndarray
  return array(a, dtype, copy=False, order=order)
```

```py
# Create a 'TDIFF' column that represents temperature difference
weather['TDIFF'] = weather['TMAX'] - weather['TMIN']

# Describe the 'TDIFF' column
print(weather['TDIFF'].describe())

# Create a histogram with 20 bins to visualize 'TDIFF'
weather['TDIFF'].plot(kind='hist', bins=20)

# Display the plot
plt.show()
```

```
count    4017.000000
mean       17.784167
std         6.350720
min         2.000000
25%        14.000000
50%        18.000000
75%        22.000000
max        43.000000
Name: TDIFF, dtype: float64
```

```py
# Copy 'WT01' through 'WT22' to a new DataFrame
WT = weather.loc[:, 'WT01':'WT22']

# Calculate the sum of each row in 'WT'
weather['bad_conditions'] = WT.sum(axis=1)

# Replace missing values in 'bad_conditions' with '0'
weather['bad_conditions'] = weather.bad_conditions.fillna(0).astype('int')

# Create a histogram to visualize 'bad_conditions'
weather['bad_conditions'].plot(kind='hist')

# Display the plot
plt.show()
```

## Rating the weather conditions

```py
# Count the unique values in 'bad_conditions' and sort the index
print(weather.bad_conditions.value_counts().sort_index())

# Create a dictionary that maps integers to strings
mapping = {0:'good', 1:'bad', 2:'bad', 3: 'bad', 4: 'bad', 5: 'worse', 6: 'worse', 7: 'worse', 8: 'worse', 9: 'worse'}

# Convert the 'bad_conditions' integers to strings using the 'mapping'
weather['rating'] = weather.bad_conditions.map(mapping)

# Count the unique values in 'rating'
print(weather['rating'].value_counts())
```
```     
0    1749
1     613
2     367
3     380
4     476
5     282
6     101
7      41
8       4
9       4
Name: bad_conditions, dtype: int64
bad      1836
good     1749
worse     432
Name: rating, dtype: int64
```

```py
# Create a list of weather ratings in logical order
cats = ['good', 'bad', 'worse']

# Change the data type of 'rating' to category
#weather['rating'] = weather.rating.astype('category', ordered=True, categories=cats)
weather['rating'] = weather.rating.astype('category')

# Examine the head of 'rating'
print(weather['rating'].head())
```
```     
0    bad
1    bad
2    bad
3    bad
4    bad
Name: rating, dtype: category
Categories (3, object): ['bad', 'good', 'worse']
```

## Preparing the DataFrames

```py
# Reset the index of 'ri'
ri.reset_index(inplace=True)

# Examine the head of 'ri'
print(ri.head())

# Create a DataFrame from the 'DATE' and 'rating' columns
weather_rating = weather[['DATE', 'rating']]

# Examine the head of 'weather_rating'
print(weather_rating.head())
 ```
```    
        stop_datetime   stop_date stop_time  ... district  frisk stop_minutes
0 2005-01-04 12:55:00  2005-01-04     12:55  ...  Zone X4  False            8
1 2005-01-23 23:15:00  2005-01-23     23:15  ...  Zone K3  False            8
2 2005-02-17 04:15:00  2005-02-17     04:15  ...  Zone X4  False            8
3 2005-02-20 17:15:00  2005-02-20     17:15  ...  Zone X1  False           23
4 2005-02-24 01:20:00  2005-02-24     01:20  ...  Zone X3  False            8

[5 rows x 16 columns]
         DATE rating
0  2005-01-01    bad
1  2005-01-02    bad
2  2005-01-03    bad
3  2005-01-04    bad
4  2005-01-05    bad
```

```py
# Examine the shape of 'ri'
print(ri.shape)

# Merge 'ri' and 'weather_rating' using a left join
ri_weather = pd.merge(left=ri, right=weather_rating, left_on='stop_date', right_on='DATE', how='inner')

# Examine the shape of 'ri_weather'
print(ri_weather.shape)

# Set 'stop_datetime' as the index of 'ri_weather'
ri_weather.set_index('stop_datetime', inplace=True)
```
```
(55080, 16)
(55080, 18)
```

```py
# Calculate the overall arrest rate
print(ri_weather.is_arrested.mean())
     
0.03798111837327524

# Calculate the arrest rate for each 'rating'
print(ri_weather.groupby('rating').is_arrested.mean())
```
```     
rating
bad      0.039244
good     0.035243
worse    0.041754
Name: is_arrested, dtype: float64
```

```py
# Calculate the arrest rate for each 'violation' and 'rating'
print(ri_weather.groupby(['violation', 'rating']).is_arrested.mean())
```
```     
violation            rating
Equipment            bad       0.083234
                     good      0.072745
                     worse     0.098431
Moving violation     bad       0.063387
                     good      0.057625
                     worse     0.066306
Other                bad       0.090783
                     good      0.062948
                     worse     0.062992
Registration/plates  bad       0.125385
                     good      0.120497
                     worse     0.117834
Speeding             bad       0.015328
                     good      0.016327
                     worse     0.016755
Name: is_arrested, dtype: float64
```
## Selecting from a multi-indexed Series

```py
# Save the output of the groupby operation from the last exercise
arrest_rate = ri_weather.groupby(['violation', 'rating']).is_arrested.mean()

# Print the 'arrest_rate' Series
print(arrest_rate)

# Print the arrest rate for moving violations in bad weather
print(arrest_rate.loc['Moving violation', 'bad'])

# Print the arrest rates for speeding violations in all three weather conditions
print(arrest_rate.loc['Speeding'])
```
```     
violation            rating
Equipment            bad       0.083234
                     good      0.072745
                     worse     0.098431
Moving violation     bad       0.063387
                     good      0.057625
                     worse     0.066306
Other                bad       0.090783
                     good      0.062948
                     worse     0.062992
Registration/plates  bad       0.125385
                     good      0.120497
                     worse     0.117834
Speeding             bad       0.015328
                     good      0.016327
                     worse     0.016755
Name: is_arrested, dtype: float64
0.06338652482269504
rating
bad      0.015328
good     0.016327
worse    0.016755
Name: is_arrested, dtype: float64
```

## Reshaping the arrest rate data

```py
# Unstack the 'arrest_rate' Series into a DataFrame
print(arrest_rate.unstack())

# Create the same DataFrame using a pivot table
print(ri_weather.pivot_table(index='violation', columns='rating', values='is_arrested'))
```
```     
rating                    bad      good     worse
violation                                        
Equipment            0.083234  0.072745  0.098431
Moving violation     0.063387  0.057625  0.066306
Other                0.090783  0.062948  0.062992
Registration/plates  0.125385  0.120497  0.117834
Speeding             0.015328  0.016327  0.016755
rating                    bad      good     worse
violation                                        
Equipment            0.083234  0.072745  0.098431
Moving violation     0.063387  0.057625  0.066306
Other                0.090783  0.062948  0.062992
Registration/plates  0.125385  0.120497  0.117834
Speeding             0.015328  0.016327  0.016755


