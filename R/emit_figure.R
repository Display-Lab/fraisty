#' @title Emit Figure
#' @importFrom rlang abort
#' @importFrom ggplot2 ggsave

emit_figure <- function(data, spek, summary, figure_path) {
  if(!file.exists(figure_path)) {
    rlang::abort("figure path does not exist")
  }
  column_name <- get_value_or_numerator_col_from_spek(spek)
  ggfigure <- figure_summary(data, column_name, summary)
  ggplot2::ggsave(
    filename = "fraisty_summary.png",
    plot = ggfigure,
    path = figure_path,
    device = "png",
    width = 20,
    height = 45,
    units = "cm"
  )
}
