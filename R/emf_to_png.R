library(httr)
library(jsonlite)
library(dplyr)

test_endpoint <- "https://api.zamzar.com/v1/formats/gif"
file_path <- file.path(getwd(), "tests", "testthat", "testdata", "avatar.emf", fsep = .Platform$file.sep)
target <- "png"
endpoint <- "https://api.zamzar.com/v1/jobs"
file <- file.path(file_path, fsep = .Platform$file.sep)


response_get <- GET(test_endpoint, config = authenticate(key, "")) %>%
  print()


response_post <- POST(url = endpoint, config = authenticate(key, ""), body = list(
  source_file = upload_file(file), target_format = "png"
)) %>%
  print()


response_post_get <- GET(endpoint, config = authenticate(key, "")) %>%
  print()
