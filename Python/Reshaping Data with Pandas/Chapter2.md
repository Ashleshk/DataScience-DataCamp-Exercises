## Converting Between Wide and Long Format

1. Wide to long transformation
    * Perform analytics
    * Plot different variables in the same graph

```py
books.melt(id_vars='title')
```

* Define a gothic_melted DataFrame by melting the books_gothic DataFrame, using only the title as an identifier variable.

```py
# Melt books_gothic using the title column as identifier 
gothic_melted = books_gothic.melt(id_vars='title')

# Print gothic_melted
print(gothic_melted)

# Melt books_gothic using the title, authors, and publisher columns as identifier
gothic_melted_new = books_gothic.melt(id_vars=['title','authors','publisher'])

# Print gothic_melted_new
print(gothic_melted_new)
```

## Further Concepts of using melt

1. Define a new DataFrame by melting the publisher column using the title and authors columns as identifier variables.

```py
# Melt publisher column using title and authors as identifiers
publisher_melted = books_gothic.melt(id_vars=['title', 'authors'], 
                                     value_vars='publisher')

# Print publisher_melted
print(publisher_melted)
```

2. Melt the rating and rating_count columns of books_gothic DataFrame using the title column as an identifier variable.

```py
# Melt rating and rating_count columns using the title as identifier
rating_melted = books_gothic.melt(id_vars='title', 
                                  value_vars=['rating' , 'rating_count'])

# Print rating_melted
print(rating_melted)
```

3. Melt the rating and rating_count columns of book_gothic using the title and authors columns as identifier variables.

```py
# Melt rating and rating_count columns using title and authors as identifier
books_melted = books_gothic.melt(id_vars=['title','authors'], 
                                 value_vars=['rating','rating_count'])

# Print books_melted
print(books_melted)
```


## How is Frankenstein, Dorian Gray?

```py
# Define a new books_ratings DataFrame by melting the rating and rating_count columns using the title, authors, and publisher as identifier variables.
#Inside the .melt() call, assign the name 'feature' to the column that contains the variable names.
# Assign the name number to the new column containing the values
books_ratings = books_gothic.melt(id_vars=['title', 'authors', 'publisher'], 
                                  value_vars=['rating', 'rating_count'], 
                                  var_name='feature', 
                                  value_name='number')

# Print books_ratings
print(books_ratings)
```



# Wide to long transformation --- pd.wide_to_long

```py
# Reshape wide to long using title as index and version as new name, and extracting isbn prefix 
isbn_long = pd.wide_to_long(golden_age, 
                    stubnames='isbn', 
                    i='title', 
                    j='version')

# Print isbn_long
print(isbn_long)
```

```
<script.py> output:
                               prefix13  prefix10              authors           isbn
    title             version                                                        
    The Great Gatsby  13            978         1  F. Scott Fitzgerald  9780060098919
    The Short Stories 13            978         0     Ernest Hemingway  9780684837864
    To the Lighthouse 13            978         0       Virginia Woolf  9780156030472
    The Great Gatsby  10            978         1  F. Scott Fitzgerald     1572702567
    The Short Stories 10            978         0     Ernest Hemingway      684837862
    To the Lighthouse 10            978         0       Virginia Woolf      156030470
```



```py
# Reshape wide to long using title and authors as index and version as new name, and prefix as wide column prefix
prefix_long = pd.wide_to_long(golden_age, 
                      stubnames='prefix', 
                      i=['title', 'authors'], 
                      j='version')

# Print prefix_long
print(prefix_long)
```

```
    
<script.py> output:
                                                       isbn10         isbn13  prefix
    title             authors             version                                   
    The Great Gatsby  F. Scott Fitzgerald 13       1572702567  9780060098919     978
                                          10       1572702567  9780060098919       1
    The Short Stories Ernest Hemingway    13        684837862  9780684837864     978
                                          10        684837862  9780684837864       0
    To the Lighthouse Virginia Woolf      13        156030470  9780156030472     978
                                          10        156030470  9780156030472       0
```


