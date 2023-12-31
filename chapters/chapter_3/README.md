# Chapter 3 Exercises

# 3.2.5

1.  How do you create raw and complex scalars? (See ?raw and ?complex.)

The raw data type holds raw bytes represented as a pair of hex digits.
The `raw` data type can be created by using the `raw` function, or via
coercion with `as.raw`. A character value can be converted into a `raw`
data type by using the the `charToRaw`.

The complex number data type can be created using the `complex`
constructor, parametrizing for the real and imaginary component. A
complex value can also be created by adding `i` at the end of a double
(i.e. `2i` and `1 + 2i`).

2.  Test your knowledge of the vector coercion rules by predicting the
    output of the following uses of c():

<!-- -->

    c(1, FALSE)
    c("a", 1)
    c(TRUE, 1L)

The data type hierarchy of R will accomodate/coerce the simplest data
type into the most complex representation.

In an atomic vector that contains a double and logical, the logical
value will be coerced into a double. The double type is selected since
it is the most complex data type in the atomic vector and `logical`
value has two numeric representations (i.e. `0` and `1`). The same logic
is applied for an atomic vector that contains a logical value and an
integer value.

In an atomic vector that contains a character and a double value, the
character will be selected as the representative data type for the
atomic vector. Therefore the double will be coerced into a character
type.

3.  Why is `1 == "1"` true? Why is `-1 < FALSE` true? Why is `"one" < 2`
    false?

The `1 == "1"` leads to the `double` value `1` being coerced into `"1"`.
The expression is then resolved into `"1" == "1"`, which are equivalent
values. It could go even deeper, since R uses a global string pool so
all unique strings are only stored once in memory. Therefore, both `"1"`
values are one entity in memory.

The expression `-1 < FALSE` is evaluated to `TRUE` because the `logical`
value is coerced into a `double` with value `0`.

