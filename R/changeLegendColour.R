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
#' @title Change the text colour of your legend
#'
#' @description Change the colour of your legend text to the same colour of the group on the graph.
#'
#' @return Returns a ggplot object
#'
#' @examples
#'
#' \dontrun{
#' # Create your ggplot2 graph and store in a variable
#' p <- ggplot(
#'   mtcars,
#'   aes(mpg, wt, colour = factor(cyl), fill = factor(cyl))
#' ) +
#'   geom_point(shape = 21, alpha = 0.5, size = 2)
#'
#' # Supply your graph to the changeLegendColour function
#' p <- gglegendcolour::changeLegendColour(
#'   x = p,
#'   remove_key = TRUE
#' )
#'
#' # View the output
#' p
#'
#' }

changeLegendColour <- function(x,
                               remove_key = TRUE) {

  ##Stop if x is not a ggplot object
  if(!ggplot2::is.ggplot(x)) {
    stop("x must be a ggplot object")
  }

  final_graph <- updateGrob(x = x, remove_key = remove_key)

  final_graph <- ggplotify::as.ggplot(final_graph)

  return(final_graph)
}


