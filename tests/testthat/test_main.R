context("testmain")


test_that("main reads from options connection", {
  tmp_file <- file()
  writeLines("foo\n\bar\nbaz", tmp_file)
  
  options(fraisty.connection=tmp_file)
  main()
  expect_identical(readLines(tmp_file), character(0))
})