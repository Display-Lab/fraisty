context("Validates Spek with Data")

library(tibble)

spek_missing_cols <-
  list(
    `http://example.com/slowmo#measure` = list(
      list(
        `http://purl.org/dc/terms/title` = list(list(`@value` = "Generic Performance")),
        `http://example.com/slowmo#guideline` = list(list(`@value` = 10L))
      )
    ),
    `http://example.com/slowmo#input_table` = list(
      list(
        `@type` = "http://www.w3.org/ns/csvw#Table",
        `http://www.w3.org/ns/csvw#tableSchema` = list(structure(list(), .Names = character(0))),
        `http://purl.org/dc/terms/title` = list(list(`@value` = "Mock Performance Data"))
      )
    )
  )

spek_with_cols <-
  list(
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "string")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performer")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Name")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Performer unique ID")),
      `http://example.com/slowmo#use` = list(list(`@value` = "identifier"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "timepoint")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Time")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Time at which performance was measured.")),
      `http://example.com/slowmo#use` = list(list(`@value` = "time"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performance")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Performance")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Demonstration performance value")),
      `http://example.com/slowmo#use` = list(list(`@value` = "value"))
    )
  )

test_that("returns boolean from given spek/data", {
  spek <- list()
  data <- tibble()

  result <- validate_spek_data(spek, data)
  expect_type(result, "logical")
})

test_that("spek without column specification can't fail", {

})
