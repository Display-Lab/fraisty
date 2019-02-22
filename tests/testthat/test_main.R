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

test_that("main accepts the CLI parameters", {
  data_file <- dummy_data_file()
  spek_file <- dummy_spek_file()
  expect_silent(main(data_file, spek_file))
  unlink(summary(data_file)$description)
  unlink(summary(spek_file)$description)
})

test_that("main can read from stdin", {
  data_file <- dummy_data_file()
  spek_file <- dummy_spek_file()

  options(fraisty.connection = data_file)
  main(data_path=NULL, spek_file)
  expect_identical(readLines(data_file), character(0))

  unlink(summary(data_file)$description)
  unlink(summary(spek_file)$description)
})

test_that("main can read in spekfile", {
  data_file <- dummy_data_file()
  spek_file <- dummy_spek_file()

  main(data_file, spek_file)
  expect_identical(readLines(spek_file), character(0))

  unlink(summary(data_file)$description)
  unlink(summary(spek_file)$description)
})

test_that("main gives error when no spek is given", {
  data_file <- dummy_data_file()

  expect_error(main(data_file, spek_path=NULL), "no spek given")


  unlink(summary(data_file)$description)
})

