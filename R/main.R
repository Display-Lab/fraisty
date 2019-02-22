#' @title main
#' @export
main <- function(data_path=NULL, spek_path=NULL) {
  if(is.null(data_path)) {
    foo <- readLines(getOption("fraisty.connection", default = "stdin"))
  }
  return(TRUE)
}
