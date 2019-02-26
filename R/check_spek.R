#' @title Check Spek
#' @export

check_spek <- function(spek) {
  INPUT_TABLE_IRI <- "http://example.com/slowmo#input_table"
  TABLE_SCHEMA_IRI <- "http://www.w3.org/ns/csvw#tableSchema"

  input_table <- spek[[INPUT_TABLE_IRI]][[1]]
  if(is.null(input_table)) {
    return(FALSE)
  }

  table_schema <- input_table[[TABLE_SCHEMA_IRI]][[1]]
  if(is.null(table_schema)) {
    return(FALSE)
  }



  return(TRUE)
}
