#' @export
#' @importFrom ggplot2 ggplotGrob ggplot_build
#' @importFrom ggplotify as.ggplot
#' @importFrom gtable gtable_filter
#' @keywords internal
#'
#' @name updateGrob
#' @param x A ggplot2 graph.
#' @param remove_key Boolean to whether to remove the key from the legend. True
#' to remove.
#'
#' @title Updates the grob object

updateGrob <- function(x, remove_key = TRUE) {
  graph_grob <- ggplot2::ggplotGrob(x)

  #Find all the legend text
  gb <- base::grep("guide-box",
                   graph_grob$layout$name,
                   fixed = TRUE)

  if(length(gb) == 0) {
    stop("No guide-box element found in the grob of the ggplot")
  }

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
    #grab fill of key, but grab first 7 characters of fill
    # as 8 and 9 are alpha values, not the rgb part of the hex code
    col_for_leg_text <- base::substr(
      x = graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[[col_blobs[i]]]$gp$fill,
      start = 1,
      stop = 7)
    #if fill doesn't exist, then grab col
    col_for_leg_text <- base::ifelse(
      is.na(col_for_leg_text),
      graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[[col_blobs[i]]]$gp$col,
      col_for_leg_text
    )

    #If it is still NA, just keep text black
    col_for_leg_text <- base::ifelse(
      is.na(col_for_leg_text),
      "#000000",
      col_for_leg_text
    )
    graph_grob$grobs[[gb]]$grobs[[gb2]]$grobs[label_text][[i]]$children[[gb3]]$children[[gb4]]$gp$col <- col_for_leg_text
  }

  if(remove_key) {
    graph_grob$grobs[[gb]]$grobs[[gb2]] <- gtable::gtable_filter(
      graph_grob$grobs[[gb]]$grobs[[gb2]],
      "key",
      invert = TRUE
    )
  }

  return(graph_grob)
}
