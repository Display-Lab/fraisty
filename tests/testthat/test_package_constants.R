context("package constants environment provides a string")

test_that("package constant environment returns a string", {

  expect_type(FR$INPUT_TABLE_IRI, "character")
})
