context("data read-in functionality")

csv_str <- "header1,header2,header3\n1,2,3\n4,5,6\n7,8,9"
tmp_csv_path <- tempfile()

setup({
  writeLines(csv_str, tmp_csv_path)
})

teardown({
  unlink(tmp_csv_path)
})

test_that("throw error when no path is provided", {
  expect_error(read_data(NULL), "no path provided")
  expect_error(read_data(""), "no path provided")
})

test_that("accepts path parameter and returns tibble", {
  expect_s3_class(read_data(tmp_csv_path), "tbl_df")
})
