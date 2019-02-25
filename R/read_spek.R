#' @title Read in Spek
#' @importFrom rlang abort
#' @importFrom readr read_file
#' @importFrom jsonld jsonld_expand
#' @importFrom jsonlite fromJSON parse_json
#' @export

read_spek <- function(path) {
  if(is.null(path) || nchar(path) == 0) {
    rlang::abort("no path provided")
  }

  if(!file.exists(path)) {
    rlang::abort("file not found")
  }

  spek_str <- readr::read_file(path)
  parsing_result <- tryCatch(jsonlite::parse_json(spek_str), error = parse_error_handler)
  if(is.integer(parsing_result)) {
    rlang::abort("file not json")
  }
  expanded <- jsonld::jsonld_expand(spek_str)
  converted <- jsonlite::fromJSON(expanded, simplifyDataFrame = F)

  return(converted)
}


#' @title Handler for Parsing Error
#' @param condition error condition object
parse_error_handler <- function(condition) {
  rlang::abort("file not json")
}
