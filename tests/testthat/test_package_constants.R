context("package constants environment provides a string")

INPUT_TABLE_IRI <- "http://example.com/slowmo#input_table"
TABLE_SCHEMA_IRI <- "http://www.w3.org/ns/csvw#tableSchema"
MEASURE_IRI <- "http://example.com/slowmo#measure"
COLUMNS_IRI <- "http://www.w3.org/ns/csvw#columns"
TABLE_IRI <- "http://www.w3.org/ns/csvw#Table"
DIALECT_IRI <- "http://www.w3.org/ns/csvw#dialect"

test_that("package constant environment returns a string", {

  expect_type(FR$INPUT_TABLE_IRI, "character") #returning a character not string
})
