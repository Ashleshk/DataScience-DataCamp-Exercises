# Visual exploratory data analysis

```py
# Calculate the overall arrest rate
print(ri.is_arrested.mean())

# Calculate the hourly arrest rate
print(ri.groupby(ri.index.hour).is_arrested.mean())

# Save the hourly arrest rate
hourly_arrest_rate = ri.groupby(ri.index.hour).is_arrested.mean()
```
```
0.03798111837327524
stop_datetime
0     0.051167
1     0.071615
2     0.071176
3     0.060958
4     0.044776
5     0.021583
6     0.010758
7     0.013923
8     0.021392
9     0.026438
10    0.030878
11    0.031412
12    0.037538
13    0.032431
14    0.033486
15    0.035254
16    0.039700
17    0.044135
18    0.043171
19    0.037390
20    0.037500
21    0.069507
22    0.054536
23    0.047776
Name: is_arrested, dtype: float64
```
## Plotting the hourly arrest rate
```py
# Import matplotlib.pyplot as plt
import matplotlib.pyplot as plt

# Create a line plot of 'hourly_arrest_rate'
plt.plot(hourly_arrest_rate)

# Add the xlabel, ylabel, and title
plt.xlabel('Hour')
plt.ylabel('Arrest Rate')
plt.title('Arrest Rate by Time of Day')

# Display the plot
plt.show()
   ```  


## Are drug-related stops on the rise?

```py
# Calculate the annual rate of drug-related stops
print(ri.drugs_related_stop.resample('A').mean())

# Save the annual rate of drug-related stops
annual_drug_rate = ri.drugs_related_stop.resample('A').mean()

# Create a line plot of 'annual_drug_rate'
annual_drug_rate.plot()

# Display the plot
plt.show()
```
```
stop_datetime
2005-12-31    0.006501
2006-12-31    0.007258
2007-12-31    0.007970
2008-12-31    0.007505
2009-12-31    0.009889
2010-12-31    0.010081
2011-12-31    0.009731
2012-12-31    0.009577
Freq: A-DEC, Name: drugs_related_stop, dtype: float64
```

## Comparing drug and search rates

```py
# Calculate and save the annual search rate
annual_search_rate = ri.search_conducted.resample('A').mean()

# Concatenate 'annual_drug_rate' and 'annual_search_rate'
annual = pd.concat([annual_drug_rate, annual_search_rate], axis=1)

# Create subplots from 'annual'
annual.plot(subplots=True)

# Display the subplots
plt.show()
```

## Tallying violations by district

```py
# Create a frequency table of districts and violations
print(pd.crosstab(ri.district, ri.violation))

# Save the frequency table as 'all_zones'
all_zones = pd.crosstab(ri.district, ri.violation)

# Select rows 'Zone K1' through 'Zone K3'
print(all_zones.loc['Zone K1':'Zone K3'])

# Save the smaller table as 'k_zones'
k_zones = all_zones.loc['Zone K1':'Zone K3']
 ```

 ```    
violation  Equipment  Moving violation  Other  Registration/plates  Speeding
district                                                                    
Zone               0                 0      0                    0         1
Zone K1          660              1226    288                  119      5887
Zone K2          640              1571    720                  371      6439
Zone K3         1057              1506    541                  357      8401
Zone X1          144               436     90                   11       800
Zone X3          839              1749    542                  328      6078
Zone X4         1879              3476   1152                  906      6866
violation  Equipment  Moving violation  Other  Registration/plates  Speeding
district                                                                    
Zone K1          660              1226    288                  119      5887
Zone K2          640              1571    720                  371      6439
Zone K3         1057              1506    541                  357      8401
```

## Plotting violations by district

```py
# Create a bar plot of 'k_zones'
k_zones.plot(kind='bar')

# Display the plot
plt.show()
     


# Create a stacked bar plot of 'k_zones'
k_zones.plot(kind='bar', stacked=True)

# Display the plot
plt.show()
```

## How long might you be stopped for a violation?

```py
# Print the unique values in 'stop_duration'
print(ri.stop_duration.unique())

# Create a dictionary that maps strings to integers
mapping = {'0-15 Min': 8, '16-30 Min': 23, '30+ Min': 45}

# Convert the 'stop_duration' strings to integers using the 'mapping'
ri['stop_minutes'] = ri.stop_duration.map(mapping)

# Print the unique values in 'stop_minutes'
print(ri.stop_minutes.unique())
```
```
['0-15 Min' '16-30 Min' '30+ Min']
[ 8 23 45]
```
## Plotting stop length

```py
# Calculate the mean 'stop_minutes' for each value in 'violation_raw'
print(ri.groupby('violation_raw').stop_minutes.mean())

# Save the resulting Series as 'stop_length'
stop_length = ri.groupby('violation_raw').stop_minutes.mean()

# Sort 'stop_length' by its values and create a horizontal bar plot
stop_length.sort_values().plot(kind='barh')

# Display the plot
plt.show()
```
```     
violation_raw
APB                                 21.000000
Call for Service                    25.145408
Equipment/Inspection Violation      13.053075
Motorist Assist/Courtesy            18.351562
Other Traffic Violation             15.581995
Registration Violation              16.239962
Special Detail/Directed Patrol      15.180479
Speeding                            10.976677
Suspicious Person                   15.861111
Violation of City/Town Ordinance    14.169014
Warrant                             27.545455
Name: stop_minutes, dtype: float64
```

