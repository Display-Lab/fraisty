library(tibble)

context("Validates Spek with Data")

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
      `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "identifier"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "timepoint")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Time")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Time at which performance was measured.")),
      `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "time"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performance")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Performance")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Demonstration performance value")),
      `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "value"))
    )
  )

test_that("returns boolean from given spek/data", {
  spek <- list()
  data <- tibble()

  result <- validate_spek_data(spek, data)
  expect_type(result, "logical")
})

test_that("spek without column specification can't pass", {
  result <- validate_spek_data(spek_missing_cols, tibble())
  expect_false(result)
})

test_that("spek with a column that is NOT present in data will fail.", {
  spek_with_columns <- spek_missing_cols
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification

  data_missing_one_column <- data_all_cols
  data_missing_one_column['performer'] <- NULL

  result <- validate_spek_data(spek_with_columns, data_missing_one_column)
  expect_false(result)
})

test_that("spek with extra column passes", {
  spek_with_columns <- spek_missing_cols
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification
  data_extra_columns <- data_all_cols
  data_extra_columns["extra"] <- c("extra", "column", "space")
  result <- validate_spek_data(spek_with_columns, data_extra_columns)
  expect_true(result)
})

test_that("spek without a identifier column fails", {
  spek_with_columns <- spek_missing_cols
  column_specification_sans_identifier <- column_specification
  column_specification_sans_identifier[[1]] <- NULL
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification_sans_identifier
  result <- validate_spek_data(spek_with_columns, data_all_cols)
  expect_false(result)
})

test_that("spek without a value OR numerator column fails", {
  spek_with_columns <- spek_missing_cols
  column_specification_sans_value <- column_specification
  column_specification_sans_value[[3]] <- NULL
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification_sans_value
  result <- validate_spek_data(spek_with_columns, data_all_cols)
  expect_false(result)
})

test_that("spek with a value OR numerator is sufficient", {
  spek_with_numerator <- spek_missing_cols
  spek_with_columns <- spek_missing_cols
  column_specification_numerator <- column_specification
  column_specification_numerator[[3]] <- list(
    `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performance")),
    `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "numerator"))
    )
  spek_with_numerator[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification_numerator
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification

  result_with_numerator <- validate_spek_data(spek_with_numerator, data_all_cols)
  result_with_value <- validate_spek_data(spek_with_columns, data_all_cols)
  expect_true(all(result_with_numerator, result_with_value))
})