The final expression of `"one" < 2` is `FALSE` because R leverages
lexicographic ordering of the value `"one"` to the coerced character
`"2"`. The character `"2"` is of a lower lexicographic order than the
string \`“one”.

4.  Why is the default missing value, NA, a logical vector? What’s
    special about logical vectors? (Hint: think about c(FALSE,
    NA_character\_).

In the data type hierarchy, `logical` is the the data type of least
complexity. More complex representations of missing values are available
as `NA_*_`. However, the logical representation of a missing value is
not specified any further than the base `NA` value.

5.  Precisely what do `is.atomic()`, `is.numeric()`, and `is.vector()`
    test for?

The `is.vector` function determines if the value is a vector object. The
vector object is defined as an atomic type that can contain a singular
attribute, `names`. If any other attribute is set, then the `is.vector`
function will return a value of `FALSE`.

The `is.atomic` function is less strict than the `is.vector` function,
since it returns `TRUE` for vector objects that contain attributes
beyond `names`. However, it will return `FALSE` is a list is passed.

The `is.numeric` function will return true for values that have a
reasonable double or integer representation, where arithmetic functions
apply and logical comparisons are performed by the base type.

# 3.3.4

1.  How is `setNames()` implemented? How is `unname()` implemented? Read
    the source code.

The `setNames` function is a wrapper around the explicit names attribute
assignment `names(object) <- nm`.

The `unname` function contains two `if` statements. The first statement
checks if the `names` attribute is `NULL`. If the `names` attribute is
not `NULL`, then the `names` attribute is set to `NULL`. The second `if`
statement then determines if the object has the `dimnames` object. The
`if` statement is also determining whether the object is a data frame.
It may also ignore the fact that the object might be a data frame. If
the `dimnames` attribute is not `NULL`, then it is set to `NULL`.

2.  What does `dim()` return when applied to a 1-dimensional vector?
    When might you use `NROW()` or `NCOL()`?

The `dim` attribute defined a matrix or array object in R. The lack of a
dim attribute specifies a 1-dimensional vector object. Therefore, a call
to `dim()` on a vector object will return `NULL`. The `nrow` and `ncol`
function make a call to `dim` and subset the result to the desired
value. Given that `dim` will return `NULL` for a vector object, the
functions `nrow` and `ncol` will both return `NULL`.

3.  How would you describe the following three objects? What makes them
    different from `1:5`?

<!-- -->

    x1 <- array(1:5, c(1, 1, 5))
    x2 <- array(1:5, c(1, 5, 1))
    x3 <- array(1:5, c(5, 1, 1))

The variable `x1` points to an array, since the number of rows and
columns are specified to `1`. The third value in the `dim` parameter is
greater than `1` and can only be accomodated by an array.

The variable `x2` points to a matrix, since the number of columns are
specified to a value greater than `1`, while the other dimensions are
specified to `1`.

The variable `x3` points to a vecotr, since all `dim` values are
specified to `1` other than the first element.

4.  An early draft used this code to illustrate `structure()`:

<!-- -->

    structure(1:5, comment = "my attribute")
    #> [1] 1 2 3 4 5

But when you print that object you don’t see the comment attribute. Why?
Is the attribute missing, or is there something else special about it?
(Hint: try using help.)

The attribute is set within the vector object `1:5`. The default print
of a vector object does not include a retrieving the attribute
`comment`. Therefore, when the vector object is printed to the console,
the attribute `comment` remains hidden. The non-reserved attributes can
still be accessed using the `attributes` or `attr` functions.

# 3.4.5

1.  What sort of object does `table()` return? What is its type? What
    attributes does it have? How does the dimensionality change as you
    tabulate more variables?

The `table()` function returns an S3 object, with a class attribute set
to a `"table"`. The base type specified is an integer array. The table
will contains the attributes: `dim`, `dimnames`, and `class`.

The dimensionality will increase linearly as more variables are
tabulated. The `table` S3 object is able to host `n` dimensions because
it uses the array integer object to contain its data.

2.  What happens to a factor when you modify its levels?

<!-- -->

    f1 <- factor(letters)
    levels(f1) <- rev(levels(f1))

When the `levels` attribute are reversed in a factor, the printed data
is also observed to be reversed.

3.  What does this code do? How do `f2` and `f3` differ from `f1`?

<!-- -->

    f2 <- rev(factor(letters))
    f3 <- factor(letters, levels = rev(letters))

When constructing a `factor` S3 object, with default parameters, the
levels are identified as the ordered unique values of the object being
passed.

The observed data is then stored as an integer vector object of indices
that correspond to a value in the `levels` attribute. If a factor was
constructed as `factor(c("b", "a"), levels = c("a", "b"))`, then the
integer vector representing the observed data would be `c(2L, 1L)`. The
first element of the data represented the integer value `2L` which
corresponds to the second element of the `levels` vector object.

The objects `f2` and `f3` provide a true representation of the data. The
factor referenced by `f1` has obfuscated the data by reversing the
levels, but did not adjust the indices in the integer vector object.
When the factor is printed to console, it appears as if the data itself
has been reverse. In our `factor(c("b", "a"), levels = c("a", "b"))`
example, the integer vector of indices would remain as `c(2L, 1L)` but
the levels would be altered to `c("b", "a")`. When the factor is printed
to console, the output would be `c("a", "b")`.

The manipulation performed in Question 2 presents a data quality issue.

# 3.5.4

1.  List all the ways that a list differs from an atomic vector.

- Points to multiple objects.
- Does not need to be atomic.
- Contains references and not values of an object.
- Can contain other lists within itself.

2.  Why do you need to use `unlist()` to convert a list to an atomic
    vector? Why doesn’t `as.vector()` work?

A list object has the potential to be nested with additionally lists. A
function that coerces a list into a vector object will need to recurse
through the list to retrieve of the values contained within. The
function `as.vector` does not recurse through the list object.

3.  Compare and contrast `c()` and `unlist()` when combining a date and
    date-time into a single vector.

The `c` function will return the original list. The `unlist` function
will return a vector object of type double.

# 3.6.8

1.  Can you have a data frame with zero rows? What about zero columns?

``` r
data.frame()
```

    data frame with 0 columns and 0 rows

An empty data frame can be created.

2.  What happens if you attempt to set `rownames` that are not unique?

``` r
data.frame(row.names = c("1", "2", "1"))
```

    Error in data.frame(row.names = c("1", "2", "1")): duplicate row.names: 1

Setting non-unique row names causes an error during creation of the data
frame.

3.  If `df` is a data frame, what can you say about `t(df)`, and
    `t(t(df))`? Perform some experiments, making sure to try different
    column types.

The `t` function will coerce the data frame object into named matrix.
Applying the tranposition a second time will not revert the coercion.

4.  What does `as.matrix()` do when applied to a data frame with columns
    of different types? How does it differ from `data.matrix()`?

``` r
as.matrix(data.frame(x = c(9:18), y = letters[10:1], stringsAsFactors = FALSE))
```

          x    y  
     [1,] " 9" "j"
     [2,] "10" "i"
     [3,] "11" "h"
     [4,] "12" "g"
     [5,] "13" "f"
     [6,] "14" "e"
     [7,] "15" "d"
     [8,] "16" "c"
     [9,] "17" "b"
    [10,] "18" "a"

The `as.matrix` function converts all columns of the data frame into the
most complex base type. The case of the above example, the columns are
all coerced into character type with padding to each value of a column
has the same length.

``` r
data.matrix(data.frame(x = c(9:18), y = letters[1:10], stringsAsFactors = FALSE))
```

           x  y
     [1,]  9  1
     [2,] 10  2
     [3,] 11  3
     [4,] 12  4
     [5,] 13  5
     [6,] 14  6
     [7,] 15  7
     [8,] 16  8
     [9,] 17  9
    [10,] 18 10

The `data.matrix` function converts all columns into a numeric
representation. In the above code, the `y` column is converted into a
matrix column of integer values. The integer values likely represent the
index of the letters that were contained in the `y` column of the data
frame.
