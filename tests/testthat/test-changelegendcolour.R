testthat::test_that("ggplot error", {
  testthat::expect_error(
    object = changeLegendColour("testing testing 1 2 1 2", remove_key = FALSE),
    regexp = "x must be a ggplot object"
  )
})

testthat::test_that("return ggplot", {

  data("midwest", package = "ggplot2")
  gg <- ggplot2::ggplot(midwest, ggplot2::aes(x=area, y=poptotal)) +
    ggplot2::geom_point(ggplot2::aes(col=state)) +
    ggplot2::scale_colour_manual(values = c("IL" = "#15b542", "IN" = "#232323", "MI" = "#99c3ba", "OH" = "#004d3b", "WI" = "#6676a9"))

  testthat::expect_true(
    object = ggplot2::is.ggplot(changeLegendColour(gg, remove_key = FALSE))
  )
})

