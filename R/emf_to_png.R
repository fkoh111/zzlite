library(httr)
library(jsonlite)
library(dplyr)

target <- "png"

file_path <- file.path(getwd(), "tests", "testthat", "testdata", "avatar.emf", fsep = .Platform$file.sep)


posted <- POST(url = fromJSON("inst/map.json")$dev$post$endpoint,
                      config = authenticate(
                        fromJSON("inst/map.json")$user,
                        fromJSON("inst/map.json")$pswd
                      ),
                      body = list(source_file = upload_file(file),
                                  target_format = target)
                    )


status <- GET(endpoint,
              config = authenticate(
                fromJSON("inst/map.json")$user,
                fromJSON("inst/map.json")$pswd
              )
            ) %>%
  stop_for_status()


content <- content(status, as = "text") %>%
  fromJSON(., flatten = TRUE)


id <- content$data$target_files[[1]][[1]]


url <- paste0(fromJSON("inst/map.json")$dev$get$endpoint, id,"/content")

GET(url,
    write_disk("test.png", overwrite = TRUE),
    config = authenticate(
      fromJSON("inst/map.json")$user,
      fromJSON("inst/map.json")$pswd
    )
  )
