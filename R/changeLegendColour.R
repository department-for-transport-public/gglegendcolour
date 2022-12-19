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

  ##Build plot to extract deets from it
  g <- ggplot2::ggplot_build(x)

  ##Check which of the scales contains the colours
  proto <- c()
    for(i in 1:length(g$plot$scales$scales)){

    if(!is.null(g$plot$scales$scales[[i]]$palette.cache)){

      proto <- c(proto, i)
      break()

      }
  }

  if(is.null(g$plot$scales$scales[[proto]]$palette.cache)) {
    stop("You must choose options for the colour/fill in your ggplot2 object.")
  }

  ##Extract names and colours automagically from plot if available from palette cache

  leg_font_colour <- base::data.frame(
    leg_text = g$plot$scales$scales[[proto]]$get_labels(),
    col = base::unname(g$plot$scales$scales[[proto]]$palette.cache[1:length(g$plot$scales$scales[[proto]]$get_labels())])
  )

  if(base::length(g$plot$scales$scales[[proto]]$labels) > 0) {
    new_leg_text <- base::data.frame(
      leg_text = base::names(g$plot$scales$scales[[proto]]$labels),
      new_leg_text = base::unname(g$plot$scales$scales[[proto]]$labels)
    )

    leg_font_colour <- base::merge(leg_font_colour, new_leg_text, by = "leg_text", all.x = TRUE)
    leg_font_colour$new_leg_text[is.na(leg_font_colour$new_leg_text)] <- leg_font_colour$leg_text[is.na(leg_font_colour$new_leg_text)]
    colnames(leg_font_colour)[colnames(leg_font_colour) == "leg_text"] <- "old_leg_text"
    colnames(leg_font_colour)[colnames(leg_font_colour) == "new_leg_text"] <- "leg_text"
  }

  #Find all the legend text
  gb <- base::grep("guide-box",
                   graph_grob$layout$name)
  gb2 <- base::grep("guides",
                    graph_grob$grobs[[gb]]$layout$name)
  label_text <- base::grep("label",
                           graph_grob$grobs[[gb]]$grobs[[gb2]]$layout$name)

  for(i in 1:base::length(label_text)) {

    #Find legend text to change colour
    gb3 <- base::grep("guide.label.titleGrob.",
                  graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children)
    gb4 <- base::grepl("GRID.text.",
                  graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children[[gb3]]$children)

    leg_text_to_match <- graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children[[gb3]]$children[[gb4]]$label

    #Get colour for legend text
    col_for_leg_text <- leg_font_colour[leg_font_colour$leg_text == leg_text_to_match, "col"]
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


