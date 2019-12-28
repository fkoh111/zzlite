library(httr)
library(jsonlite)

zamzar_post <- function(file, target, prod = FALSE) {
  
  if(prod == FALSE) {
    post_endpoint <- zz_config()$dev$post$endpoint
  }
  
  if(prod == TRUE) {
    post_endpoint <- zz_config()$prod$post$endpoint
  }
  
  POST(url = post_endpoint,
       config = authenticate(
         user = zz_config()$usr,
         password = zz_config()$pswd,
         type = zz_config()$type
       ),
       body = list(source_file = upload_file(file),
                   target_format = target)
  )
}

target <- "png"
file <- file.path(getwd(), "tests", "testthat", "testdata", "avatar.emf", fsep = .Platform$file.sep)

zamzar_post(file = file, target = target)

