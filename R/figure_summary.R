#' @title Figure Summary
#' @importFrom dplyr pull
#' @importFrom rlang sym
#' @importFrom ggplot2 ggplot
#' @importFrom ggplot2 geom_histogram
#' @importFrom ggplot2 aes
#' @importFrom ggplot2 labs
#' @importFrom cowplot plot_grid
#' @importFrom grDevices pdf

figure_summary <- function(data, column_name, summary) {
  column_sym <- rlang::sym(column_name)
  max_value <- max(data %>% pull(!!column_sym))
  bin_width_ten <- max_value / 10
  bin_width_twenty <- max_value / 5
  bin_width_ab <- summary$benchmark_ten / 20

  # Hack to prevent 0 byte pdf artifact from being generated
  # see https://github.com/wilkelab/cowplot/issues/24
  grDevices::pdf(file=NULL)

  gg10 <- ggplot2::ggplot(data=data, ggplot2::aes(x=!!column_sym)) +
    ggplot2::geom_histogram(binwidth=bin_width_ten, color="skyblue", fill="blue") +
    ggplot2::labs(title="Bin Width 10%")
  gg20 <- ggplot2::ggplot(data=data, ggplot2::aes(x=!!column_sym)) +
    ggplot2::geom_histogram(binwidth=bin_width_twenty, color="skyblue", fill="blue") +
    ggplot2::labs(title="Bin Width 20%")
  ggab <-  ggplot2::ggplot(data=data, ggplot2::aes(x=!!column_sym)) +
    ggplot2::geom_histogram(binwidth=bin_width_twenty, color="skyblue", fill="blue") +
    ggplot2::labs(title="Bin Width 5% of Benchmark") +
    ggplot2::geom_vline(xintercept = summary$benchmark_ten, color="green")
  cowplot::plot_grid(gg10, gg20, ggab, ncol=1)
}
