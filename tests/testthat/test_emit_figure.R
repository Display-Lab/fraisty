context("test emit figure")

test_that("emits error if figure path does not exist", {
  data <- generate_data_all_cols()
  spek <- generate_full_spek()
  summary <- list("benchmark_ten"=50)
  figure_path <- file.path("does", "not", "exist")
  expect_error(emit_figure(data, spek, summary, figure_path), "figure path does not exist")
})

test_that("emits .png to specified directory", {
  data <- generate_data_all_cols()
  spek <- generate_full_spek()
  summary <- list("benchmark_ten"=50)
  figure_path <- tempdir(check=TRUE)
  emit_figure(data, spek, summary, figure_path)
  expect_true(file.exists(file.path(figure_path, "fraisty_summary.png")))
  unlink(file.path(figure_path, "fraisty_summary.png"))
})
