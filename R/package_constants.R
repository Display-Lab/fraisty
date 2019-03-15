#' @title Package Level Environment
#' @export

# top level config environment
FR <- new.env()


FR$INPUT_TABLE_IRI <- "http://example.com/slowmo#input_table"
FR$TABLE_SCHEMA_IRI <- "http://www.w3.org/ns/csvw#tableSchema"
FR$MEASURE_IRI <- "http://example.com/slowmo#measure"
FR$COLUMNS_IRI <- "http://www.w3.org/ns/csvw#columns"
FR$TABLE_IRI <- "http://www.w3.org/ns/csvw#Table"
FR$DIALECT_IRI <- "http://www.w3.org/ns/csvw#dialect"
