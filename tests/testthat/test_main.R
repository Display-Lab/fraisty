context("main entry point")

dummy_data_file <- function() {
  temp_file <- file(tempfile(), "w+")
  writeLines("string, with, commas", temp_file)
  return(temp_file)
}

dummy_spek_file <- function() {
  temp_file <- file(tempfile(), "w+")
  writeLines('{"key": "value"}', temp_file)
  return(temp_file)
}

close_and_unlink <- function(conn) {
  unlink(summary(conn)$description)
  close(conn)
}

test_that("main accepts the CLI parameters", {
  data_path <- PATH_TO_FIXTURE_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK

  expect_silent(main(data_path, spek_path))
})

test_that("main can read from stdin", {
  skip("pending issue #33 to provide actual spek and data")
  spek_path <- PATH_TO_FIXTURE_SPEK
  data_file <- file(tempfile(), "w+")
  writeLines("string, with, commas\n1,2,3\n", data_file)
  flush(data_file)

  options(fraisty.connection = data_file)
  main(data_path=NULL, spek_file)
  expect_identical(readLines(data_file), character(0))

  unlink(summary(data_file)$description)
  close(data_file)
})

test_that("main gives error when no spek is given", {
  data_path <- PATH_TO_FIXTURE_DATA

  expect_error(main(data_path, spek_path=NULL), "no spek given")
})

test_that("main gives an error when spek/data don't validate", {
  data_path <- PATH_TO_FIXTURE_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK

  expect_error(main(data_path=data_path, spek_path=spek_path), "spek doesn't validate with given data")
})

test_that("main emits a simple summary list to std out", {
  data_path <- PATH_TO_FIXTURE_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK
  result <- capture.output(fraisty::main(data_path, spek_path),type="output")

  expect_type(result, 'character')
})
