context("spek read-in functionality")

dummy_spek_file <- function() {
  temp_file <- file(tempfile(), "w+")
  writeLines('{"key": "value"}', temp_file)
  return(temp_file)
}

empty_spek <- tempfile()
not_json <- tempfile()
not_json_int <- tempfile()

setup({
  writeLines("{}", empty_spek)
  writeLines("not json", not_json)
  writeLines("123", not_json_int)
})

teardown({
  unlink(empty_spek)
  unlink(not_json_int)
  unlink(not_json)
})

test_that("accepts path parameter and returns list", {
  result <- read_spek(empty_spek)
  expect_type(result, "list")
})

test_that("throw error when no path is provided", {
  expect_error(read_spek(NULL), "no path provided")
  expect_error(read_spek(""), "no path provided")
})

test_that("throw error if file is not found", {
  dummy_path <- "foo"
  expect_error(read_spek(dummy_path), "file not found")
})

test_that("throw error if file is not json", {
  expect_error(read_spek(not_json_int), "file not json")
  expect_error(read_spek(not_json), "file not json")
})
