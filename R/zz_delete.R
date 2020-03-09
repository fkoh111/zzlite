usr <- NULL
usr <- .zz_get_key(usr = usr)

endpoints <- .zz_endpoints()

endpoints[['prod']][[2]]
endpoint <- endpoints[['dev']][[2]]

response <- httr::DELETE(url = paste0(endpoint, "71047841"),
             config = .zz_authenticate(usr),
             .zz_user_agent()
             )

response[['status_code']]


zz_delete <- function(id = NULL, usr = NULL, prod = FALSE) {
 
  if (is.null(id)) {
    stop("Whoops, seems like you forgot to pass an id!")
  }
  
  usr <- .zz_get_key(usr = usr)
  
  endpoints <- .zz_endpoints()
  
  if (prod == FALSE) {
    endpoint <- endpoints[['dev']][[2]]
  }
  
  if (prod == TRUE) {
    endpoint <- endpoints[['prod']][[2]]
  }
  
  response <- httr::DELETE(url = paste0(endpoint, id),
                           config = .zz_authenticate(usr),
                           .zz_user_agent()
  )
   
  if (!response[['status_code']]  == 200) {
    stop(sprintf("Zamzar responded with a status code of: %d",
                 response[['status_code']])
    )
  } else {
    message(response[['status_code']])
  }
}


zz_get_info()

zz_delete(id = 71047848)
