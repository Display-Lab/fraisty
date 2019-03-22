# Test Setup to provide functions that provide data

# Generate a the R list structure representing a full spek.
generate_full_spek <- function(){
  list(
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
}

# Generate a the R list structure representing a spek.
generate_missing_cols_spek <- function(){
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
}

# Generate the column specification found inside a full spek.
generate_column_specification <- function(){
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
}

# Generate a table that has all the columns from the full spek above.
#   Has certain characteristics that are assumed for testing:
#     Min performers: 2, Max performers: 3, 
#     Num performers: 3, Benchmark ten: 80/3
generate_data_all_cols <- function(){
  tibble::tribble(
    ~performer, ~timepoint,             ~performance,
    "alice",    1, 20,
    "alice",    2, 20,
    "alice",    3, 10,
    "bob",      1, 10,
    "bob",      2, 10,
    "carol",    1, 30,
    "carol",    2, 30,
    "carol",    3, 20
    )
}


# On disk fixtures data and spek that are small facsimiles of actual data and spek
PATH_TO_FIXTURE_DATA <- system.file(file.path("tests", "fixtures", "sample_mtx.csv"),
                                    package = "fraisty",
                                    mustWork = T)
PATH_TO_FIXTURE_SPEK <- system.file(file.path("tests", "fixtures", "spek.json"),
                                    package = "fraisty",
                                    mustWork = T)
