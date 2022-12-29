## Filtering with masks

```python
# Create an array which contains row data on the largest tree in tree_census
largest_tree_data = tree_census[tree_census[:, 2] == 51]
print(largest_tree_data)

# Slice largest_tree_data to get only the block ID
largest_tree_block_id = largest_tree_data[:, 1]
print(largest_tree_block_id)

# Create an array which contains row data on all trees with largest_tree_block_id
trees_on_largest_tree_block = tree_census[tree_census[:, 1] == largest_tree_block_id]
print(trees_on_largest_tree_block)
```

## Creating arrays from conditions

```python
trunk_stump_diameters = np.where(tree_census[:, 2] == 0, tree_census[:, 3], tree_census[:, 2])
print(trunk_stump_diameters)
```

## Concatenation

```python
# Print the shapes of tree_census and new_trees
print(tree_census.shape, new_trees.shape)

# Add rows to tree_census which contain data for the new trees
updated_tree_census = np.concatenate((tree_census, new_trees))
print(updated_tree_census)
```

## Adding columns


```python
# Print the shapes of tree_census and trunk_stump_diameters
print(trunk_stump_diameters.shape, tree_census.shape)

# Reshape trunk_stump_diameters
reshaped_diameters = trunk_stump_diameters.reshape((1000, 1))

# Concatenate reshaped_diameters to tree_census as the last column
concatenated_tree_census = np.concatenate((tree_census,reshaped_diameters),axis=1)
print(concatenated_tree_census)
```

## Deleting with np.delete()

```python
# Delete the stump diameter column from tree_census
tree_census_no_stumps = np.delete(tree_census, 3, axis=1)

# Save the indices of the trees on block 313879
private_block_indices = np.where(tree_census[:,1] == 313879)

# Delete the rows for trees on block 313879 from tree_census_no_stumps
tree_census_clean = np.delete(tree_census_no_stumps, private_block_indices, axis=0)

# Print the shape of tree_census_clean
print(tree_census_clean.shape)
```

## Sales totals

```python
# Create a 2D array of total monthly sales across industries
monthly_industry_sales = monthly_sales.sum(axis=1, keepdims=True)
print(monthly_industry_sales)

# Add this column as the last column in monthly_sales
monthly_sales_with_total = np.concatenate((monthly_sales,monthly_industry_sales),axis=1)
print(monthly_sales_with_total)
```



## Plotting averages

```python
# Create the 1D array avg_monthly_sales
avg_monthly_sales = monthly_sales.mean(axis=1)
print(avg_monthly_sales)

# Plot avg_monthly_sales by month
plt.plot(np.arange(1,13), avg_monthly_sales, label="Average sales across industries")

# Plot department store sales by month
plt.plot(np.arange(1,13), monthly_sales[:,2], label="Department store sales")
plt.legend()
plt.show()
```


## Cumulative sales

```python
# Find cumulative monthly sales for each industry
cumulative_monthly_industry_sales = monthly_sales.cumsum(axis=0)
print(cumulative_monthly_industry_sales)

# Plot each industry's cumulative sales by month as separate lines
plt.plot(np.arange(1, 13), cumulative_monthly_industry_sales[:, 0], label="Liquor Stores")
plt.plot(np.arange(1, 13), cumulative_monthly_industry_sales[:, 1], label="Restaurants")
plt.plot(np.arange(1, 13), cumulative_monthly_industry_sales[:, 2], label="Department stores")
plt.legend()
plt.show()
```

# Vectorization

## Tax calculations

```python
# Create an array of tax collected by industry and month
tax_collected = monthly_sales * 0.05
print(tax_collected)

# Create an array of sales revenue plus tax collected by industry and month
total_tax_and_revenue = monthly_sales+tax_collected
print(total_tax_and_revenue)
```


## Projecting sales

