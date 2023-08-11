testthat::test_that("scatterplot test", {

  data("midwest", package = "ggplot2")
  gg <- ggplot(midwest, aes(x=area, y=poptotal)) +
    geom_point(aes(col=state)) +
    scale_colour_manual(values = c("IL" = "#15b542", "IN" = "#232323", "MI" = "#99c3ba", "OH" = "#004d3b", "WI" = "#6676a9"))

  testthat::expect_equal(
    object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[13][[1]]$children[[1]]$children[[1]]$gp$col,
    expected = "#15b542"
  )
  # testthat::expect_equal(
  #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[14][[1]]$children[[1]]$children[[1]]$gp$col,
  #   expected = "#232323"
  # )
  # testthat::expect_equal(
  #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[15][[1]]$children[[1]]$children[[1]]$gp$col,
  #   expected = "#99c3ba"
  # )
  # testthat::expect_equal(
  #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[16][[1]]$children[[1]]$children[[1]]$gp$col,
  #   expected = "#004d3b"
  # )
  # testthat::expect_equal(
  #   object = ggplotGrob(changeLegendColour(gg, FALSE))$grobs[[15]]$grobs[[1]]$grobs[17][[1]]$children[[1]]$children[[1]]$gp$col,
  #   expected = "#6676a9"
  # )
})
