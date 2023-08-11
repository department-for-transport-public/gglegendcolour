#' @export
#' @importFrom ggplot2 ggplotGrob ggplot_build
#' @importFrom ggplotify as.ggplot
#' @importFrom gtable gtable_filter
#'
#' @name changeLegendColour
#' @param x A ggplot2 graph.
#' @param remove_key Boolean to whether to remove the key from the legend. True
#' to remove. Defaults to True.
#'
#' @title Customise the text colour of your legend.

changeLegendColour <- function(x,
                               remove_key = TRUE) {

  ##Stop if x is not a ggplot object
  if(!ggplot2::is.ggplot(x)) {
    stop("x must be a ggplot object")
  }

  final_graph <- updateGrob(x = x, remove_key = remove_key)

  final_graph <- ggplotify::as.ggplot(graph_grob)

  return(final_graph)
}


