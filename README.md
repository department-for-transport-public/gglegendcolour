# gglegendcolour
A package to change the colours of your legend text into the same colour as the legend key and remove the legend key from ggplot2 graphs.

## Installation

Install the development version of the package from GitHub:

```
install.packages("devtools")
devtools::install_github("department-for-transport-public/gglegendcolour")
```

# How to use

```
gglegendcolour::changeLegendColour(
  x = a ggplot2 object,
  remove_key = boolean value where TRUE removes the key from your legend and FALSE will keep the boolean value (default is TRUE)
)
```
Just create your ggplot2 graph as per normal, then use the changeLegendColour function with your ggplot object as the first argument and the second argument should be TRUE or FALSE depending on whether you wish to remove the key. The default value for the second argument is TRUE which removes the key from the returned ggplot2 object.

In your ggplot2 object, you must have a legend else you'll get an error. If you have multiple parts to the key in your legend, such as if your key had a line and a dot for each element in the key, the whole key for each element should be the same colour.

# Example code
```
library(ggplot2)

p <- ggplot(
  mtcars,
  aes(mpg, wt, colour = factor(cyl), fill = factor(cyl))
) +
  geom_point(shape = 21, alpha = 0.5, size = 2) 

p <- gglegendcolour::changeLegendColour(
  x = p,
  remove_key = TRUE
)
p
```

