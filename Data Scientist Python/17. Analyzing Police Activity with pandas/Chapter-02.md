# Exploring the relationship between gender and policing



## Examining Traffic violations

```py
# Count the unique values in 'violation'
print(ri.violation.value_counts())

# Express the counts as proportions
print(ri.violation.value_counts(normalize=True))
```
```  
Speeding               34472
Moving violation        9964
Equipment               5219
Other                   3333
Registration/plates     2092
Name: violation, dtype: int64
Speeding               0.625853
Moving violation       0.180901
Equipment              0.094753
Other                  0.060512
Registration/plates    0.037981
Name: violation, dtype: float64
```
## Comparing violations by gender

```py
# Create a DataFrame of female drivers
female = ri[ri['driver_gender'] == 'F']

# Create a DataFrame of male drivers
male = ri[ri['driver_gender'] == 'M']

# Compute the violations by female drivers (as proportions)
print(female.violation.value_counts(normalize=True))

# Compute the violations by male drivers (as proportions)
print(male.violation.value_counts(normalize=True))
```
```     
Speeding               0.735711
Moving violation       0.120243
Equipment              0.075569
Registration/plates    0.039217
Other                  0.029259
Name: violation, dtype: float64
Speeding               0.586001
Moving violation       0.202905
Equipment              0.101712
Other                  0.071849
Registration/plates    0.037533
Name: violation, dtype: float64
```

## Logical Operators 

```py
# Create a DataFrame of female drivers stopped for speeding
female_and_speeding = ri[(ri['driver_gender'] == 'F') & (ri['violation'] == 'Speeding')]

# Create a DataFrame of male drivers stopped for speeding
male_and_speeding = ri[(ri['driver_gender'] == 'M') & (ri['violation'] == 'Speeding')]

# Compute the stop outcomes for female drivers (as proportions)
print(female_and_speeding.stop_outcome.value_counts(normalize=True))

# Compute the stop outcomes for male drivers (as proportions)
print(male_and_speeding.stop_outcome.value_counts(normalize=True))
```
```     
Citation            0.975712
Warning             0.015203
Arrest Driver       0.006953
N/D                 0.001298
Arrest Passenger    0.000649
No Action           0.000185
Name: stop_outcome, dtype: float64
Citation            0.963057
Arrest Driver       0.018450
Warning             0.015242
Arrest Passenger    0.001267
N/D                 0.001140
No Action           0.000844
Name: stop_outcome, dtype: float64
```
## Does gender affect whose vehicle is searched?
```py
# Check the data type of 'search_conducted'
print(ri.search_conducted.dtype)

# Calculate the search rate by counting the values
print(ri.search_conducted.value_counts(normalize=True))

# Calculate the search rate by taking the mean
print(ri.search_conducted.mean())
``` 
```    
bool
False    0.957298
True     0.042702
Name: search_conducted, dtype: float64
0.042701525054466234
```

## Group by Analysis

```py
# Calculate the search rate for female drivers
print(ri[ri['driver_gender'] == 'F'].search_conducted.mean())
     
0.0219615332151139

# Calculate the search rate for male drivers
print(ri[ri['driver_gender'] == 'M'].search_conducted.mean())
     
0.05022514721163838

# Calculate the search rate for both groups simultaneously
print(ri.groupby('driver_gender').search_conducted.mean())
```
```     
driver_gender
F    0.021962
M    0.050225
Name: search_conducted, dtype: float64
```
## Adding a second factor to the analysis

```py
# Calculate the search rate for each combination of gender and violation
print(ri.groupby(['driver_gender', 'violation']).search_conducted.mean())
```
```     
driver_gender  violation          
F              Equipment              0.065884
               Moving violation       0.045377
               Other                  0.053613
               Registration/plates    0.080000
               Speeding               0.009270
M              Equipment              0.099246
               Moving violation       0.065724
               Other                  0.047865
               Registration/plates    0.143705
               Speeding               0.030652
Name: search_conducted, dtype: float64
```
```py
# Reverse the ordering to group by violation before gender
print(ri.groupby(['violation', 'driver_gender']).search_conducted.mean())
```
```    
violation            driver_gender
Equipment            F                0.065884
                     M                0.099246
Moving violation     F                0.045377
                     M                0.065724
Other                F                0.053613
                     M                0.047865
Registration/plates  F                0.080000
                     M                0.143705
Speeding             F                0.009270
                     M                0.030652
Name: search_conducted, dtype: float64
```

## Does gender affect who is frisked during a search?

```py
# Count the 'search_type' values
print(ri.search_type.value_counts())

# Check if 'search_type' contains the string 'Protective Frisk'
ri['frisk'] = ri.search_type.str.contains('Protective Frisk', na=False)

# Check the data type of 'frisk'
print(ri.frisk.dtype)

# Take the sum of 'frisk'
print(ri.frisk.sum())
```

```
Incident to Arrest                                          1026
Probable Cause                                               526
Reasonable Suspicion                                         158
Inventory                                                    140
Protective Frisk                                             130
Incident to Arrest,Inventory                                  95
Incident to Arrest,Probable Cause                             72
Incident to Arrest,Protective Frisk                           32
Probable Cause,Reasonable Suspicion                           27
Probable Cause,Protective Frisk                               26
Incident to Arrest,Inventory,Probable Cause                   25
Incident to Arrest,Inventory,Protective Frisk                 18
Protective Frisk,Reasonable Suspicion                         16
Inventory,Probable Cause                                      14
Inventory,Protective Frisk                                    12
Incident to Arrest,Probable Cause,Protective Frisk            11
Incident to Arrest,Reasonable Suspicion                        6
Probable Cause,Protective Frisk,Reasonable Suspicion           5
Incident to Arrest,Probable Cause,Reasonable Suspicion         4
Incident to Arrest,Inventory,Reasonable Suspicion              3
Incident to Arrest,Protective Frisk,Reasonable Suspicion       2
Inventory,Protective Frisk,Reasonable Suspicion                1
Inventory,Probable Cause,Protective Frisk                      1
Inventory,Probable Cause,Reasonable Suspicion                  1
Inventory,Reasonable Suspicion                                 1
Name: search_type, dtype: int64
bool
254
```

## Comparing frisk rates by gender
```py
# Create a DataFrame of stops in which a search was conducted
searched = ri[ri.search_conducted == True]

# Calculate the overall frisk rate by taking the mean of 'frisk'
print(searched.frisk.mean())

# Calculate the frisk rate for each gender
print(searched.groupby('driver_gender').frisk.mean())
```
```    
0.10799319727891156
driver_gender
F    0.077640
M    0.112808
Name: frisk, dtype: float64
```
