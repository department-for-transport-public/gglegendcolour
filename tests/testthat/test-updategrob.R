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
    coord_flip()

  testthat::expect_error(
    object = changeLegendColour(g, remove_key = FALSE),
    regexp = "No guide-box element found in the grob of the ggplot"
  )
})

testthat::test_that("scatterplot test", {

  data("midwest", package = "ggplot2")
  gg <- ggplot(midwest, aes(x=area, y=poptotal)) +
    geom_point(aes(col=state)) +
    scale_colour_manual(values = c("IL" = "#15b542", "IN" = "#232323", "MI" = "#99c3ba", "OH" = "#004d3b", "WI" = "#6676a9"))

  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#15B542FF"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$label,
    expected = "IL"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[14][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#232323FF"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[14][[1]]$children[[1]]$children[[1]]$label,
    expected = "IN"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[15][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#99C3BAFF"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[15][[1]]$children[[1]]$children[[1]]$label,
    expected = "MI"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[16][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#004D3BFF"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[16][[1]]$children[[1]]$children[[1]]$label,
    expected = "OH"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#6676A9FF"
  )
  testthat::expect_equal(
    object = updateGrob(gg, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$label,
    expected = "WI"
  )
})

testthat::test_that("line and scatterplot test", {
  data(mpg, package="ggplot2")

  mpg_select <- mpg[mpg$manufacturer %in% c("audi", "ford", "honda", "hyundai"), ]

  g <- ggplot(mpg_select, aes(displ, cty)) +
    geom_jitter(aes(col=manufacturer)) +
    geom_smooth(aes(col=manufacturer), method="lm", se=F) +
    scale_colour_manual(values = c("audi" = "#15b542", "ford" = "#232323", "honda" = "#99c3ba", "hyundai" = "#004d3b"))

  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[15][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#15B542FF"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[15][[1]]$children[[1]]$children[[1]]$label,
    expected = "audi"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[16][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#232323FF"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[16][[1]]$children[[1]]$children[[1]]$label,
    expected = "ford"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#99C3BAFF"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$label,
    expected = "honda"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[18][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#004D3BFF"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[18][[1]]$children[[1]]$children[[1]]$label,
    expected = "hyundai"
  )
})

testthat::test_that("waffle fill not colour test", {
  library(ggplot2)
  var <- mpg$class  # the categorical data
  ## Prep data (nothing to change here)
  nrows <- 10
  df <- expand.grid(y = 1:nrows, x = 1:nrows)
  categ_table <- round(table(var) * ((nrows*nrows)/(length(var))))
  df$category <- factor(rep(names(categ_table), categ_table))

  ## Plot
  g <- ggplot(df, aes(x = x, y = y, fill = category)) +
    geom_tile(color = "black", linewidth = 0.5) +
    scale_x_continuous(expand = c(0, 0)) +
    scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
    scale_fill_manual(values = c(
      "2seater" = "#15B542", "compact"= "#232323","midsize" = "#99C3BA","minivan" = "#004D3B",
      "pickup" = "#6676A9","subcompact" = "#FF0000","suv" = "#00B0F0")) +
    labs(title="Waffle Chart", subtitle="'Class' of vehicles",
         caption="Source: mpg")

  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#15B542"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$label,
    expected = "2seater"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[18][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#232323"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[18][[1]]$children[[1]]$children[[1]]$label,
    expected = "compact"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[19][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#99C3BA"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[19][[1]]$children[[1]]$children[[1]]$label,
    expected = "midsize"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[20][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#004D3B"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[20][[1]]$children[[1]]$children[[1]]$label,
    expected = "minivan"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[21][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#6676A9"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[21][[1]]$children[[1]]$children[[1]]$label,
    expected = "pickup"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[22][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#FF0000"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[22][[1]]$children[[1]]$children[[1]]$label,
    expected = "subcompact"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[23][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#00B0F0"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[23][[1]]$children[[1]]$children[[1]]$label,
    expected = "suv"
  )
})

testthat::test_that("pie fill not colour test", {
  library(ggplot2)
  g <- ggplot(mpg, aes(x = "", fill = factor(class))) +
    geom_bar(width = 1) +
    coord_polar(theta = "y", start=0) +
    scale_fill_manual(values = c(
      "2seater" = "#15B542", "compact"= "#232323","midsize" = "#99C3BA","minivan" = "#004D3B",
      "pickup" = "#6676A9","subcompact" = "#FF0000","suv" = "#00B0F0"))

  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#15B542"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$label,
    expected = "2seater"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[18][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#232323"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[18][[1]]$children[[1]]$children[[1]]$label,
    expected = "compact"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[19][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#99C3BA"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[19][[1]]$children[[1]]$children[[1]]$label,
    expected = "midsize"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[20][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#004D3B"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[20][[1]]$children[[1]]$children[[1]]$label,
    expected = "minivan"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[21][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#6676A9"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[21][[1]]$children[[1]]$children[[1]]$label,
    expected = "pickup"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[22][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#FF0000"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[22][[1]]$children[[1]]$children[[1]]$label,
    expected = "subcompact"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[23][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#00B0F0"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[23][[1]]$children[[1]]$children[[1]]$label,
    expected = "suv"
  )
})

testthat::test_that("boxplot test", {
  library(ggplot2)
  g <- ggplot(mpg, aes(class, cty)) +
    geom_boxplot(aes(fill=factor(cyl))) +
    scale_fill_manual(values = c(
      "4" = "#15B542", "5"= "#232323","6" = "#99C3BA","8" = "#004D3B"
    ))

  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[11][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#15B542"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[11][[1]]$children[[1]]$children[[1]]$label,
    expected = "4"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[12][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#232323"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[12][[1]]$children[[1]]$children[[1]]$label,
    expected = "5"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#99C3BA"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$label,
    expected = "6"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[14][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#004D3B"
  )
  testthat::expect_equal(
    object = updateGrob(g, FALSE)$grobs[[15]]$grobs[[1]]$grobs[14][[1]]$children[[1]]$children[[1]]$label,
    expected = "8"
  )
})
