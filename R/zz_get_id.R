# zz_get_id
#' 
#' Simple wrapper for Zamzar endpoint returning an id(s) for a posted file(s)
#' 
#' 
#' Per default zz_get_id assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' Per default zz_get_id assumes that you only want the id for the latest 
#' assigned file. Set latest bool to FALSE to change this behaviour.
#'
#'
#' @param usr The username/API key you are using for Zamzar. See: https://developers.zamzar.com/user
#'
#' @param prod Boolean deciding whether to use a production endpoint or
#' a development endpoint. Defaults to FALSE (That is, development endpoint).
#'
#' @param latest Boolean deciding whether or not we should only return the 
#' latest id. If switched to false, will return a list of all assigned ids 
#'
#' @export
#' @return An id or alternatively a list of ids
#' 
#' @import httr dplyr jsonlite
#' 
#' @examples 
#' zz_get_id()

zz_get_id <- function(usr = NULL, prod = FALSE, latest = TRUE) {
  
  if (prod == FALSE) {
    files_endpoint <- "https://sandbox.zamzar.com/v1/files"
  } 
  
  if (prod == TRUE) {
    files_endpoint <- "https://api.zamzar.com/v1/files"
  }
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }
  
  status <- httr::GET(url = files_endpoint,
                config = httr::authenticate(
                  user = usr,
                  password = "",
                  type = "basic"
                )
  )
  
  content <- httr::content(status, as = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(., flatten = TRUE)
  
  if (latest == TRUE) {
    content$paging$first
  } else {
    content$data$id
  }

}