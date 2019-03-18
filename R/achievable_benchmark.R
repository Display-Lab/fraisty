#' @title Achievable Benchmark
#' @description Calculating the mean 10% score of performers
#' @import dplyr
#' @importFrom rlang sym
#' @importFrom stats median

achievable_benchmark <- function(data, id_column_name, value_column_name) {
  #Get average of each performer
  unique_performers <- unique(data[[id_column_name]])
  ten_percent <- floor(length(unique_performers)/10)
  if(ten_percent == 0) {
    ten_percent <- 1
  }
  value_column_symbol <- rlang::sym(value_column_name)

  #Get top 10 performers
  top_means <- data %>%
    group_by_at(.vars=id_column_name) %>%
    summarize_at(.vars=value_column_name, .funs=mean) %>%
    top_n(n=ten_percent, wt=!!value_column_symbol) %>%
    pull(!!value_column_symbol)

  #Median score of top 10 performers
  return(stats::median(top_means))
}
