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

  graph_grob <- ggplot2::ggplotGrob(x)

  #Find all the legend text
  gb <- base::grep("guide-box",
                   graph_grob$layout$name,
                   fixed = TRUE)

  gb2 <- base::grep("guides",
                    graph_grob$grobs[[gb]]$layout$name,
                    fixed = TRUE)

  label_text <- base::grep("label",
                           graph_grob$grobs[[gb]]$grobs[[gb2]]$layout$name,
                           fixed = TRUE)

  ##Find colours associated with each legend object
  ##Grobs of colour blobs

  #Index of grobs with key in the name
  keys <- grep("key", graph_grob$grobs[[gb]]$grobs[[gb2]]$layout$name, fixed = TRUE)

  #Index of the above index without -bg
  keys_no_bg <- grep("-bg", graph_grob$grobs[[gb]]$grobs[[gb2]]$layout$name[keys], fixed = TRUE, invert = TRUE)

  #Index of grobs with key in the name but doesn't end -bg
  col_blobs <- keys[keys_no_bg]

  for(i in 1:base::length(label_text)) {

    #Find legend text to change colour
    gb3 <- base::grep("guide.label.titleGrob.",
                  graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children)
    gb4 <- base::grep("GRID.text.",
                  graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children[[gb3]]$children)


    #Match colour up to associated blob colour
    col_for_leg_text <- graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[[col_blobs[i]]]$gp$col
    graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children[[gb3]]$children[[gb4]]$gp$col <- col_for_leg_text
  }

  if(remove_key) {
    graph_grob$grobs[[gb]]$grobs[[gb2]] <- gtable::gtable_filter(graph_grob$grobs[[gb]]$grobs[[gb2]],
                                                                 "key",
                                                                 invert = TRUE)
  }

    final_graph <- ggplotify::as.ggplot(graph_grob)
    return(final_graph)
}


