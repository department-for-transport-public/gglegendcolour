testthat::test_that("ggplot error", {
  testthat::expect_error(
    object = changeLegendColour("testing testing 1 2 1 2", remove_key = FALSE),
    regexp = "x must be a ggplot object"
  )
})



