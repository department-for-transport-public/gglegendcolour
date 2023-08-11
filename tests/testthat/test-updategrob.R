testthat::test_that("no legend error", {
  library(ggplot2)
  data(mpg, package="ggplot2")
  # Scatterplot
  g <- ggplot(mpg, aes(cty, hwy)) +
    geom_jitter(width = .5, size=1)

  testthat::expect_error(
    object = changeLegendColour(g, remove_key = FALSE),
    regexp = "No guide-box element found in the grob of the ggplot"
  )
})

testthat::test_that("legend removed error", {
  library(ggplot2)
  # load data
  data("mtcars")
  # create new column for car names
  mtcars$`car name` <- rownames(mtcars)
  # compute normalized mpg
  mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2)
  # above / below avg flag
  mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "below", "above")
  # sort
  mtcars <- mtcars[order(mtcars$mpg_z), ]
  # convert to factor to retain sorted order in plot.
  mtcars$`car name` <- factor(mtcars$`car name`, levels = mtcars$`car name`)

  # Diverging Barcharts
  g <- ggplot(mtcars, aes(x=`car name`, y=mpg_z, label=mpg_z)) +
    geom_bar(stat='identity', aes(fill=mpg_type), width=.5, show.legend = FALSE)  +
    scale_fill_manual(name="Mileage",
                      labels = c("Above Average", "Below Average"),
                      values = c("above"="#00ba38", "below"="#f8766d")) +
    labs(subtitle="Normalised mileage from 'mtcars'",
         title= "Diverging Bars") +
    coord_flip()

  testthat::expect_error(
    object = changeLegendColour(g, remove_key = FALSE),
    regexp = "No guide-box element found in the grob of the ggplot"
  )
})

# testthat::test_that("scatterplot test", {
#
#   data("midwest", package = "ggplot2")
#   gg <- ggplot(midwest, aes(x=area, y=poptotal)) +
#     geom_point(aes(col=state)) +
#     scale_colour_manual(values = c("IL" = "#15b542", "IN" = "#232323", "MI" = "#99c3ba", "OH" = "#004d3b", "WI" = "#6676a9"))
#
#   testthat::expect_equal(
#     object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$gp$col,
#     expected = "#15b542"
#   )
# })

#
# testthat::test_that("scatterplot test", {
#
#   data("midwest", package = "ggplot2")
#   gg <- ggplot(midwest, aes(x=area, y=poptotal)) +
#     geom_point(aes(col=state)) +
#     scale_colour_manual(values = c("IL" = "#15b542", "IN" = "#232323", "MI" = "#99c3ba", "OH" = "#004d3b", "WI" = "#6676a9"))
#
#   testthat::expect_equal(
#     object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$gp$col,
#     expected = "#15b542"
#   )
#   # testthat::expect_equal(
#   #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[14][[1]]$children[[1]]$children[[1]]$gp$col,
#   #   expected = "#232323"
#   # )
#   # testthat::expect_equal(
#   #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[15][[1]]$children[[1]]$children[[1]]$gp$col,
#   #   expected = "#99c3ba"
#   # )
#   # testthat::expect_equal(
#   #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[16][[1]]$children[[1]]$children[[1]]$gp$col,
#   #   expected = "#004d3b"
#   # )
#   # testthat::expect_equal(
#   #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$gp$col,
#   #   expected = "#6676a9"
#   # )
# })
