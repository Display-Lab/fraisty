#' @title Emit Figure
#' @importFrom rlang abort
#' @importFrom ggplot2 ggsave
#' @importFrom grDevices pdf

emit_figure <- function(data, spek, summary, figure_path) {
  if(!file.exists(figure_path)) {
    rlang::abort("figure path does not exist")
  }
  column_name <- get_value_or_numerator_col_from_spek(spek)
  ggfigure <- figure_summary(data, column_name, summary)

  # Hack to prevent 0 byte pdf artifact from being generated
  # see https://github.com/wilkelab/cowplot/issues/24
  grDevices::pdf(file=NULL)

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
