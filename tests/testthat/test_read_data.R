context("data read-in functionality")

csv_str <- "header1,header2,header3\n1,2,3\n4,5,6\n7,8,9"
tmp_csv_path <- tempfile()
writeLines(csv_str, tmp_csv_path)
read.csv(tmp_csv_path)


test_that("throw error when no path is provided", {
  expect_error(read_spek(NULL), "no path provided")
  expect_error(read_spek(""), "no path provided")
})

test_that("accepts path parameter and returns tibble", {
  expect_s4_class(read_data(tmp_csv_path), "tbl_df")
})
