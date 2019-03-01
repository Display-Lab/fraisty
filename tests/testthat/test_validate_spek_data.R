library(tibble)
context("Validates Spek with Data")

INPUT_TABLE_IRI <- "http://example.com/slowmo#input_table"
TABLE_SCHEMA_IRI <- "http://www.w3.org/ns/csvw#tableSchema"
MEASURE_IRI <- "http://example.com/slowmo#measure"
COLUMNS_IRI <- "http://www.w3.org/ns/csvw#columns"
TABLE_IRI <- "http://www.w3.org/ns/csvw#Table"
DIALECT_IRI <- "http://www.w3.org/ns/csvw#dialect"

data_all_cols <- tibble::tribble(
  ~performer, ~timepoint,             ~performance,
  "bob",      1, 10,
  "alice",    2, 20,
  "carol",    3, 30
)

spek_missing_cols <-
  list(
    `http://example.com/slowmo#measure` = list(
      list(
        `http://purl.org/dc/terms/title` = list(list(`@value` = "Generic Performance")),
        `http://example.com/slowmo#guideline` = list(list(`@value` = 10L))
      )
    ),
    `http://example.com/slowmo#input_table` = list(
      list(
        `@type` = "http://www.w3.org/ns/csvw#Table",
        `http://www.w3.org/ns/csvw#tableSchema` = list(structure(list(), .Names = character(0))),
        `http://purl.org/dc/terms/title` = list(list(`@value` = "Mock Performance Data"))
      )
    )
  )

column_specification <-
  list(
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "string")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performer")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Name")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Performer unique ID")),
      `http://example.com/slowmo#use` = list(list(`@value` = "identifier"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "timepoint")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Time")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Time at which performance was measured.")),
      `http://example.com/slowmo#use` = list(list(`@value` = "time"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performance")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Performance")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Demonstration performance value")),
      `http://example.com/slowmo#use` = list(list(`@value` = "value"))
    )
  )

test_that("returns boolean from given spek/data", {
  spek <- list()
  data <- tibble()

  result <- validate_spek_data(spek, data)
  expect_type(result, "logical")
})

test_that("spek without column specification can't fail", {
  result <- validate_spek_data(spek_missing_cols, tibble())
  expect_true(result)
})

test_that("spek missing a column will fail", {
  missing_col <- column_specification
  missing_col[3] <- NULL
  spek_missing_one_column <- spek_missing_cols
  spek_missing_one_column[[INPUT_TABLE_IRI]][[1]][[TABLE_SCHEMA_IRI]][[1]][[COLUMNS_IRI]] <- missing_col
  result <- validate_spek_data(spek_missing_one_column, data_all_cols)
  expect_false(result)
})

test_that("speak with extra column passes", {
  spek_with_columns <- spek_missing_cols
  spek_with_columns[[INPUT_TABLE_IRI]][[1]][[TABLE_SCHEMA_IRI]][[1]][[COLUMNS_IRI]] <- column_specification
  data_extra_columns <- data_all_cols
  data_extra_columns["extra"] <- c("extra", "column", "space")
  result <- validate_spek_data(spek_with_columns, data_extra_columns)
  expect_true(result)
})
