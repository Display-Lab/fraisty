#' @title Validate Spek and Data
#' @export

INPUT_TABLE_IRI <- "http://example.com/slowmo#input_table"
TABLE_SCHEMA_IRI <- "http://www.w3.org/ns/csvw#tableSchema"
MEASURE_IRI <- "http://example.com/slowmo#measure"
COLUMNS_IRI <- "http://www.w3.org/ns/csvw#columns"
TABLE_IRI <- "http://www.w3.org/ns/csvw#Table"
DIALECT_IRI <- "http://www.w3.org/ns/csvw#dialect"

get_name_of_column <- function(col_specification) {
  col_specification[[1]][['http://www.w3.org/ns/csvw#name']][[1]][['@value']]
}

validate_spek_data <- function(spek, data) {

  #Get column names out of spek
  column_list <- spek[[INPUT_TABLE_IRI]][[1]][[TABLE_SCHEMA_IRI]][[1]][[COLUMNS_IRI]]
  if(is.null(column_list)) {
    return(TRUE)
  }

  column_names_spek <- sapply(column_list, FUN=get_name_of_column)

  #Get column names out of data
  column_names_data <- names(data)
  print(spek)

  print("column from spek")
  print(column_names_spek)

  if(all(column_names_spek %in% column_names_data)) {
    return(TRUE)
  }

  #compare spek & data
  return(FALSE)
}
