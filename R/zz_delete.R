usr <- NULL
usr <- .zz_get_key(usr = usr)

endpoints <- .zz_endpoints()

endpoints[['prod']][[2]]
endpoint <- endpoints[['dev']][[2]]

response <- httr::DELETE(url = paste0(endpoint, "71047841"),
             config = .zz_authenticate(usr),
             )

response[['status_code']]
