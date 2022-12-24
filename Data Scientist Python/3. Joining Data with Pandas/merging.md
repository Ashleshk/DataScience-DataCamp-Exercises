## Your first inner join

```python
# Merge the taxi_owners and taxi_veh tables
taxi_own_veh = taxi_owners.merge(taxi_veh,on="vid")

# Print the column names of the taxi_own_veh
print(taxi_own_veh.columns)
```

### Set the left and right table suffixes for overlapping columns of the merge to _own and _veh, respectively.

```python
# Merge the taxi_owners and taxi_veh tables setting a suffix
taxi_own_veh = taxi_owners.merge(taxi_veh, on='vid', suffixes=('_own','_veh'))

# Print the column names of taxi_own_veh
print(taxi_own_veh.columns)
```

```python
# Merge the taxi_owners and taxi_veh tables setting a suffix
taxi_own_veh = taxi_owners.merge(taxi_veh, on='vid', suffixes=('_own','_veh'))

# Print the value_counts to find the most popular fuel_type
print(taxi_own_veh['fuel_type'].value_counts())
```

## Inner joins and number of rows returned

1. Merge wards and census on the ward column and save the result to wards_census.

```python
# Merge the wards and census tables on the ward column
wards_census = wards.merge(census, on='ward')

# Print the shape of wards_census
print('wards_census table shape:', wards_census.shape)
```

2. Merge the wards_altered and census tables on the ward column, and notice the difference in returned rows.

```python
# Print the first few rows of the wards_altered table to view the change 
print(wards_altered[['ward']].head())

# Merge the wards_altered and census tables on the ward column
wards_altered_census = wards_altered.merge(census, on='ward')

# Print the shape of wards_altered_census
print('wards_altered_census table shape:', wards_altered_census.shape)
```

3. Merge the wards and census_altered tables on the ward column, and notice the difference in returned rows.

```python
# Print the first few rows of the census_altered table to view the change 
print(census_altered[['ward']].head())

# Merge the wards and census_altered tables on the ward column
wards_census_altered = wards.merge(census_altered, on="ward")

# Print the shape of wards_census_altered
print('wards_census_altered table shape:', wards_census_altered.shape)
```

## One-to-many merge

```python
# Merge the licenses and biz_owners table on account
licenses_owners = licenses.merge(biz_owners, on="account")

# Group the results by title then count the number of accounts
counted_df = licenses_owners.groupby("title").agg({'account':'count'})

# Sort the counted_df in desending order
sorted_df = counted_df.sort_values("account", ascending=False)

# Use .head() method to print the first few rows of sorted_df
print(sorted_df.head())
```

## Total riders in a month
```python
# Merge the ridership, cal, and stations tables
ridership_cal_stations = ridership.merge(cal, on=['year','month','day']) \
							.merge(stations, on='station_id')

# Create a filter to filter ridership_cal_stations
filter_criteria = ((ridership_cal_stations['month'] == 7) 
                   & (ridership_cal_stations['day_type'] == 'Weekday') 
                   & (ridership_cal_stations['station_name'] == 'Wilson'))

# Use .loc and the filter to select for rides
print(ridership_cal_stations.loc[filter_criteria, 'rides'].sum())
```


## Three table merge
```python
# Merge licenses and zip_demo, on zip; and merge the wards on ward
licenses_zip_ward = licenses.merge(zip_demo, on ="zip") \
            			.merge(wards, on= "ward")

# Print the results by alderman and show median income
print(licenses_zip_ward.groupby("alderman").agg({'income':'median'}))
```'''
<script.py> output:
                                 income
    alderman                           
    Ameya Pawar                 66246.0
    Anthony A. Beale            38206.0
    Anthony V. Napolitano       82226.0
    Ariel E. Reyboras           41307.0
    Brendan Reilly             110215.0
    Brian Hopkins               87143.0
    Carlos Ramirez-Rosa         66246.0
    Carrie M. Austin            38206.0
    Chris Taliaferro            55566.0
    Daniel "Danny" Solis        41226.0
'''


## One-to-many merge with multiple tables

```python
# Merge land_use and census and merge result with licenses including suffixes
land_cen_lic = land_use.merge(census, on='ward') \
                    .merge(licenses, on='ward', suffixes=('_cen','_lic'))

# Group by ward, pop_2010, and vacant, then count the # of accounts
pop_vac_lic = land_cen_lic.groupby(['ward','pop_2010','vacant'], 
                                   as_index=False).agg({'account':'count'})

# Sort pop_vac_lic and print the results
sorted_pop_vac_lic = pop_vac_lic.sort_values(["vacant","account","pop_2010"], 
                                             ascending=[False,True,True])

# Print the top few rows of sorted_pop_vac_lic
print(sorted_pop_vac_lic.head())
```


## Counting missing rows with left join

```python
# Merge the movies table with the financials table with a left join
movies_financials = movies.merge(financials, on='id', how='left')

# Count the number of rows in the budget column that are missing
number_of_missing_fin = movies_financials['budget'].isnull().sum()

# Print the number of movies missing financials
print(number_of_missing_fin)
```

## Enriching a dataset

```python
# Merge the toy_story and taglines tables with a inner join
toystory_tag = toy_story.merge(taglines, on="id")

# Print the rows and shape of toystory_tag
print(toystory_tag)
print(toystory_tag.shape)
```


