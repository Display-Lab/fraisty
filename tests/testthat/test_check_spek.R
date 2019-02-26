context("Test validating spek structure and content")

spek_without_schema <- list(`@id` = "http://example.com/app#example-client", `@type` = "http://example.com/slowmo#slowmo_0000140")
spek_with_schema <-
  list(`http://example.com/slowmo#input_table` = list(
    list(
      `@type` = "http://www.w3.org/ns/csvw#Table",
      `http://www.w3.org/ns/csvw#dialect` = list(
        list(
          `http://www.w3.org/ns/csvw#commentPrefix` = list(list(`@value` = "")),
          `http://www.w3.org/ns/csvw#delimiter` = list(list(`@value` = ",")),
          `http://www.w3.org/ns/csvw#doubleQuote` = list(list(`@value` = TRUE)),
          `http://www.w3.org/ns/csvw#encoding` = list(list(`@value` = "utf-8")),
          `http://www.w3.org/ns/csvw#header` = list(list(`@value` = TRUE)),
          `http://www.w3.org/ns/csvw#headerRowCount` = list(list(`@value` = "1")),
          `http://www.w3.org/ns/csvw#lineTerminators` = list(list(`@value` = "\\n")),
          `http://www.w3.org/ns/csvw#quoteChar` = list(list(`@value` = "\"")),
          `http://www.w3.org/ns/csvw#skipBlankRows` = list(list(`@value` = TRUE)),
          `http://www.w3.org/ns/csvw#skipColumns` = list(list(`@value` = 0L)),
          `http://www.w3.org/ns/csvw#skipInitialSpace` = list(list(`@value` = FALSE)),
          `http://www.w3.org/ns/csvw#skipRows` = list(list(`@value` = "")),
          `http://www.w3.org/ns/csvw#trim` = list(list(`@value` = FALSE))
        )
      ),
      `http://www.w3.org/ns/csvw#tableSchema` = list(list(
        `http://www.w3.org/ns/csvw#columns` = list(
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
      )),
      `http://purl.org/dc/terms/title` = list(list(`@value` = "Mock Performance Data"))
    )
  ))

test_that("returns false when missing table schema", {
  expect_false(check_spek(list()))
})

test_that("spek has schema", {
  expect_true(check_spek(spek_with_schema))
  expect_false(check_spek(spek_without_schema))
})

