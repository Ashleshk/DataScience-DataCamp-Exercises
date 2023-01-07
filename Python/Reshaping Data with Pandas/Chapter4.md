## Advanced Reshaping

```
Obesity
                               perc_obesity
country   biological_sex year              
Argentina Male           2005          21.5
          Female         2005          24.2
          Male           2015          26.8
          Female         2015          28.5
Japan     Male           2005           2.5
          Female         2005           2.6
          Male           2015           4.6
          Female         2015           3.6
Norway    Male           2005          17.6
          Female         2005          18.6
          Male           2015          23.0
          Female         2015          22.2
```


1. Reshape the obesity DataFrame by unstacking the first level, then get the mean value of the columns.

```py
# Unstack the first level and calculate the mean of the columns
obesity_general = obesity.unstack(level=0).mean(axis=1)

# Print obesity_general
print(obesity_general)
```

```
   biological_sex  year
    Female          2005    15.133
                    2015    18.100
    Male            2005    13.867
                    2015    18.133
    dtype: float64
```

2. Define an obesity_mean DataFrame by unstacking the second level of obesity and getting the mean value for the columns.

```py
# Unstack the second level and calculate the mean of the columns
obesity_mean = obesity.unstack(level=1).mean(axis=1)

# Print obesity_mean
print(obesity_mean)
```


```
  country    year
    Argentina  2005    22.85
               2015    27.65
    Japan      2005     2.55
               2015     4.10
    Norway     2005    18.10
               2015    22.60
    dtype: float64
```

3. Lastly, unstack the third level of the obesity DataFrame, then get the difference between the columns using .diff().


```py
# Unstack the third level and calculate the difference between columns
obesity_variation = obesity.unstack(level=2).diff(axis=1,periods =1)

# Print obesity_variation
print(obesity_variation)
```

```
                             perc_obesity     
    year                             2005 2015
    country   biological_sex                  
    Argentina Female                  NaN  4.3
              Male                    NaN  5.3
    Japan     Female                  NaN  1.0
              Male                    NaN  2.1
    Norway    Female                  NaN  3.6
              Male                    NaN  5.4
```

--------------------------------------------------------------------------------------------------

1. Stack the obesity DataFrame, get the median value of the columns, and finally, unstack it again.

```py
# Stack obesity, get median of columns and unstack again
median_obesity = obesity.stack().median(axis=1).unstack()

# Print median_obesity
print(median_obesity)
```

```
                            perc_obesity  variation
    country biological_sex                         
    France  Female                  18.1        8.2
            Male                    16.9        8.4
    Germany Female                  17.2        5.2
            Male                    18.7        5.9
```

2. Stack obesity by the first level, get the sum of the columns, and finally, unstack the DataFrame by the second level.

```py
# Stack the first level, get sum, and unstack the second level
obesity_sum = obesity.stack(level=0).sum(axis=1).unstack(level=1)

# Print obesity_max
print(obesity_sum)
```

```
    biological_sex  Female  Male
    country year                
    France  1995      23.0  20.4
            2005      26.3  25.3
            2015      32.1  33.3
    Germany 1995      19.0  19.5
            2005      22.4  24.6
            2015      28.5  33.4
```



## Groupby 

1. Stack the country level of obesity, group it by country, and take the mean of all the columns.

```py
# Stack country level, group by country and get the mean
obesity_mean = obesity.stack(level='country').groupby(level='country').mean()

# Print obesity_mean
print(obesity_mean)
```

```
               perc_obesity
    country                
    Argentina        23.000
    Brazil           16.733
    France           17.567
```




2. Stack the country level of obesity, group by country, and take the median of all the columns.


```py
# Stack country level, group by country and get the median 
obesity_median = obesity.stack(level='country').groupby(level='country').median()

# Print obesity_median
print(obesity_median)
```

```
               perc_obesity
    country                
    Argentina         22.85
    Brazil            16.65
    France            17.50
```



