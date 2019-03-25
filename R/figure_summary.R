#' @title Figure Summary
#' @importFrom dplyr pull
#' @importFrom rlang sym
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_histogram
#' @importFrom ggplot2 aes
#' @importFrom cowplot plot_grid

figure_summary <- function(data, column_name) {
  column_sym <- rlang::sym(column_name)
  max_value <- max(data %>% pull(!!column_sym))
  bin_width_ten <- max_value / 10
  bin_width_twenty <- max_value / 5

  gg10 <- ggplot2::ggplot(data=data, ggplot2::aes(x=!!column_sym)) +
            ggplot2::geom_histogram(binwidth=bin_width_ten)
  gg20 <- ggplot2::ggplot(data=data, ggplot2::aes(x=!!column_sym)) +
            ggplot2::geom_histogram(binwidth=bin_width_twenty)
  cowplot::plot_grid(gg10, gg20, ncol=1)
}
