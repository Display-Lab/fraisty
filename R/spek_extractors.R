#' @title Spek Extractor Convenience Functions
#' @description

get_id_col_from_spek <- function(spek) {
  column_list <- get_column_list(spek)
  column_names <- sapply(column_list, FUN=get_name_of_column)
  column_uses <- sapply(column_list, FUN=get_use_of_column)

  return(column_names[which(column_uses == "identifier")])
}

get_value_or_numerator_col_from_spek <- function(spek) {
  column_list <- get_column_list(spek)
  column_names <- sapply(column_list, FUN=get_name_of_column)
  column_uses <- sapply(column_list, FUN=get_use_of_column)

  return(column_names[which(column_uses == "value" | column_uses == "numerator")])
}

get_column_list <- function(spek) {
  spek[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]]
}

get_name_of_column <- function(column_specification) {
  column_specification[['http://www.w3.org/ns/csvw#name']][[1]][['@value']]
}

get_use_of_column <- function(column_specification) {
  column_specification[['http://example.com/slowmo#ColumnUse']][[1]][['@value']]
}