## Right join to find unique movies
```python
# Merge action_movies to the scifi_movies with right join
action_scifi = action_movies.merge(scifi_movies, on='movie_id', how='right',
                                   suffixes=('_act','_sci'))

# From action_scifi, select only the rows where the genre_act column is null
scifi_only = action_scifi[action_scifi['genre_act'].isnull()]

# Merge the movies and scifi_only tables with an inner join
movies_and_scifi_only = movies.merge(scifi_only, how='inner',
left_on='id', right_on='movie_id')

# Print the first few rows and shape of movies_and_scifi_only
print(movies_and_scifi_only.head())
print(movies_and_scifi_only.shape)

```
# Popular genres with right join

```python
# Use right join to merge the movie_to_genres and pop_movies tables
genres_movies = movie_to_genres.merge(pop_movies, how='right', 
                                      left_on="movie_id", 
                                      right_on='id')

# Count the number of genres
genre_count = genres_movies.groupby('genre').agg({'id':'count'})

# Plot a bar chart of the genre_count
genre_count.plot(kind='bar')
plt.show()
```

## Using outer join to select actors


```python
# Merge iron_1_actors to iron_2_actors on id with outer join using suffixes
iron_1_and_2 = iron_1_actors.merge(iron_2_actors,
                                     how="outer",
                                     on="id",
                                     suffixes= ['_1','_2'])

# Create an index that returns true if name_1 or name_2 are null
m = ((iron_1_and_2['name_1'].isnull()) | 
     (iron_1_and_2['name_2'].isnull()))

# Print the first few rows of iron_1_and_2
print(iron_1_and_2[m].head())
```
```
                      character_1      id           name_1 character_2 name_2
    0                       Yinsen   17857       Shaun Toub         NaN    NaN
    2  Obadiah Stane / Iron Monger    1229     Jeff Bridges         NaN    NaN
    3                  War Machine   18288  Terrence Howard         NaN    NaN
    5                         Raza   57452      Faran Tahir         NaN    NaN
    8                   Abu Bakaar  173810    Sayed Badreya         NaN    NaN
```

## Self join
```python
# Merge the crews table to itself
crews_self_merged = crews.merge(crews, on='id', how='inner',
                                suffixes=('_dir','_crew'))

# Create a boolean index to select the appropriate rows
boolean_filter = ((crews_self_merged['job_dir'] == 'Director') & 
                  (crews_self_merged['job_crew'] != 'Director'))
direct_crews = crews_self_merged[boolean_filter]

# Print the first few rows of direct_crews
print(direct_crews.head())
```

```output
<script.py> output:
            id   job_dir       name_dir        job_crew          name_crew
    156  19995  Director  James Cameron          Editor  Stephen E. Rivkin
    157  19995  Director  James Cameron  Sound Designer  Christopher Boyes
    158  19995  Director  James Cameron         Casting          Mali Finn
    160  19995  Director  James Cameron          Writer      James Cameron
    161  19995  Director  James Cameron    Set Designer    Richard F. Mays
```

## Merging on Indexes 
Index merge for movie ratings
```python
# Merge to the movies table the ratings table on the index
movies_ratings = movies.merge(ratings,on='id', how='left')

# Print the first few rows of movies_ratings
print(movies_ratings.head())
```

```output
<script.py> output:
                          title  popularity release_date  vote_average  vote_count
    id                                                                            
    257            Oliver Twist      20.416   2005-09-23           6.7       274.0
    14290  Better Luck Tomorrow       3.877   2002-01-12           6.5        27.0
    38365             Grown Ups      38.864   2010-06-24           6.0      1705.0
    9672               Infamous       3.681   2006-11-16           6.4        60.0
    12819       Alpha and Omega      12.301   2010-09-17           5.3       124.0
```


# Do sequels earn more?

```python
# Merge sequels and financials on index id
sequels_fin = sequels.merge(financials, on='id', how='left')

# Self merge with suffixes as inner join with left on sequel and right on id
orig_seq = sequels_fin.merge(sequels_fin, how='inner', left_on='sequel', 
                             right_on='id', right_index=True,
                             suffixes=('_org','_seq'))

# Add calculation to subtract revenue_org from revenue_seq 
orig_seq['diff'] = orig_seq['revenue_seq'] - orig_seq['revenue_org']

# Select the title_org, title_seq, and diff 
titles_diff = orig_seq[['title_org','title_seq','diff']]

# Print the first rows of the sorted titles_diff
print(titles_diff.sort_values('diff',ascending=False ).head())
```

```
<script.py> output:
                   title_org        title_seq       diff
    id                                                  
    331    Jurassic Park III   Jurassic World  1.145e+09
    272        Batman Begins  The Dark Knight  6.303e+08
    10138         Iron Man 2       Iron Man 3  5.915e+08
    863          Toy Story 2      Toy Story 3  5.696e+08
    10764  Quantum of Solace          Skyfall  5.225e+08
```

## Performing an anti join
```python
# Merge employees and top_cust
empl_cust = employees.merge(top_cust, on='srid', 
                                 how='left', indicator=True)

# Select the srid column where _merge is left_only
srid_list = empl_cust.loc[empl_cust['_merge'] == 'left_only', 'srid']

# Get employees not working with top customers
print(employees[employees['srid'].isin(srid_list)])
```










