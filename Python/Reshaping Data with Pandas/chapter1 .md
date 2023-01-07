## Reshaping Data 

```python
# Change the DataFrame so rows become columns and vice versa
fifa_transpose = fifa_players.set_index('name')[['height', 'weight']].transpose()

# Print fifa_transpose
print(fifa_transpose)
```

## Dribbling the pivot method

1. Pivot fifa_players to get a DataFrame with overall scores indexed by name, and identified by movement in the columns.

```py
# Pivot fifa_players to get overall scores indexed by name and identified by movement
fifa_overall = fifa_players.pivot(index='name', columns='movement', values='overall')

# Print fifa_overall
print(fifa_overall)
```

2. Pivot fifa_players to get a DataFrame with attacking scores indexed by name, and identified by movement in the columns.

```py
# Pivot fifa_players to get attacking scores indexed by name and identified by movement
fifa_attacking = fifa_players.pivot(index='name', columns='movement', values='attacking')
 
# Print fifa_attacking
print(fifa_attacking)
```

3. Use .pivot() on fifa_players to get overall scores indexed by movement, and identified by name in the columns.

```py
# Use the pivot method to get overall scores indexed by movement and identified by name
fifa_names = fifa_players.pivot(index='movement', columns='name', values ='overall')

# Print fifa_names
print(fifa_names)
```


## Offensive or defensive player?
1. Pivot fifa_players to get overall and attacking scores indexed by name, and identified by movement in the columns.

```py
# Pivot fifa_players to get overall and attacking scores indexed by name and identified by movement
fifa_over_attack = fifa_players.pivot(index='name', columns='movement', values=['overall','attacking' ])

# Print fifa_over_attack
print(fifa_over_attack)

# Use pivot method to get all the scores index by name and identified by movement
fifa_all = fifa_players.pivot(index='name', columns='movement')

# Print fifa_over_attack
print(fifa_all)
```

## Dropping Duplicate in other form

```py
# Drop the fifth row to delete all repeated rows
fifa_no_rep = fifa_players.drop(4, axis=0)

# Pivot fifa players to get all scores by name and movement
fifa_pivot = fifa_no_rep.pivot(index='name',columns='movement') 

# Print fifa_pivot
print(fifa_pivot)  
```



## Another Better method ------- USING PIVOT_TABLE

```py
# Discard the fifth row to delete all repeated rows
fifa_drop = fifa_players.drop(4,axis=0)

# Use pivot method to get all scores by name and movement
fifa_pivot = fifa_drop.pivot(index='name',columns='movement') 

# Print fifa_pivot
print(fifa_pivot)  

# Use pivot table to get all scores by name and movement
fifa_pivot_table = fifa_players.pivot_table(index='name', 
                                     columns='movement', 
                                     aggfunc='mean')
# Print fifa_pivot_table
print(fifa_pivot_table)
```


## Exploring the big match

1. Use a pivot table to show the mean age of players in fifa_players by club and nationality. Set nationality as the index.

```py
# Use pivot table to display mean age of players by club and nationality 
mean_age_fifa = fifa_players.pivot_table(index='nationality', 
                                  columns='club', 
                                  values='age', 
                                  aggfunc='mean')

# Print mean_age_fifa
print(mean_age_fifa)
```


2. Use a pivot table to show the maximum height of any player by club and nationality, setting nationality as the index.

```py
# Use pivot table to display max height of any player by club and nationality
tall_players_fifa = fifa_players.pivot_table(index='nationality', 
                                     columns='club', 
                                      values='height', 
                                      aggfunc='max')

# Print tall_players_fifa
print(tall_players_fifa)
```


3. 
```py
# Use pivot table to show the count of players by club and nationality and the total count
players_country = fifa_players.pivot_table(index='nationality', 
                                    columns='club', 
                                    values='name', 
                                    aggfunc='count', 
                                    margins=True)

# Print players_country
print(players_country)
```


## The tallest and the heaviest

```py
# Define a pivot table to get the characteristic by nationality and club
fifa_mean = fifa_players.pivot_table(index=['nationality', 'club'], 
                                     columns='year')

# Print fifa_mean
print(fifa_mean)
```

```py
# Set the appropriate argument to show the maximum values
fifa_mean = fifa_players.pivot_table(index=['nationality', 'club'], 
                                     columns='year', 
                                     aggfunc='max')

# Print fifa_mean
print(fifa_mean)
```


```py
# Set the argument to get the maximum for each row and column
fifa_mean = fifa_players.pivot_table(index=['nationality', 'club'], 
                                     columns='year', 
                                     aggfunc='max', 
                                     margins=True)

# Print fifa_mean
print(fifa_mean)
```








