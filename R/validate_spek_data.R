#' @title Validate Spek and Data
#' @export

get_name_of_column <- function(col_specification) {
  col_specification[['http://www.w3.org/ns/csvw#name']][[1]][['@value']]
}

validate_spek_data <- function(spek, data) {

  #Get column names out of spek
  column_list <- spek[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]]
  if(is.null(column_list)) {
    return(TRUE)
  }
  column_names_spek <- sapply(column_list, FUN=get_name_of_column)

  #Get column names out of data
  column_names_data <- names(data)

  if(all(column_names_spek %in% column_names_data)) {
    return(TRUE)
  }

  #compare spek & data
  return(FALSE)
}
