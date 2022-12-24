# Look at temperatures
print(temperatures.head)

# Set the index of temperatures to city
temperatures_ind = temperatures.set_index("city")

# Look at temperatures_ind
print(temperatures_ind)

# Reset the temperatures_ind index, keeping its contents
print(temperatures_ind.reset_index())

# Reset the temperatures_ind index, dropping its contents
print(temperatures_ind.reset_index(drop=True))



----------------------------------------------------------------
# Make a list of cities to subset on
cities = ["Moscow", "Saint Petersburg"]

# Subset temperatures using square brackets
print(temperatures[temperatures["city"].isin(cities)] )

# Subset temperatures_ind using .loc[]
print(temperatures_ind.loc[cities])


-------------------------------------------------------------------


# Index temperatures by country & city
temperatures_ind = temperatures.set_index(["country","city"])

# List of tuples: Brazil, Rio De Janeiro & Pakistan, Lahore
rows_to_keep = [("Brazil","Rio De Janeiro"),("Pakistan","Lahore")]

# Subset for rows to keep
print(temperatures_ind.loc[rows_to_keep])

################################################################
##          Sorting by index values
################################################################
# Sort temperatures_ind by index values
print(temperatures_ind.sort_index())

# Sort temperatures_ind by index values at the city level
print(temperatures_ind.sort_index(level=["city"]))

# Sort temperatures_ind by country then descending city
print(temperatures_ind.sort_index(level =["country","city"],ascending=[True,False]))




# Sort the index of temperatures_ind
temperatures_srt = temperatures_ind.sort_index()

# Subset rows from Pakistan to Russia
print(temperatures_srt.loc["Pakistan":"Russia"])

# Try to subset rows from Lahore to Moscow
print(temperatures_srt.loc["Lahore":"Moscow"])

# Subset rows from Pakistan, Lahore to Russia, Moscow
print(temperatures_srt.loc[("Pakistan", "Lahore"):("Russia", "Moscow")])

'''<script.py> output:
                                    date  avg_temp_c
    country  city                                   
    Pakistan Faisalabad       2000-01-01      12.792
             Faisalabad       2000-02-01      14.339
             Faisalabad       2000-03-01      20.309
             Faisalabad       2000-04-01      29.072
             Faisalabad       2000-05-01      34.845
    ...                              ...         ...
    Russia   Saint Petersburg 2013-05-01      12.355
             Saint Petersburg 2013-06-01      17.185
             Saint Petersburg 2013-07-01      17.234
             Saint Petersburg 2013-08-01      17.153
             Saint Petersburg 2013-09-01         NaN
    
    [1155 rows x 2 columns]
                             date  avg_temp_c
    country city                             
    Mexico  Mexico     2000-01-01      12.694
            Mexico     2000-02-01      14.677
            Mexico     2000-03-01      17.376
            Mexico     2000-04-01      18.294
            Mexico     2000-05-01      18.562
    ...                       ...         ...
    Morocco Casablanca 2013-05-01      19.217
            Casablanca 2013-06-01      23.649
            Casablanca 2013-07-01      27.488
            Casablanca 2013-08-01      27.952
            Casablanca 2013-09-01         NaN
    
    [330 rows x 2 columns]
                          date  avg_temp_c
    country  city                         
    Pakistan Lahore 2000-01-01      12.792
             Lahore 2000-02-01      14.339
             Lahore 2000-03-01      20.309
             Lahore 2000-04-01      29.072
             Lahore 2000-05-01      34.845
    ...                    ...         ...
    Russia   Moscow 2013-05-01      16.152
             Moscow 2013-06-01      18.718
             Moscow 2013-07-01      18.136
             Moscow 2013-08-01      17.485
             Moscow 2013-09-01         NaN
    
    [660 rows x 2 columns]'''

##############################################################
##  Slicing in both directions
##############################################################


# Subset rows from India, Hyderabad to Iraq, Baghdad
print(temperatures_srt.loc[("India","Hyderabad"):("Iraq","Baghdad")])

# Subset columns from date to avg_temp_c
print(temperatures_srt.loc[:,"date":"avg_temp_c"])

# Subset in both directions at once
print(temperatures_srt.loc[("India","Hyderabad"):("Iraq","Baghdad"),"date":"avg_temp_c"])


#####################################################################
##     Slicing time series
####################################################################
'''
Slicing is particularly useful for time series since it's a common thing to want to 
filter for data within a date range. Add the date column to the index, 
then use .loc[] to perform the subsetting. The important thing to remember is to keep 
your dates in ISO 8601 format, that is, "yyyy-mm-dd" for year-month-day, "yyyy-mm" for
year-month, and "yyyy" for year.
'''

# Use Boolean conditions to subset temperatures for rows in 2010 and 2011
temperatures_bool = temperatures[(temperatures["date"] >= "2010-01-01") & (temperatures["date"] <= "2011-12-31")]
print(temperatures_bool)

# Set date as the index and sort the index
temperatures_ind = temperatures.set_index("date").sort_index()

# Use .loc[] to subset temperatures_ind for rows in 2010 and 2011
print(temperatures_ind.loc["2010":"2011"])

# Use .loc[] to subset temperatures_ind for rows from Aug 2010 to Feb 2011
print(temperatures_ind.loc["2010-08":"2011-02"])



#######################################################################
##                      ilOC()
######################################################################
# Get 23rd row, 2nd column (index 22, 1)
print(temperatures.iloc[22,1])

# Use slicing to get the first 5 rows
print(temperatures.iloc[0:5])

# Use slicing to get columns 3 to 4
print(temperatures.iloc[:,2:4])

# Use slicing in both directions at once
print(temperatures.iloc[0:5,2:4])


##################################################################
##     Working With Pivot table
##################################################################
# Add a year column to temperatures
temperatures["year"]=temperatures["date"].dt.year

# Pivot avg_temp_c by country and city vs year
temp_by_country_city_vs_year = temperatures.pivot_table("avg_temp_c", index=["country","city"], columns="year")

# See the result
print(temp_by_country_city_vs_year)

# Subset for Egypt to India
temp_by_country_city_vs_year.loc["Egypt":"India"]

# Subset for Egypt, Cairo to India, Delhi
temp_by_country_city_vs_year.loc[("Egypt","Cairo"):("India","Delhi")]

# Subset for Egypt, Cairo to India, Delhi, and 2005 to 2010
temp_by_country_city_vs_year.loc[("Egypt","Cairo"):("India","Delhi"),"2005":"2010"]

##################################################################
##       Calculating on a pivot table
##################################################################

# Get the worldwide mean temp by year
mean_temp_by_year = temp_by_country_city_vs_year.mean(axis="index")

# Filter for the year that had the highest mean temp
print(mean_temp_by_year[mean_temp_by_year == max(mean_temp_by_year)])

# Get the mean temp by city
mean_temp_by_city = temp_by_country_city_vs_year.mean(axis="columns")

# Filter for the city that had the lowest mean temp
print(mean_temp_by_city[mean_temp_by_city == min(mean_temp_by_city)])

