library(httr)
library(jsonlite)
library(dplyr)

#target <- "png"

#file <- file.path(getwd(), "tests", "testthat", "testdata", "avatar.emf", fsep = .Platform$file.sep)


#posted <- POST(url = fromJSON("inst/map.json")$prod$post$endpoint,
#                      config = authenticate(
#                        fromJSON("inst/map.json")$usr,
#                        fromJSON("inst/map.json")$pswd
#                      ),
#                      body = list(source_file = upload_file(file),
#                                  target_format = target)
#                    )


#status <- GET(fromJSON("inst/map.json")$dev$get$endpoint,
#              config = authenticate(
#                fromJSON("inst/map.json")$usr,
#                fromJSON("inst/map.json")$pswd
#              )
#            ) %>%
#  stop_for_status()


#content <- content(status, as = "text") %>%
#  fromJSON(., flatten = TRUE)


#id <- content$data$id[1]


#url <- paste0(fromJSON("inst/map.json")$dev$get$endpoint, id,"/content")

#GET(url,
#    write_disk("test.png", overwrite = TRUE),
#    config = authenticate(
#      fromJSON("inst/map.json")$usr,
#      fromJSON("inst/map.json")$pswd
#    )
#  )
