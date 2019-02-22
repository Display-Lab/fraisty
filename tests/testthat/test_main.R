context("main entry point")

test_that("main function runs silently", {
  temp_path <- tempfile()
  temp_file <- file(temp_path)
  expect_silent(main(temp_file))
  unlink(temp_file)
})

test_that("main accepts the CLI parameters", {
  expect_silent(main(data_path = "noop", spek_path = "foo"))
})

test_that("main can read from stdin", {
  temp_file <- file()
  writeLines("mary had a little lamb", temp_file)
  options(fraisty.connection = temp_file)
  main(data_path=NULL)
  text_remaining <- readLines(temp_file)
  expect_identical(text_remaining, character(0))
})