-------------------------------------------------------------------------------------------------

# Explode method in pandas

```
     country  perc_obesity        bounds
0  Argentina          21.5  [15.4, 31.5]
1    Germany          22.3  [16.2, 32.4]
2      Japan           2.5    [1.1, 3.5]
3     Norway          23.0  [13.1, 33.0]
```

```py
# Explode the values of bounds to a separate row
obesity_bounds = obesity['bounds'].explode()

# Merge obesity_bounds with country and perc_obesity columns of obesity using the indexes
obesity_final = obesity[['country', 'perc_obesity']].merge(obesity_bounds, 
                                        right_index=True, 
                                        left_index=True)

# Print obesity_final
print(obesity_final)
```

```
        country  perc_obesity bounds
    0  Argentina          21.5   15.4
    0  Argentina          21.5   31.5
    1    Germany          22.3   16.2
    1    Germany          22.3   32.4
    2      Japan           2.5    1.1
    2      Japan           2.5    3.5
    3     Norway          23.0   13.1
    3     Norway          23.0   33.0

```

1. Transform the list-like column bounds in the DataFrame obesity to get its elements in different rows.
    * Modify the resulting DataFrame by resetting the index, dropping the old one.

```py
# Transform the list-like column named bounds  
obesity_explode = obesity.explode('bounds')

# Modify obesity_explode by resetting the index 
obesity_explode.reset_index(drop=True, inplace=True)

# Print obesity_explode
print(obesity_explode)
```

```
        country  perc_obesity bounds
    0  Argentina          21.5   15.4
    1  Argentina          21.5   31.5
    2    Germany          22.3   16.2
    3    Germany          22.3   32.4
    4      Japan           2.5    1.1
    5      Japan           2.5    3.5
    6     Norway          23.0   13.1
    7     Norway          23.0   33.0
```


## Split and Explode

```
        country  perc_obesity     bounds
0        France          14.5  11.4-25.5
1        Mexico          25.3  16.2-32.4
2         Spain          12.5   8.1-16.5
3  South Africa          11.3   9.1-20.1
```

* Split the strings contained in the column bounds, using a hyphen as the delimiter.
* Now, assign the result of splitting the bounds column to the bounds column of obesity .
* Transform the list-like column bounds in the resulting DataFrame to get its elements in different rows.

```py
# Transform the column bounds in the obesity DataFrame
obesity_split = obesity.assign(bounds=obesity['bounds'].str.split('-')).explode('bounds')

# Print obesity_split
print(obesity_split)
```

```
            country  perc_obesity bounds
    0        France          14.5   11.4
    0        France          14.5   25.5
    1        Mexico          25.3   16.2
    1        Mexico          25.3   32.4
    2         Spain          12.5    8.1
    2         Spain          12.5   16.5
    3  South Africa          11.3    9.1
    3  South Africa          11.3   20.1
```


## Reading nested data into a DataFrame

* Import the json_normalize() function from pandas.
* Normalize the JSON contained in movies. Separate the names generated from nested records with an underscore.
* Reshape the resulting movies_norm DataFrame from wide to long format, using the director and producer columns as unique indexes. Name the new variable created from the columns movies, starting with features, separated by an underscore with a suffix containing words.


```
[{'director': 'Woody Allen',
  'producer': 'Letty Aronson',
  'features': {'title': 'Magic in the Moonlight', 'year': 2014}},
 {'director': 'Niki Caro',
  'producer': 'Jason Reed',
  'features': {'title': 'Mulan', 'year': 2020}}]
```

```py
# Import the json_normalize function
from pandas import json_normalize

# Normalize movies and separate the new columns with an underscore 
movies_norm = pd.json_normalize(movies, sep='_')

# Reshape using director and producer as index, create movies from column starting from features
movies_long = pd.wide_to_long(movies_norm, stubnames=['features'], 
                      i=['director','producer'], j='movies', 
                      sep='_', suffix='\w+')

# Print movies_long
print(movies_long)
```


