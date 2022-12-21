# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Print out country column as Pandas Series
print(cars['country'])

# Print out country column as Pandas DataFrame
print(cars[['country']])

# Print out DataFrame with country and drives_right columns
print(cars[['country','drives_right']])


'''<script.py> output:
    US     United States
    AUS        Australia
    JPN            Japan
    IN             India
    RU            Russia
    MOR          Morocco
    EG             Egypt
    Name: country, dtype: object
               country
    US   United States
    AUS      Australia
    JPN          Japan
    IN           India
    RU          Russia
    MOR        Morocco
    EG           Egypt
               country  drives_right
    US   United States          True
    AUS      Australia         False
    JPN          Japan         False
    IN           India         False
    RU          Russia          True
    MOR        Morocco          True
    EG           Egypt          True
'''

# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Print out drives_right value of Morocco
print(cars.loc['MOR','drives_right'])

# Print sub-DataFrame
print(cars.loc[['RU','MOR'],['country','drives_right']])
'''
<script.py> output:
    True
         country  drives_right
    RU    Russia          True
    MOR  Morocco          True
'''


#########################################################
###  LOC 

# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Print out drives_right column as Series
print(cars.loc[:,'drives_right'])

# Print out drives_right column as DataFrame
print(cars.loc[:,['drives_right']])

# Print out cars_per_cap and drives_right as DataFrame
print(cars.loc[:,['cars_per_cap','drives_right']])


'''<script.py> output:
    US      True
    AUS    False
    JPN    False
    IN     False
    RU      True
    MOR     True
    EG      True
    Name: drives_right, dtype: bool
         drives_right
    US           True
    AUS         False
    JPN         False
    IN          False
    RU           True
    MOR          True
    EG           True
         cars_per_cap  drives_right
    US            809          True
    AUS           731         False
    JPN           588         False
    IN             18         False
    RU            200          True
    MOR            70          True
    EG             45          True'''


##################################################
##   Camaparision Operators
# Create arrays
import numpy as np
my_house = np.array([18.0, 20.0, 10.75, 9.50])
your_house = np.array([14.0, 24.0, 14.25, 9.0])

# my_house greater than 18.5 or smaller than 10
print(np.logical_or(my_house>18.5 , my_house <10))

# Both my_house and your_house smaller than 11
print(np.logical_and(my_house<11 , your_house<11))



''' #2 '''

# Import cars data
import pandas as pd
cars = pd.read_csv('cars.csv', index_col = 0)

# Import numpy, you'll need this
import numpy as np

# Create medium: observations with cars_per_cap between 100 and 500

cpc = cars['cars_per_cap']
between = np.logical_and(cpc > 10, cpc < 80)
medium = cars[between]


# Print medium
print(medium)



















