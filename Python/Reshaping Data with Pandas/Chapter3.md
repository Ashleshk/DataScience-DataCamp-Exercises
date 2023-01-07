## The .stack() method

```py
# Predefined list to use as index
new_index = [['California', 'California', 'New York', 'Ohio'], 
             ['Los Angeles', 'San Francisco', 'New York', 'Cleveland']]

# Create a multi-level index using predefined new_index
churn_new = pd.MultiIndex.from_arrays(new_index, names=['state', 'city'])

# Assign the new index to the churn index
churn.index = churn_new

# Reshape by stacking churn DataFrame
churn_stack = churn.stack()

# Print churn_stack
print(churn_stack)
```

```
<script.py> output:
    state       city                            
    California  Los Angeles    Area code            408
                               total_day_calls      116
                               total_day_minutes    204
                San Francisco  Area code            408
                               total_day_calls      109
                               total_day_minutes    287
    New York    New York       Area code            415
                               total_day_calls       84
                               total_day_minutes     84
    Ohio        Cleveland      Area code            510
                               total_day_calls       67
                               total_day_minutes     50
    dtype: int64
```

## Phone directory index

```
                               night                       day              
                         total calls total minutes total calls total minutes
state      city                                                             
California Los Angeles           116           204          85           107
           San Francisco         109           287          90           167
New York   New York               84            84          75            90
Ohio       Cleveland              67            50          67           110
```

```py
# Set state and city as index modifying the DataFrame
churn.set_index(['state', 'city'], inplace=True)

# Reshape by stacking the second level
churn_stack = churn.stack(level=1)

# Print churn_stack
print(churn_stack)
```

```
                                            day  night
    state      city                                   
    California Los Angeles   total calls     85    116
                             total minutes  107    204
               San Francisco total calls     90    109
                             total minutes  167    287
    New York   New York      total calls     75     84
                             total minutes   90     84
    Ohio       Cleveland     total calls     67     67
                             total minutes  110     50
```


1. Reshape the churn DataFrame by stacking the time column level. Assign the reshaped DataFrame to churn_time.

```py
# Stack churn by the time column level
churn_time = churn.stack(level='time')

# Print churn_time
print(churn_time)
```

```
    feature                         text messages  total GB
    state      city          time                          
    California Los Angeles   day               20         5
                             night             30        10
               San Francisco day               40         5
                             night            100         5
    New York   New York      day               50         2
                             night             20         9
    Ohio       Cleveland     day              100         3
                             night             40         6
```

2. Now, define a reshaped DataFrame called churn_feature by stacking the feature column level of the churn DataFrame.

```py
# Stack churn by the feature column level
churn_feature = churn.stack(level='feature')

# Print churn_feature
print(churn_feature)
```

```
    time                                    day  night
    state      city          feature                  
    California Los Angeles   text messages   20     30
                             total GB         5     10
               San Francisco text messages   40    100
                             total GB         5      5
    New York   New York      text messages   50     20
                             total GB         2      9
    Ohio       Cleveland     text messages  100     40
                             total GB         3      6
```




## Unstacking

```
                              minutes  calls  charge
time  type          exited                          
day   International churn       184.5     97   31.37
      National      churn       129.1    137   21.95
night International churn       332.9     67   56.59
      National      no churn    110.4    103   18.77
eve   International no churn    119.3    117   20.28
      National      no churn    137.1     88   23.31
```

```py
# Reshape the churn DataFrame by unstacking
churn_unstack = churn.unstack()

# Print churn_unstack
print(churn_unstack)
```

```
                    minutes           calls          charge         
    exited                churn no churn  churn no churn  churn no churn
    time  type                                                          
    day   International   184.5      NaN   97.0      NaN  31.37      NaN
          National        129.1      NaN  137.0      NaN  21.95      NaN
    eve   International     NaN    119.3    NaN    117.0    NaN    20.28
          National          NaN    137.1    NaN     88.0    NaN    23.31
    night International   332.9      NaN   67.0      NaN  56.59      NaN
          National          NaN    110.4    NaN    103.0    NaN    18.77
```

* Create a reshaped DataFrame called churn_first by unstacking the first row level of churn.

```py
# Reshape churn by unstacking the first row level
churn_first = churn.unstack(level=0)

# Print churn_zero
print(churn_first)
```

```
                           minutes                calls               charge              
    time                       day    eve  night    day    eve  night    day    eve  night
    type          exited                                                                  
    International churn      184.5    NaN  332.9   97.0    NaN   67.0  31.37    NaN  56.59
                  no churn     NaN  119.3    NaN    NaN  117.0    NaN    NaN  20.28    NaN
    National      churn      129.1    NaN    NaN  137.0    NaN    NaN  21.95    NaN    NaN
                  no churn     NaN  137.1  110.4    NaN   88.0  103.0    NaN  23.31  18.77
```

```py
# Reshape churn by unstacking the second row level
churn_second = churn.unstack(level=1)

# Print churn_second
print(churn_second)
```

```                        minutes                  calls                 charge         
    type           International National International National International National
    time  exited                                                                       
    day   churn            184.5    129.1          97.0    137.0         31.37    21.95
    eve   no churn         119.3    137.1         117.0     88.0         20.28    23.31
    night churn            332.9      NaN          67.0      NaN         56.59      NaN
          no churn           NaN    110.4           NaN    103.0           NaN    18.77
```


2. Reshape the churn DataFrame by unstacking the time level. Assign it to churn_time.

```py
# Unstack the time level from churn
churn_time = churn.unstack(level='time')

# Print churn_time
print(churn_time)
```

```
                           minutes                calls               charge              
    time                       day    eve  night    day    eve  night    day    eve  night
    type          exited                                                                  
    International churn      184.5    NaN  332.9   97.0    NaN   67.0  31.37    NaN  56.59
                  no churn     NaN  119.3    NaN    NaN  117.0    NaN    NaN  20.28    NaN
    National      churn      129.1    NaN    NaN  137.0    NaN    NaN  21.95    NaN    NaN
                  no churn     NaN  137.1  110.4    NaN   88.0  103.0    NaN  23.31  18.77
```

```py
# Sort the index in descending order
churn_time = churn.unstack(level='time').sort_index(ascending=False)

# Print churn_time
print(churn_time)
```

```
                           minutes                calls               charge              
    time                       day    eve  night    day    eve  night    day    eve  night
    type          exited                                                                  
    National      no churn     NaN  137.1  110.4    NaN   88.0  103.0    NaN  23.31  18.77
                  churn      129.1    NaN    NaN  137.0    NaN    NaN  21.95    NaN    NaN
    International no churn     NaN  119.3    NaN    NaN  117.0    NaN    NaN  20.28    NaN
                  churn      184.5    NaN  332.9   97.0    NaN   67.0  31.37    NaN  56.59
```


## Organizing your voicemail

```py
# Unstack churn by type level
churn_type = churn.unstack(level='type')

# Stack the resulting DataFrame using the first column level
churn_final = churn_type.stack(level=0)

# Print churn_type
print(churn_final)
```

```
    type                    International  National
    time  exited                                   
    day   churn    calls            97.00    137.00
                   charge           31.37     21.95
                   minutes         184.50    129.10
    eve   no churn calls           117.00     88.00
                   charge           20.28     23.31
                   minutes         119.30    137.10
    night churn    calls            67.00       NaN
                   charge           56.59       NaN
                   minutes         332.90       NaN
          no churn calls              NaN    103.00
                   charge             NaN     18.77
                   minutes            NaN    110.40
```










