# Print the head of the sales DataFrame
print(sales.head())

# Print the info about the sales DataFrame
print(sales.info())

# Print the mean of weekly_sales
print(sales["weekly_sales"].mean())

# Print the median of weekly_sales
print(sales["weekly_sales"].median())


'''<script.py> output:
       store type  department       date  weekly_sales  is_holiday  temperature_c  fuel_price_usd_per_l  unemployment
    0      1    A           1 2010-02-05      24924.50       False          5.728                 0.679         8.106
    1      1    A           1 2010-03-05      21827.90       False          8.056                 0.693         8.106
    2      1    A           1 2010-04-02      57258.43       False         16.817                 0.718         7.808
    3      1    A           1 2010-05-07      17413.94       False         22.528                 0.749         7.808
    4      1    A           1 2010-06-04      17558.09       False         27.050                 0.715         7.808
    <class 'pandas.core.frame.DataFrame'>
    RangeIndex: 10774 entries, 0 to 10773
    Data columns (total 9 columns):
     #   Column                Non-Null Count  Dtype         
    ---  ------                --------------  -----         
     0   store                 10774 non-null  int64         
     1   type                  10774 non-null  object        
     2   department            10774 non-null  int32         
     3   date                  10774 non-null  datetime64[ns]
     4   weekly_sales          10774 non-null  float64       
     5   is_holiday            10774 non-null  bool          
     6   temperature_c         10774 non-null  float64       
     7   fuel_price_usd_per_l  10774 non-null  float64       
     8   unemployment          10774 non-null  float64       
    dtypes: bool(1), datetime64[ns](1), float64(4), int32(1), int64(1), object(1)
    memory usage: 641.9+ KB
    None
    23843.95014850566
    12049.064999999999'''



# Print the maximum of the date column
print(sales["date"].max())

# Print the minimum of the date column
print(sales["date"].min())


'''<script.py> output:
    2012-10-26 00:00:00
    2010-02-05 00:00:00'''


--------------------------------------------------------------------
# A custom IQR function
def iqr(column):
    return column.quantile(0.75) - column.quantile(0.25)
    
# Print IQR of the temperature_c column
print(sales["temperature_c"].agg(iqr))


'''16.583333333333336
'''

-----------------------------------------------------------------

# A custom IQR function
def iqr(column):
    return column.quantile(0.75) - column.quantile(0.25)

# Update to print IQR of temperature_c, fuel_price_usd_per_l, & unemployment
print(sales[["temperature_c", "fuel_price_usd_per_l", "unemployment"]].agg(iqr))



'''
temperature_c           16.583
fuel_price_usd_per_l     0.073
unemployment             0.565
dtype: float64'''

-----------------------------------------------------------------


# Import NumPy and create custom IQR function
import numpy as np
def iqr(column):
    return column.quantile(0.75) - column.quantile(0.25)

# Update to print IQR and median of temperature_c, fuel_price_usd_per_l, & unemployment
print(sales[["temperature_c", "fuel_price_usd_per_l", "unemployment"]].agg([iqr,np.median]))


'''<script.py> output:
            temperature_c  fuel_price_usd_per_l  unemployment
    iqr            16.583                 0.073         0.565
    median         16.967                 0.743         8.099'''

-----------------------------------------------------------------

# Sort sales_1_1 by date
sales_1_1 = sales_1_1.sort_values("date")

# Get the cumulative sum of weekly_sales, add as cum_weekly_sales col
sales_1_1["cum_weekly_sales"] = sales_1_1["weekly_sales"].cumsum()

# Get the cumulative max of weekly_sales, add as cum_max_sales col
sales_1_1["cum_max_sales"] = sales_1_1["weekly_sales"].cummax()

# See the columns you calculated
print(sales_1_1[["date", "weekly_sales", "cum_weekly_sales", "cum_max_sales"]])

'''
<script.py> output:
             date  weekly_sales  cum_weekly_sales  cum_max_sales
    0  2010-02-05      24924.50          24924.50       24924.50
    1  2010-03-05      21827.90          46752.40       24924.50
    2  2010-04-02      57258.43         104010.83       57258.43
    3  2010-05-07      17413.94         121424.77       57258.43
    4  2010-06-04      17558.09         138982.86       57258.43
    5  2010-07-02      16333.14         155316.00       57258.43
    6  2010-08-06      17508.41         172824.41       57258.43
    7  2010-09-03      16241.78         189066.19       57258.43
    8  2010-10-01      20094.19         209160.38       57258.43
    9  2010-11-05      34238.88         243399.26       57258.43
    10 2010-12-03      22517.56         265916.82       57258.43
    11 2011-01-07      15984.24         281901.06       57258.43

'''

---------------------------------------------------------------------
'''                 Dropping duplicates
Removing duplicates is an essential skill to get accurate counts because 
often, you don't want to count the same thing multiple times.
In this exercise, you'll create some new DataFrames using unique values from sales.

sales is available and pandas is imported as pd.'''


# Drop duplicate store/type combinations
store_types = sales.drop_duplicates(subset =["store","type"])
print(store_types.head())

# Drop duplicate store/department combinations
store_depts = sales.drop_duplicates(subset=["store","department"])
print(store_depts.head())

# Subset the rows where is_holiday is True and drop duplicate dates
holiday_dates = sales[sales["is_holiday"]].drop_duplicates(subset="date")

