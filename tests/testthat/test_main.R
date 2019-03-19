context("main entry point")

dummy_data_path <- function() {
  temp_path <- tempfile()
  temp_file <- file(temp_path, "w+")
  writeLines("string, with, commas\n1,2,3\n", temp_file)
  close(temp_file)
  return(temp_path)
}

dummy_spek_path <- function() {
  spek_path <- tempfile()
  temp_file <- file(spek_path, "w+")
  writeLines('{"key": "value"}', temp_file)
  close(temp_file)
  return(spek_path)
}

test_that("main accepts the CLI parameters", {
  skip("pending issue #33 to provide actual spek and data")
  data_path <- dummy_data_path()
  spek_path <- dummy_spek_path()

  expect_silent(main(data_path, spek_path))

  unlink(data_path)
  unlink(spek_path)
})

test_that("main can read from stdin", {
  skip("pending issue #33 to provide actual spek and data")
  spek_path <- dummy_spek_path()
  data_file <- file(tempfile(), "w+")
  writeLines("string, with, commas\n1,2,3\n", data_file)
  flush(data_file)

  options(fraisty.connection = data_file)
  main(data_path=NULL, spek_path)
  expect_identical(readLines(data_file), character(0))

  unlink(summary(data_file)$description)
  close(data_file)
  unlink(spek_path)
})

test_that("main gives error when no spek is given", {
  data_path <- dummy_data_path()

  expect_error(main(data_path, spek_path=NULL), "no spek given")

  unlink(data_path)
})

test_that("main gives an error when spek/data don't validate", {
  data_path <- dummy_data_path()
  spek_path <- dummy_spek_path()

  expect_error(main(data_path=data_path, spek_path=spek_path), "spek doesn't validate with given data")

  unlink(data_path)
  unlink(spek_path)
})

test_that("main emits a simple summary list to std out", {
  skip("pending issue #33 to provide actual spek and data")

  data_path <- dummy_data_path()
  spek_path <- dummy_spek_path()
  result <- capture.output(fraisty::main(data_path, spek_path),type="output")

  expect_type(result, 'character')

  unlink(data_path)
  unlink(spek_path)
})



