context("Ouputs figure summary")
library('tibble')

test_that("Figure summary takes in data and column name", {
  data <- tibble('ids'=1:10, 'performance'=seq(1, 100, by=10))
  column_name <- "performance"
  summary <- list("benchmark_ten"=50)
  result <- figure_summary(data, column_name, summary)
  expect_s3_class(result, "ggplot")
})
