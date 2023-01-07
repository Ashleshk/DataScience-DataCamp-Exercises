# Record Linkage

1. Similarity and Score

Partial strings and different orderings
* 
```py
# Partial string comparison
fuzz.WRatio('Houston Rockets', 'Rockets')
90
# Partial string comparison with different order
fuzz.WRatio('Houston Rockets vs Los Angeles Lakers', 'Lakers vs Rockets')
86
```

## Collapsing all of the state

```py
# For each correct category
for state in categories['state']:
# Find potential matches in states with typoes
matches = process.extract(state, survey['state'], limit = survey.shape[0])
# For each potential match match
for potential_match in matches:
# If high similarity score
if potential_match[1] >= 80:
# Replace typo with correct category
survey.loc[survey['state'] == potential_match[0], 'state'] = state
```

## Ex-2 The Cutoff Point

```py
# Import process from thefuzz
from thefuzz import process

# Store the unique values of cuisine_type in unique_types
unique_types = restaurants['cuisine_type'].unique()

# Calculate similarity of 'asian' to all values of unique_types
print(process.extract('asian', unique_types, limit = len(unique_types)))

# Calculate similarity of 'american' to all values of unique_types
print(process.extract('american', unique_types, limit = len(unique_types)))

# Calculate similarity of 'italian' to all values of unique_types
print(process.extract('italian', unique_types, limit = len(unique_types)))
```


## Remapping categories II

```py
print(restaurants['cuisine_type'].unique())

# Create a list of matches, comparing 'italian' with the cuisine_type column
matches = process.extract('italian', restaurants['cuisine_type'], limit = len(restaurants['cuisine_type']))

# Inspect the first 5 matches
print(matches[0:5])


# Create a list of matches, comparing 'italian' with the cuisine_type column
matches = process.extract('italian', restaurants['cuisine_type'], limit=len(restaurants.cuisine_type))

# Iterate through the list of matches to italian
for match in matches:
  # Check whether the similarity score is greater than or equal to 80
  if match[1] >= 80:
    # Select all rows where the cuisine_type is spelled this way, and set them to the correct cuisine
    restaurants.loc[restaurants['cuisine_type'] == match[0]] = 'italian'
```
* Finally, you'll adapt your code to work with every restaurant type in categories.

* Using the variable cuisine to iterate through categories, embed your code from the previous step in an outer for loop.
* Inspect the final result. This has been done for you.

```py
# Iterate through categories
for cuisine in categories:  
  # Create a list of matches, comparing cuisine with the cuisine_type column
  matches = process.extract(cuisine, restaurants['cuisine_type'], limit=len(restaurants.cuisine_type))

  # Iterate through the list of matches
  for match in matches:
     # Check whether the similarity score is greater than or equal to 80
    if match[1] >= 80:
      # If it is, select all rows where the cuisine_type is spelled this way, and set them to the correct cuisine
      restaurants.loc[restaurants['cuisine_type'] == match[0]] = cuisine
      
# Inspect the final result
print(restaurants['cuisine_type'].unique())
```


## Record Linkage

### 1. Generating pairs
```py
# Import recordlinkage
import recordlinkage
# Create indexing object
indexer = recordlinkage.Index()
# Generate pairs blocked on state
indexer.block('state')
pairs = indexer.index(census_A, census_B)
```

### 2. Comparing the DataFrames
```py
# Generate the pairs
pairs = indexer.index(census_A, census_B)
# Create a Compare object
compare_cl = recordlinkage.Compare()
# Find exact matches for pairs of date_of_birth and state
compare_cl.exact('date_of_birth', 'date_of_birth', label='date_of_birth')
compare_cl.exact('state', 'state', label='state')
# Find similar matches for pairs of surname and address_1 using string similarity
compare_cl.string('surname', 'surname', threshold=0.85, label='surname')
compare_cl.string('address_1', 'address_1', threshold=0.85, label='address_1')
# Find matches
potential_matches = compare_cl.compute(pairs, census_A, census_B)
```


--------------------------------------------------------------------------------

## Ex-2 Pairs of restaurants

```py
# Create an indexer and object and find possible pairs
indexer = recordlinkage.Index()

# Block pairing on cuisine_type
indexer.block('cuisine_type')

# Generate pairs
pairs = indexer.index(restaurants, restaurants_new)
```

* Similar restaurants

```py
# Create a comparison object
comp_cl = recordlinkage.Compare()

# Find exact matches on city, cuisine_types - 
comp_cl.exact('city', 'city', label='city')
comp_cl.exact('cuisine_type', 'cuisine_type', label='cuisine_type')

# Find similar matches of rest_name
comp_cl.string('rest_name', 'rest_name', label='name', threshold = 0.8) 

# Get potential matches and print
potential_matches = comp_cl.compute(pairs, restaurants, restaurants_new)
print(potential_matches)
```

------------------------------------------------------------------------------------------

### 3. Linking 

```py
# Import recordlinkage and generate pairs and compare across columns
...
# Generate potential matches
potential_matches = compare_cl.compute(full_pairs, census_A, census_B)
# Isolate matches with matching values for 3 or more columns
matches = potential_matches[potential_matches.sum(axis = 1) >= 3]
# Get index for matching census_B rows only
duplicate_rows = matches.index.get_level_values(1)
# Finding new rows in census_B
census_B_new = census_B[~census_B.index.isin(duplicate_rows)]
# Link the DataFrames!
full_census = census_A.append(census_B_new)
```

```py
# Isolate potential matches with row sum >=3
matches = potential_matches[potential_matches.sum(axis = 1) >= 3]

# Get values of second column index of matches
matching_indices = matches.index.get_level_values(1)

# Subset restaurants_new based on non-duplicate values
non_dup = restaurants_new[~restaurants_new.index.isin(matching_indices)]

# Append non_dup to restaurants
full_restaurants = restaurants.append(non_dup)
print(full_restaurants)
```