```py
# Reshape wide to long using title and authors as index and version as new name, and prefix and isbn as wide column prefixes
all_long = pd.wide_to_long(golden_age, 
                   stubnames=['isbn','prefix'], 
                   i=['title','authors'], 
                   j='version')

# Print all_long
print(all_long)
```

```
<script.py> output:
                                                            isbn  prefix
    title             authors             version                       
    The Great Gatsby  F. Scott Fitzgerald 13       9780060098919     978
                                          10          1572702567       1
    The Short Stories Ernest Hemingway    13       9780684837864     978
                                          10           684837862       0
    To the Lighthouse Virginia Woolf      13       9780156030472     978
                                          10           156030470       0
```

```py
# Specify that wide columns have a suffix containing words
the_code_long = pd.wide_to_long(books_brown, 
                                stubnames=['language', 'publisher'], 
                                i=['author', 'title'], 
                                j='code', 
                                sep='_', 
                                suffix='\w+')

# Print the_code_long
print(the_code_long)
```

```
<script.py> output:
                                        language     publisher
    author    title                code                       
    Dan Brown The Da Vinci Code    code        0            12
                                   name  english  Random House
              Angels & Demons      code        0            34
                                   name  english  Pocket Books
              La fortaleza digital code       84            43
                                   name  spanish       Umbriel
```


```py
# Modify books_hunger by resetting the index without dropping it
books_hunger.reset_index(drop=False, inplace=True)

# Reshape using title and language as index, feature as new name, publication and page as prefix separated by space and ending in a word
publication_features = pd.wide_to_long(books_hunger, 
                                stubnames=['publication', 'page'], 
                                i=['title', 'language'], 
                                j='feature', 
                                sep=' ', 
                                suffix='\w+')

# Print publication_features
print(publication_features)
```

```
<script.py> output:
                                            publication   page
    title                  language feature                   
    Los Juegos del Hambre  Spanish  date      5/25/2010    NaN
                                    number            2  374.0
    Catching Fire          English  date      5/25/2012    NaN
                                    number            6  391.0
    Il canto della rivolta Italian  date       6/8/2015    NaN
```


## Working with string columns

```py
# Split the index of books_dys by the hyphen 
books_dys.index = books_dys.index.str.split('-' )

# Print books_dys
print(books_dys)
```

* Now that you've split the index, get the first element and assign it to the index of books_dys.

```py
# Get the first element after splitting the index of books_dys
books_dys.index = books_dys.index.str.split('-').str.get(0)

# Print books_dys
print(books_dys)
```

* Concatenate the current index of books_dys with the pre-defined author_list, using a hyphen as a separating element. Assign it to the index.

```py
# Split by the hyphen the index of books_dys
books_dys.index = books_dys.index.str.split('-').str.get(0)

# Concatenate the index with the list author_list separated by a hyphen
books_dys.index = books_dys.index.str.cat(author_list, sep='-')

# Print books_dys
print(books_dys)
```

## Complete Example 

```
<script.py> output:
              title                   subtitle                     authors  goodreads  amazon                                  full_title
    0  Harry Potter     the Half-Blood Prince   J.K. Rowling/Mary GrandPré       4.57    4.52     Harry Potter and the Half-Blood Prince 
    1  Harry Potter  the Order of the Phoenix   J.K. Rowling/Mary GrandPré       4.49    4.44  Harry Potter and the Order of the Phoenix 
    2  Harry Potter    the Chamber of Secrets                 J.K. Rowling       4.42    4.37    Harry Potter and the Chamber of Secrets 
    3  Harry Potter   the Prisoner of Azkaban   J.K. Rowling/Mary GrandPré       4.56    4.51   Harry Potter and the Prisoner of Azkaban 
    4  Harry Potter        The Deathly Hallows  J.K. Rowling/Mary GrandPré       4.42    4.37        Harry Potter and The Deathly Hallows
    5  Harry Potter      the Sorcerer's Stone   J.K. Rowling/Mary GrandPré       4.47    4.42      Harry Potter and the Sorcerer's Stone 
    6  Harry Potter        the Goblet of Fire                 J.K. Rowling       4.56    4.51        Harry Potter and the Goblet of Fire 
```

