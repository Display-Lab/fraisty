#' @title Simple Summary
#' @description Processes input data int num_performers, min_performer, max_performer
#' @import dplyr
simple_summary <- function(data, spek) {
  #Number of performers
  id_col_name <- get_id_col_from_spek(spek)
  performers <- data[[id_col_name]]
  unique_performers <- unique(performers)
  num_performers <- length(unique_performers)

  #Minimum measurement count of all performers
  value_or_numerator_col_name <- get_value_or_numerator_col_from_spek(spek)
  sorted_performers <- sort(performers)
  performers_counts <- rle(sorted_performers)
  min_performer <- min(performers_counts$lengths)

  #Maximum measurement count of all performers
  max_performer <- max(performers_counts$lengths)

  benchmark_ten <- achievable_benchmark(data=data,
                                        id_column_name=id_col_name,
                                        value_column_name=value_or_numerator_col_name)

  result <- list("num_performers"=num_performers,
                 "min_performer"=min_performer,
                 "max_performer"=max_performer,
                 "benchmark_ten"=benchmark_ten)
  return(result)
}
