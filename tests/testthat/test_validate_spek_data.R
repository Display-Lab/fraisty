library(tibble)

context("Validates Spek with Data")

spek_missing_cols <- generate_missing_cols_spek()

column_specification <- generate_column_specification()

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

  data_missing_one_column <- generate_data_all_cols()
  data_missing_one_column['performer'] <- NULL

  result <- validate_spek_data(spek_with_columns, data_missing_one_column)
  expect_false(result)
})

test_that("spek with extra column passes", {
  spek_with_columns <- spek_missing_cols
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification
  data_extra_columns <- generate_data_all_cols()
  data_extra_columns["extra"] <- rep("extra", nrow(data_extra_columns) )
  result <- validate_spek_data(spek_with_columns, data_extra_columns)
  expect_true(result)
})

test_that("spek without a identifier column fails", {
  spek_with_columns <- spek_missing_cols
  column_specification_sans_identifier <- column_specification
  column_specification_sans_identifier[[1]] <- NULL
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification_sans_identifier
  result <- validate_spek_data(spek_with_columns, generate_data_all_cols())
  expect_false(result)
})

test_that("spek without a value OR numerator column fails", {
  spek_with_columns <- spek_missing_cols
  column_specification_sans_value <- column_specification
  column_specification_sans_value[[3]] <- NULL
  spek_with_columns[[FR$INPUT_TABLE_IRI]][[1]][[FR$TABLE_SCHEMA_IRI]][[1]][[FR$COLUMNS_IRI]] <- column_specification_sans_value
  result <- validate_spek_data(spek_with_columns, generate_data_all_cols())
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

  result_with_numerator <- validate_spek_data(spek_with_numerator, generate_data_all_cols())
  result_with_value <- validate_spek_data(spek_with_columns, generate_data_all_cols())
  expect_true(all(result_with_numerator, result_with_value))
})
