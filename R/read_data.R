#' @title Read in spek
#' @importFrom rlang abort
#' @importFrom readr read_csv
#' @export

read_data <- function(path) {
  if(is.null(path) || nchar(path) == 0) {
    rlang::abort("no path provided")
  }

  read_csv(path)
}
