library(tibble)

context("process data into simple summary")

data_all_cols <- generate_data_all_cols()
spek_with_cols <- generate_full_spek()

test_that("simple summary returns list with expected members", {
  result <- simple_summary(data=data_all_cols, spek=spek_with_cols)
  expect_type(result, "list")
  expect_true(all(names(result) %in% c("num_performers","min_performer","max_performer", "benchmark_ten")))
})

test_that("simple summary reports number of performers", {
  result <- simple_summary(data=data_all_cols, spek=spek_with_cols)
  expect_equal(result$num_performers, 3)
})

test_that("simple summary reports minimum number of observations of all performer", {
  result <- simple_summary(data=data_all_cols, spek=spek_with_cols)
  expect_equal(result$min_performer, 2)
})

test_that("simple summary reports maximum number of observations of all performer", {
  result <- simple_summary(data=data_all_cols, spek=spek_with_cols)
  expect_equal(result$max_performer, 3)
})

test_that("simple summary includes achievable benchmark", {
  result <- simple_summary(data=data_all_cols, spek=spek_with_cols)
  expect_equal(result$benchmark_ten, 80/3)
})
