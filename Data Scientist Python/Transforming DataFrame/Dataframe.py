# Print the head of the homelessness data
print(homelessness.head())

# Print information about homelessness
print(homelessness.info())

# Print the shape of homelessness
print(homelessness.shape)

# Print a description of homelessness
print(homelessness.describe())

'''
                   region       state  individuals  family_members  state_pop
    0  East South Central     Alabama       2570.0           864.0    4887681
    1             Pacific      Alaska       1434.0           582.0     735139
    2            Mountain     Arizona       7259.0          2606.0    7158024
    3  West South Central    Arkansas       2280.0           432.0    3009733
    4             Pacific  California     109008.0         20964.0   39461588
    <class 'pandas.core.frame.DataFrame'>
    Int64Index: 51 entries, 0 to 50
    Data columns (total 5 columns):
     #   Column          Non-Null Count  Dtype  
    ---  ------          --------------  -----  
     0   region          51 non-null     object 
     1   state           51 non-null     object 
     2   individuals     51 non-null     float64
     3   family_members  51 non-null     float64
     4   state_pop       51 non-null     int64  
    dtypes: float64(2), int64(1), object(2)
    memory usage: 2.4+ KB
    None
    (51, 5)
           individuals  family_members  state_pop
    count       51.000          51.000  5.100e+01
    mean      7225.784        3504.882  6.406e+06
    std      15991.025        7805.412  7.327e+06
    min        434.000          75.000  5.776e+05
    25%       1446.500         592.000  1.777e+06
    50%       3082.000        1482.000  4.461e+06
    75%       6781.500        3196.000  7.341e+06
    max     109008.000       52070.000  3.946e+0
'''

'''Parts of a DataFrame
To better understand DataFrame objects, it's useful to know that they consist of three components, stored as attributes:

.values: A two-dimensional NumPy array of values.
.columns: An index of columns: the column names.
.index: An index for the rows: either row numbers or row names.'''

# Import pandas using the alias pd
import pandas as pd

# Print the values of homelessness
print(homelessness.values)

# Print the column index of homelessness
print(homelessness.columns)

# Print the row index of homelessness
print(homelessness.index)


'''Index(['region', 'state', 'individuals', 'family_members', 'state_pop'], dtype='object')
    Int64Index([0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48,
                49, 50],
               dtype='int64')
'''

-------------------------------------------------------------


# Sort homelessness by region, then descending family members
homelessness_reg_fam = homelessness.sort_values(['region','family_members'],ascending =[True,False])

# Print the top few rows
print(homelessness_reg_fam.head())

-------------------------------------------------------------

# Filter for rows where individuals is greater than 10000
ind_gt_10k = homelessness[homelessness["individuals"]>10000]

# See the result
print(ind_gt_10k)
-------------------------------------------------------------


# Filter for rows where region is Mountain
mountain_reg = homelessness[homelessness["region"]=="Mountain"]

# See the result
print(mountain_reg)

-------------------------------------------------------------


# Filter for rows where family_members is less than 1000 
# and region is Pacific
fam_lt_1k_pac = homelessness[(homelessness["family_members"]<1000) & (homelessness["region"]=="Pacific")]

# See the result
print(fam_lt_1k_pac)
-------------------------------------------------------------


# Subset for rows in South Atlantic or Mid-Atlantic regions
south_mid_atlantic = homelessness[homelessness["region"].isin(["South Atlantic","Mid-Atlantic"]) ]

# See the result
print(south_mid_atlantic)

-------------------------------------------------------------
# The Mojave Desert states
canu = ["California", "Arizona", "Nevada", "Utah"]

# Filter for rows in the Mojave Desert states
mojave_homelessness = homelessness[homelessness["state"].isin(canu)]

# See the result
print(mojave_homelessness)
--------------------------------------------------------------------


# Add total col as sum of individuals and family_members
homelessness["total"] = homelessness["individuals"]+homelessness["family_members"]

# Add p_individuals col as proportion of total that are individuals
homelessness["p_individuals"] = homelessness["individuals"]/homelessness["total"] 

# See the result
print(homelessness)
-----------------------------------------------------------------


# Create indiv_per_10k col as homeless individuals per 10k state pop
homelessness["indiv_per_10k"] = 10000 * homelessness["individuals"] / homelessness["state_pop"]  

# Subset rows for indiv_per_10k greater than 20
high_homelessness = homelessness[homelessness["indiv_per_10k"]>20]

# Sort high_homelessness by descending indiv_per_10k
high_homelessness_srt = high_homelessness.sort_values("indiv_per_10k",ascending=False)

# From high_homelessness_srt, select the state and indiv_per_10k cols
result = high_homelessness_srt[["state","indiv_per_10k"]]

# See the result
print(result)




















