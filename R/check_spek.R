#' @title Check Spek
#' @export

check_spek <- function(spek) {

  input_table <- spek[[FR$INPUT_TABLE_IRI]][[1]]
  if(is.null(input_table)) {
    return(FALSE)
  }

  table_schema <- input_table[[FR$TABLE_SCHEMA_IRI]][[1]]
  if(is.null(table_schema)) {
    return(FALSE)
  }



  return(TRUE)
}
