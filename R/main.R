#' @title main
#' @importFrom rlang abort
#' @export
main <- function(data_path=NULL, spek_path=NULL) {
  if(is.null(data_path)) {
    foo <- readLines(getOption("fraisty.connection", default = "stdin"))
  }
  if(is.null(spek_path)) {
    rlang::abort("no spek given")
  }
  readLines(spek_path)
  return(TRUE)
}
