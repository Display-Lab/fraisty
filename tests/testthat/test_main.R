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
  data_file <- dummy_data_file()
  spek_file <- dummy_spek_file()

  expect_silent(main(data_file, spek_file))

  close_and_unlink(data_file)
  close_and_unlink(spek_file)
})

test_that("main can read from stdin", {
  data_file <- dummy_data_file()
  spek_file <- dummy_spek_file()

  options(fraisty.connection = data_file)
  main(data_path=NULL, spek_file)
  expect_identical(readLines(data_file), character(0))

  close_and_unlink(data_file)
  close_and_unlink(spek_file)
})

test_that("main can read in spekfile", {
  data_file <- dummy_data_file()
  spek_file <- dummy_spek_file()

  main(data_file, spek_file)
  expect_identical(readLines(spek_file), character(0))

  close_and_unlink(data_file)
  close_and_unlink(spek_file)
})

test_that("main gives error when no spek is given", {
  data_file <- dummy_data_file()

  expect_error(main(data_file, spek_path=NULL), "no spek given")

  close_and_unlink(data_file)
})