```python
# Create an array of monthly projected sales for all industries
projected_monthly_sales = monthly_sales * monthly_industry_multipliers
print(projected_monthly_sales)

# Graph current liquor store sales and projected liquor store sales by month
plt.plot(np.arange(1,13), monthly_sales[:,0], label="Current liquor store sales")
plt.plot(np.arange(1,13), projected_monthly_sales[:,0], label="Projected liquor store sales")
plt.legend()
plt.show()
```

## Vectorizing .upper()

```python
# Vectorize the .upper() string method
vectorized_upper = np.vectorize(str.upper)

# Apply vectorized_upper to the upper array
uppercase_names = vectorized_upper(names)
print(uppercase_names)
```


## Broadcasting across rows

```python
# Find the mean sales projection multiplier for each industry
mean_multipliers = monthly_industry_multipliers.mean(axis=0)
print(mean_multipliers)

# Print the shapes of mean_multipliers and monthly_sales
print(mean_multipliers.shape, monthly_sales.shape)

# Multiply each value by the multiplier for that industry
projected_sales = monthly_sales * mean_multipliers
print(projected_sales)
```

## Loading .bpy File

```python
# Load the mystery_image.npy file 
with open("mystery_image.npy", "rb") as f:
    rgb_array = np.load(f)

plt.imshow(rgb_array)
plt.show()
```

## Getting help

```python
# Display the documentation for .astype()
print(help(np.ndarray.astype))
```

## Updating values and Saving 

```python
# Reduce every value in rgb_array by 50 percent
darker_rgb_array = rgb_array * 0.5

# Convert darker_rgb_array into an array of integers
darker_rgb_int_array = darker_rgb_array.astype(np.int8)
plt.imshow(darker_rgb_int_array)
plt.show()

# Save darker_rgb_int_array to an .npy file called darker_monet.npy
with open("darker_monet.npy", "wb") as f:
    np.save(f, darker_rgb_int_array)
```



## Array Acrobatics

```python
# Flip rgb_array so that it is the mirror image of the original
mirrored_monet = np.flip(rgb_array, axis=1)
plt.imshow(mirrored_monet)
plt.show()

# Flip rgb_array so that it is upside down
upside_down_monet = np.flip(rgb_array,axis=(0,1))
plt.imshow(upside_down_monet)
plt.show()
```

## Transpose 
```python
# Transpose rgb_array
transposed_rgb = np.transpose(rgb_array, axes=(1,0,2))
plt.imshow(transposed_rgb)
plt.show()
```


## 2D split and stack

```python
# Split monthly_sales into quarterly data
q1_sales, q2_sales, q3_sales, q4_sales = np.split(monthly_sales, 4)

# Print q1_sales
print(q1_sales)

# Stack the four quarterly sales arrays
quarterly_sales = np.stack([q1_sales, q2_sales, q3_sales, q4_sales ])
print(quarterly_sales)
```


## Splitting RGB data

```python
# Split rgb_array into red, green, and blue arrays
red_array, green_array, blue_array = np.split(rgb_array, 3, axis=2)

# Create emphasized_blue_array
emphasized_blue_array = np.where(blue_array > blue_array.mean(), 255, blue_array)

# Print the shape of emphasized_blue_array
print(emphasized_blue_array.shape)

# Remove the trailing dimension from emphasized_blue_array
emphasized_blue_array_2D = emphasized_blue_array.reshape((675, 844))
```

## Stacking RGB Data
```python
# Print the shapes of blue_array and emphasized_blue_array_2D
print(blue_array.shape, emphasized_blue_array_2D.shape)

# Reshape red_array and green_array
red_array_2D = red_array.reshape((675, 844))
green_array_2D = green_array.reshape((675, 844))

# Stack red_array_2D, green_array_2D, and emphasized_blue_array_2D
emphasized_blue_monet = np.stack([red_array_2D,green_array_2D,emphasized_blue_array_2D],axis=2)
plt.imshow(emphasized_blue_monet)
plt.show()
```