# Print date col of holiday_dates
print(holiday_dates)

-----------------------------------------------------------------------**
# Count the number of stores of each type
store_counts = store_types["type"].value_counts()
print(store_counts)

# Get the proportion of stores of each type
store_props = store_types["type"].value_counts(normalize=True)
print(store_props)

# Count the number of each department number and sort
dept_counts_sorted = store_depts["department"].value_counts(sort=True)
print(dept_counts_sorted)

# Get the proportion of departments of each number and sort
dept_props_sorted = store_depts["department"].value_counts(sort=True, normalize=True)
print(dept_props_sorted)

----------------------------------------------------------------------------------
################################################################################
##              What percent of sales occurred at each store type?
#################################################################################
'''While .groupby() is useful, you can calculate grouped summary statistics without it.

Walmart distinguishes three types of stores: "supercenters," "discount stores," and "neighborhood markets," encoded in this dataset as type "A," "B," and "C." In this exercise, you'll calculate the total sales made at each store type, without using .groupby(). You can then use these numbers to see what proportion of Walmart's total sales were made at each type.

sales is available and pandas is imported as pd.
'''
# Calc total weekly sales
sales_all = sales["weekly_sales"].sum()

# Subset for type A stores, calc total weekly sales
sales_A = sales[sales["type"] == "A"]["weekly_sales"].sum()

# Subset for type B stores, calc total weekly sales
sales_B = sales[sales["type"] == "B"]["weekly_sales"].sum()

# Subset for type C stores, calc total weekly sales
sales_C = sales[sales["type"] == "C"]["weekly_sales"].sum()

# Get proportion for each type
sales_propn_by_type = [sales_A, sales_B, sales_C] /sales_all
print(sales_propn_by_type)

---------------------------------------------------------------------------

# From previous step
sales_by_type = sales.groupby("type")["weekly_sales"].sum()

# Group by type and is_holiday; calc total weekly sales
sales_by_type_is_holiday = sales.groupby(["type","is_holiday"])["weekly_sales"].sum()
print(sales_by_type_is_holiday)


---------------------------------------------------------------------------

# Import numpy with the alias np
import numpy as np

# For each store type, aggregate weekly_sales: get min, max, mean, and median
sales_stats = sales.groupby("type")["weekly_sales"].agg([min,max,np.mean,np.median])

# Print sales_stats
print(sales_stats)

# For each store type, aggregate unemployment and fuel_price_usd_per_l: get min, max, mean, and median
unemp_fuel_stats = sales.groupby("type")[["unemployment","fuel_price_usd_per_l"]].agg([min,max,np.mean,np.median])

# Print unemp_fuel_stats
print(unemp_fuel_stats)
---------------------------------------------------------------------------
'''
Get the mean weekly_sales by type using .pivot_table() and store as mean_sales_by_type.'''

# Pivot for mean weekly_sales for each store type
mean_sales_by_type = sales.pivot_table(values="weekly_sales", index ="type")

# Print mean_sales_by_type
print(mean_sales_by_type)
----------------------------------------------------------------------------------
'''
Get the mean and median (using NumPy functions) of weekly_sales by type using .pivot_table() and store as mean_med_sales_by_type.'''
# Import NumPy as np
import numpy as np

# Pivot for mean and median weekly_sales for each store type
mean_med_sales_by_type = sales.pivot_table(values="weekly_sales",index="type",aggfunc=[np.mean,np.median])

# Print mean_med_sales_by_type
print(mean_med_sales_by_type)

------------------------
# Pivot for mean weekly_sales by store type and holiday 
mean_sales_by_type_holiday = sales.pivot_table(values="weekly_sales",index="type",columns="is_holiday")

# Print mean_sales_by_type_holiday
print(mean_sales_by_type_holiday)


'''<script.py> output:
    is_holiday      False     True
    type                          
    A           23768.584  590.045
    B           25751.981  810.705'''


------------------------------------------------------------------

# Print mean weekly_sales by department and type; fill missing values with 0
print(sales.pivot_table(values="weekly_sales", index="department", columns="type", fill_value=0))


'''<script.py> output:
    type                 A           B
    department                        
    1            30961.725   44050.627
    2            67600.159  112958.527
    3            17160.003   30580.655
    4            44285.399   51219.654
    5            34821.011   63236.875
    ...                ...         ...
    95          123933.787   77082.102
    96           21367.043    9528.538
    97           28471.267    5828.873
    98           12875.423     217.428
    99             379.124       0.000
    
    [80 rows x 2 columns]'''

----------------------------------------------------------------------------

# Print the mean weekly_sales by department and type; fill missing values with 0s; sum all rows and cols
print(sales.pivot_table(values="weekly_sales", index="department", columns="type",fill_value=0, margins=True ))


'''<script.py> output:
    type                A           B        All
    department                                  
    1           30961.725   44050.627  32052.467
    2           67600.159  112958.527  71380.023
    3           17160.003   30580.655  18278.391
    4           44285.399   51219.654  44863.254
    5           34821.011   63236.875  37189.000
    ...               ...         ...        ...
    96          21367.043    9528.538  20337.608
    97          28471.267    5828.873  26584.401
    98          12875.423     217.428  11820.590
    99            379.124       0.000    379.124
    All         23674.667   25696.678  23843.950
    
    [81 rows x 3 columns]'''





