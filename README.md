# changeLegendColour
A package to customise the colours of your legend text and remove the legend key from ggplot2 graphs.

## Installation

Install the development version of the package from GitHub:

```
install.packages("devtools")
devtools::install_github("department-for-transport/gglegendcolour")
```

# How to use

```
changeLegendColour(
  x = a ggplot2 object,
  remove_key = boolean value where TRUE removes the key from your legend and FALSE will keep the boolean value (default is TRUE)
)
```
Just create your ggplot2 graph as per normal, then use the changeLegendColour function with your ggplot object as the first argument and the second argument should be TRUE or FALSE depending on whether you wish to remove the key. The default value for the second argument is TRUE which removes the key from the returned ggplot2 object.

In your ggplot2 object, you must supply colours to your groups. The vector you supply the colours in must be named with the names corresponding to the groups.

If you wish to update the labels in your legend, as per the colours, the vector you supply the new labels in must be named with the names corresponding to the groups.

As an example, if you're using scale_color_manual to supply your colours, this is what the values and labels arguments to that must look like:

``` 
scale_color_manual(
  values = c("group 1" = "colour 1",...),
  labels = c("group 1" = "colour 1",...)
)
```

# Example code
```
library(ggplot2)

cols <- c("8" = "red", "4" = "blue", "6" = "darkgreen", "10" = "orange")

p <- ggplot(
  mtcars,
  aes(mpg, wt, colour = factor(cyl), fill = factor(cyl))
) +
  geom_point(shape = 21, alpha = 0.5, size = 2) +
  scale_colour_manual(
    values = cols,
    labels = c("8" = "eight", "4" = "four", "6" = "six", "10" = "ten"),
    aesthetics = c("colour", "fill")
  )

p <- changeLegendColour::changeLegendColour(
  x = p,
  remove_key = TRUE
)
p
```
