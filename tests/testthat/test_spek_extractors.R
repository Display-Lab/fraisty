context("testing spek extractors")

test_that("id column name extractor returns character vector", {
  result <- get_id_col_from_spek(generate_full_spek())
  expect_identical(result, "performer")
})

test_that("value column name extractor returns name of value column", {
  result <- get_value_or_numerator_col_from_spek(generate_full_spek())
  expect_identical(result, "performance")
})
