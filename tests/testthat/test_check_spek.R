context("Test validating spek structure and content")

spek_without_schema <- list(`@id` = "http://example.com/app#example-client", 
                            `@type` = "http://example.com/slowmo#slowmo_0000140")
spek_with_schema <- generate_full_spek()

test_that("returns false when missing table schema", {
  expect_false(check_spek(list()))
})

test_that("spek has schema", {
  expect_true(check_spek(spek_with_schema))
  expect_false(check_spek(spek_without_schema))
})