```py
# Concatenate the title and subtitle separated by "and" surrounded by spaces
hp_books['full_title'] = hp_books['title'].str.cat(hp_books['subtitle'], sep =" and ") 

# Split the authors into writer and illustrator columns
hp_books[['writer', 'illustrator']] = hp_books['authors'].str.split('/', expand=True)

# Melt goodreads and amazon columns into a single column
hp_melt = hp_books.melt(id_vars=['full_title','writer'], 
                        value_vars=['goodreads','amazon'], 
                        var_name='source', 
                        value_name='rating')

# Print hp_melt
print(hp_melt)
```


```
<script.py> output:
                                        full_title        writer     source  rating
    0      Harry Potter and the Half-Blood Prince   J.K. Rowling  goodreads    4.57
    1   Harry Potter and the Order of the Phoenix   J.K. Rowling  goodreads    4.49
    2     Harry Potter and the Chamber of Secrets   J.K. Rowling  goodreads    4.42
    3    Harry Potter and the Prisoner of Azkaban   J.K. Rowling  goodreads    4.56
    4         Harry Potter and The Deathly Hallows  J.K. Rowling  goodreads    4.42
    5       Harry Potter and the Sorcerer's Stone   J.K. Rowling  goodreads    4.47
    6         Harry Potter and the Goblet of Fire   J.K. Rowling  goodreads    4.56
    7      Harry Potter and the Half-Blood Prince   J.K. Rowling     amazon    4.52
    8   Harry Potter and the Order of the Phoenix   J.K. Rowling     amazon    4.44
    9     Harry Potter and the Chamber of Secrets   J.K. Rowling     amazon    4.37
    10   Harry Potter and the Prisoner of Azkaban   J.K. Rowling     amazon    4.51
    11        Harry Potter and The Deathly Hallows  J.K. Rowling     amazon    4.37
    12      Harry Potter and the Sorcerer's Stone   J.K. Rowling     amazon    4.42
    13        Harry Potter and the Goblet of Fire   J.K. Rowling     amazon    4.51
```


## Example -02 

```
print(books_sh)
                               main_title version  number_pages  number_ratings                          title              subtitle
0    Sherlock Holmes: The Complete Novels   Vol I          1059           24087                Sherlock Holmes   The Complete Novels
1    Sherlock Holmes: The Complete Novels  Vol II           709           26794                Sherlock Holmes   The Complete Novels
2  Adventures of Sherlock Holmes: Memoirs   Vol I           334            2184  Adventures of Sherlock Holmes               Memoirs
3  Adventures of Sherlock Holmes: Memoirs  Vol II           238            1884  Adventures of Sherlock Holmes               Memoirs
```

```py
# Split main_title by a colon and assign it to two columns named title and subtitle 
books_sh[['title', 'subtitle']] = books_sh['main_title'].str.split(':', expand=True)

# Split version by a space and assign the second element to the column named volume 
books_sh['volume'] = books_sh['version'].str.split(' ').str.get(1)

# Drop the main_title and version columns modifying books_sh
books_sh.drop(['main_title', 'version'], axis=1, inplace=True)

# Reshape using title, subtitle and volume as index, name feature the new variable from columns starting with number, separated by undescore and ending in words 
sh_long = pd.wide_to_long(books_sh, stubnames=['number'], i=['title', 'subtitle', 'volume'], 
                  j='feature', sep='_', suffix='\w+')

# Print sh_long 
print(sh_long)
``


```
<script.py> output:
                                                                       number
    title                         subtitle             volume feature        
    Sherlock Holmes                The Complete Novels I      pages      1059
                                                              ratings   24087
                                                       II     pages       709
                                                              ratings   26794
    Adventures of Sherlock Holmes  Memoirs             I      pages       334
                                                              ratings    2184
                                                       II     pages       238
                                                              ratings    1884
```





































