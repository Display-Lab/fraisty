INPUT_TABLE_IRI <- "http://example.com/slowmo#input_table"
TABLE_SCHEMA_IRI <- "http://www.w3.org/ns/csvw#tableSchema"
MEASURE_IRI <- "http://example.com/slowmo#measure"
COLUMNS_IRI <- "http://www.w3.org/ns/csvw#columns"
TABLE_IRI <- "http://www.w3.org/ns/csvw#Table"
DIALECT_IRI <- "http://www.w3.org/ns/csvw#dialect"

#' @title Validate Spek and Data
#' @description Validates that the spek and the data are copacetic.
#'   Answers the question, do the columns described in the spek match the those in the data?
#' @param spek list representation of rdf spek
#' @param data tibble of performance data
#' @return logical TRUE for the columns described the spek are valid with the data.  FALSE otherwise.
#' @export
validate_spek_data <- function(spek, data) {
  column_list <- spek[[INPUT_TABLE_IRI]][[1]][[TABLE_SCHEMA_IRI]][[1]][[COLUMNS_IRI]]
  # No column information means no column requirements to invalidate the data.
  if(is.null(column_list)) {
    return(TRUE)
  }

  #Get column names out of data and spek
  column_names_data <- names(data)
  column_names_spek <- sapply(column_list, FUN=get_name_of_column)

  # Check that all of the column names from the spek show up in the data column names.
  if(all(column_names_spek %in% column_names_data)) {
    return(TRUE)
  }

  return(FALSE)
}

#' @title Get Column Names from Spek
#' @describeIn Validate Spek and Data
#' @description Internal function. If the spek contains a table schema with columns, return the names of the columns
#' @param spek Spek with table schema
#' @return vector of column names
get_name_of_column <- function(col_specification) {
  col_specification[['http://www.w3.org/ns/csvw#name']][[1]][['@value']]
}

