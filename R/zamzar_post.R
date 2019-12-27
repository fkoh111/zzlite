library(httr)
library(jsonlite)
library(dplyr)

target <- "png"

file <- file.path(getwd(), "tests", "testthat", "testdata", "avatar.emf", fsep = .Platform$file.sep)

zamzar_post <- function(file, target) {
  
  POST(url = fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$prod$post$endpoint,
       config = authenticate(
         user = fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$usr,
         password = fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$pswd,
         type = "basic"
       ),
       body = list(source_file = upload_file(file),
                   target_format = target)
  )
}

zamzar_post(file = file, target = target)


