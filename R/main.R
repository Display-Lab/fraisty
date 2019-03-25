#' @title main
#' @importFrom rlang abort
#' @export
main <- function(data_path=NULL, spek_path=NULL) {
  if(is.null(data_path)) {
    data_conn <- getOption("fraisty.connection", default = "stdin")
    raw_data <- paste(collapse = "\n", readLines(data_conn))
    data <- read_data(raw_data)
  } else {
    data <- read_data(data_path)
  }
  if(is.null(spek_path)) {
    rlang::abort("no spek given")
  }
  spek <- read_spek(spek_path)
  if(!validate_spek_data(spek, data)) {
    rlang::abort("spek doesn't validate with given data")
  }
  summary <- simple_summary(data=data, spek=spek)
  print(format(summary))
  return(invisible(TRUE))
}
