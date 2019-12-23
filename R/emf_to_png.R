library(httr)
library(jsonlite)
library(dplyr)

test_endpoint <- "https://sandbox.zamzar.com/v1/formats/gif"
file_path <- file.path(getwd(), "tests", "testthat", "testdata", "avatar.emf", fsep = .Platform$file.sep)
target <- "png"
#endpoint <- "https://api.zamzar.com/v1/jobs"
endpoint <- "https://sandbox.zamzar.com/v1/jobs"


posted <- POST(url = endpoint,
                      config = authenticate(fromJSON("inst/key.json")$username, ""),
                      body = list(source_file = upload_file(file), target_format = "png")
                      )


status <- GET(endpoint, config = authenticate(fromJSON("inst/key.json")$username, "")) %>%
  stop_for_status()

content <- content(status, as = "text") %>%
  fromJSON(., flatten = TRUE)

id <- content$data$target_files[[1]][[1]]

url <- paste0("https://sandbox.zamzar.com/v1/files/", id,"/content")

GET("https://sandbox.zamzar.com/v1/files/63569934/content", write_disk("test.png", overwrite = TRUE), config = authenticate(fromJSON("inst/key.json")$username, ""))