```
                                                   features
    director    producer      movies                        
    Woody Allen Letty Aronson title   Magic in the Moonlight
                              year                      2014
    Niki Caro   Jason Reed    title                    Mulan
                              year                      2020
```


## Complex JSON

```
In [1]:
movies
Out[1]:

[{'director': 'Woody Allen',
  'producer': 'Letty Aronson',
  'features': [{'title': 'Magic in the Moonlight', 'year': 2014},
   {'title': 'Vicky Cristina Barcelona', 'year': 2008},
   {'title': 'Midnight in Paris', 'year': 2011}]},
 {'director': 'Niki Caro',
  'producer': 'Jason Reed',
  'features': [{'title': 'Mulan', 'year': 2020}]}]
```

```py
# Specify director and producer to use as metadata for each record 
normalize_movies = json_normalize(movies, 
                                  record_path='features', 
                                  meta=['director', 'producer'])

# Print normalize_movies
print(normalize_movies)
```

```
                          title  year     director       producer
    0    Magic in the Moonlight  2014  Woody Allen  Letty Aronson
    1  Vicky Cristina Barcelona  2008  Woody Allen  Letty Aronson
    2         Midnight in Paris  2011  Woody Allen  Letty Aronson
    3                     Mulan  2020    Niki Caro     Jason Reed
```



## Dealing with nested data columns

```
              names                                         bird_facts
0          Killdeer  {"Size" : "Large", "Color": "Golden brown", "B...
1  Chipping Sparrow  {"Size":"Small", "Color": "Gray-white", "Behav...
2     Cedar Waxwing  {"Size":"Small", "Color": "Gray-brown", "Behav...
```

```py
# Define birds reading names and bird_facts lists into names and bird_facts columns
birds = pd.DataFrame(dict(names=names, bird_facts=bird_facts))

# Apply to bird_facts column the function loads from json module
data_split = birds['bird_facts'].apply(json.loads).apply(pd.Series)

# Remove the bird_facts column from birds
birds = birds.drop(columns='bird_facts')

# Concatenate the columns of birds and data_split
birds = pd.concat([birds,data_split ], axis=1)

# Print birds
print(birds)
```


```
<script.py> output:
                  names   Size         Color                       Behavior         Habitat
    0          Killdeer  Large  Golden brown      Runs swiftly along ground     Rocky areas
    1  Chipping Sparrow  Small    Gray-white                Often in flocks  Open woodlands
    2     Cedar Waxwing  Small    Gray-brown  Catch insects over open water           Parks
```


## Dumping nested data


```
<bound method IndexOpsMixin.tolist of 0    {'Size': 'Large', 'Color': 'Golden brown', 'Be...
    1    {'Size': 'Small', 'Color': 'Gray-white', 'Beha...
    2    {'Size': 'Small', 'Color': 'Gray-brown', 'Beha...
    Name: bird_facts, dtype: object>
```

```py
# Apply json.loads to the bird_facts column and transform it to a list 
birds_facts = birds['bird_facts'].apply(json.loads).to_list()

# Convert birds_fact into a JSON 
birds_dump = json.dumps(birds_facts)

# Read the JSON birds_dump into a DataFrame
birds_df = pd.read_json(birds_dump)

# Concatenate the 'names' column of birds with birds_df 
birds_final = pd.concat([birds['names'], birds_df], axis=1)

# Print birds_final
print(birds_final)
```

```
<script.py> output:
                  names   Size         Color                       Behavior         Habitat
    0          Killdeer  Large  Golden brown      Runs swiftly along ground     Rocky areas
    1  Chipping Sparrow  Small    Gray-white                Often in flocks  Open woodlands
    2     Cedar Waxwing  Small    Gray-brown  Catch insects over open water           Parks
```














