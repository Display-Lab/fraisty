context("testing spek extractors")

full_spek <-list(
  `@id` = "http://example.com/app#example-client",
  `@type` = "http://example.com/slowmo#slowmo_0000140",
  `http://example.com/slowmo#input_table` = list(
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
      )),
      `http://purl.org/dc/terms/title` = list(list(`@value` = "Mock Performance Data"))
    )
  )
)

test_that("id column name extractor returns character vector", {
  result <- get_id_col_from_spek(full_spek)
  expect_identical(result, "performer")
})

test_that("value column name extractor returns name of value column", {
  result <- get_value_or_numerator_col_from_spek(full_spek)
  expect_identical(result, "performance")
})
