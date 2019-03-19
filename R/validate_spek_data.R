#' @title Validate Spek and Data
#' @export

validate_spek_data <- function(spek, data) {
  #Get column names out of spek
  column_list <- get_column_list(spek)
  if(is.null(column_list)) {
    return(FALSE)
  }

  #Extract parts of the spek (using IRI's)
  column_names_spek <- sapply(column_list, FUN=get_name_of_column)
  column_uses <- sapply(column_list, FUN=get_use_of_column)

  #Check that column names in spek are found in the data
  column_names_data <- names(data)
  check1 <- all(column_names_spek %in% column_names_data)

  #Check that column with an identifier use exists
  check2 <- any(column_uses %in% c("identifier"))

  #Check that a column with a value OR numerator exists
  check3 <- any(column_uses %in% c("value", "numerator"))

  return(all(check1, check2, check3))
}
