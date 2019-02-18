context("main entry point")

test_that("main function runs silently", {
  expect_silent(main())
})

test_that("main accepts the CLI parameters", {
  expect_silent(main(data_path = "noop", spek_path = "foo"))
})
