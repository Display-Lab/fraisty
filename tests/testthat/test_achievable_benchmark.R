library(tibble)

context("Achievable benchmark")

test_data <- tibble(
  performer=as.factor(rep(1:50,2)),
  performance=seq(.01,1,by=.01),
  time=as.factor(c(rep(1,50), rep(2,50)))
)

test_data_three <- tibble(
  performer=as.factor(c("a","b","c")),
  performance=c(0.5, 0.6, 0.73),
  time=as.factor(c(1,1,1))
)

expected_achievable_benchmark <- 0.73

test_that("achievable benchmark returns a number", {
  result <- achievable_benchmark(data=test_data, id_column_name="performer", value_column_name="performance")
  expect_true(is.numeric(result))
})

test_that("achievable benchmark has expected value", {
  result <- achievable_benchmark(data=test_data, id_column_name='performer', value_column_name="performance")
  expect_equal(result, expected_achievable_benchmark)
})

test_that("achievable benchmark defaults to single performer when data has fewer than ten", {
  result <- achievable_benchmark(data=test_data_three, id_column_name='performer', value_column_name="performance")
  expect_equal(result, expected_achievable_benchmark)
})


