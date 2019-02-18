#' @title main
#' @export
main <- function (){
  readLines( getOption("fraisty.connection", default="stdin") )
  invisible(TRUE)
}