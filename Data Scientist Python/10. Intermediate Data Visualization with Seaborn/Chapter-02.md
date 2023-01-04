## Matplotlib color codes

```python
# Set style, enable color code, and create a magenta displot
sns.set(color_codes=True)
sns.displot(df['fmr_3'], color='m')

# Show the plot
plt.show()
```

## Using default palettes

```python
# Loop through differences between bright and colorblind palettes
for p in ['bright', 'colorblind']:
    sns.set_palette(p)
    sns.displot(df['fmr_3'])
    plt.show()
    
    # Clear the plots    
    plt.clf()
```

## Creating Custom Palettes

```python
sns.palplot(sns.color_palette("Purples", 8))
plt.show()

sns.palplot(sns.color_palette("husl", 10))
plt.show()


sns.palplot(sns.color_palette("coolwarm", 6))
plt.show()
```








































