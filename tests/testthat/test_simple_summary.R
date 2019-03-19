library(tibble)

context("process data into simple summary")

data_all_cols <- tibble::tribble(
  ~performer, ~timepoint,             ~performance,
  "bob",      1, 10,
  "alice",    1, 20,
  "carol",    1, 30,
  "bob",      2, 10,
  "alice",    2, 20,
  "carol",    2, 30,
  "alice",    3, 10,
  "carol",    3, 20
)

column_specification <-
  list(
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "string")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performer")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Name")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Performer unique ID")),
      `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "identifier"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "timepoint")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Time")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Time at which performance was measured.")),
      `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "time"))
    ),
    list(
      `http://www.w3.org/ns/csvw#datatype` = list(list(`@value` = "integer")),
      `http://www.w3.org/ns/csvw#name` = list(list(`@value` = "performance")),
      `http://www.w3.org/ns/csvw#titles` = list(list(`@value` = "Performance")),
      `http://purl.org/dc/terms/description` = list(list(`@value` = "Demonstration performance value")),
      `http://example.com/slowmo#ColumnUse` = list(list(`@value` = "value"))
    )
  )

spek_with_cols <-
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
        `http://www.w3.org/ns/csvw#tableSchema` = list(list(`http://www.w3.org/ns/csvw#columns` = column_specification)),
        `http://purl.org/dc/terms/title` = list(list(`@value` = "Mock Performance Data"))
      )
    )
  )

test_that("simple summary returns list with expected members", {
  result <- simple_summary(data=data_all_cols, spek=spek_with_cols)
  expect_type(result, "list")
  expect_true(all(names(result) %in% c("num_performers","min_performer","max_performer")))
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
