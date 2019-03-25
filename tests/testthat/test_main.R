context("main entry point")

test_that("main accepts the CLI parameters", {
  data_path <- PATH_TO_FIXTURE_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK

  expect_true(main(data_path, spek_path))
})

test_that("main can read from stdin", {
  spek_path <- PATH_TO_FIXTURE_SPEK
  data_file <- file(tempfile(), "w+")
  writeLines("practice, period, hd_script_ratio\n1,2,0.5\n", data_file)
  flush(data_file)

  options(fraisty.connection = data_file)
  main(data_path=NULL, spek_path)
  expect_identical(readLines(data_file), character(0))

  unlink(summary(data_file)$description)
  close(data_file)
})

test_that("main gives error when no spek is given", {
  data_path <- PATH_TO_FIXTURE_DATA

  expect_error(main(data_path, spek_path=NULL), "no spek given")
})

test_that("main gives an error when spek/data don't validate", {
  data_path <- PATH_TO_LACKING_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK

  expect_error(main(data_path=data_path, spek_path=spek_path), "spek doesn't validate with given data")
})

test_that("main emits a simple summary list to std out", {
  data_path <- PATH_TO_FIXTURE_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK
  # captured output one element per line collapsed into single string (for grepl)
  result <- capture.output(main(data_path, spek_path),type="output")
  collapsed_result <- paste0(result, collapse="\n")
  patterns <- c("num_performers", "min_performer", "max_performer", "benchmark_ten")
  pattern_found <- sapply(patterns, FUN=grepl, x=collapsed_result)
  expect_true(all(pattern_found))
})

test_that("main returns true invisibly", {
  data_path <- PATH_TO_FIXTURE_DATA
  spek_path <- PATH_TO_FIXTURE_SPEK
  # captured output one element per line collapsed into single string (for grepl)
  result <- capture.output(main(data_path, spek_path),type="output")
  collapsed_result <- paste0(result, collapse="\n")
  boolean_in_output <- grepl(pattern="TRUE", x=collapsed_result)
  expect_false(boolean_in_output)
})
