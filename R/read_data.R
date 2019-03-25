#' @title Read in spek
#' @importFrom rlang abort
#' @importFrom readr read_csv cols
#' @export

read_data <- function(path) {
  if(is.null(path) || nchar(path) == 0) {
    rlang::abort("no path provided")
  }

  # Explicitly use guessing of col_types to avoid warning.
  readr::read_csv(path, col_types = readr::cols())
}
