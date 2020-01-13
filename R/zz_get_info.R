# zz_get_info
#' 
#' Simple wrapper for Zamzar endpoint returning an id(s) for a posted file(s)
#' 
#'
#' Per default zz_get_info() assumes that you only want the target id for the latest 
#' assigned file. Set latest bool to FALSE to change this behaviour.
#'
#' Please note: zz_get_info() doesn't differentiate between files that have been
#' assigned to either the development or production endpoint.
#' Thus you have to keep track of this yourself.
#'
#' @param usr The username/API key you are using for Zamzar.
#' See: https://developers.zamzar.com/user
#'
#' @param latest Boolean deciding whether or not we should only return the 
#' latest target id. If switched to false, will return a list of all assigned
#' target ids 
#'
#' @export
#' @return A target id or alternatively a list of target ids
#' 
#' @import httr jsonlite
#' 
#' @examples 
#' zz_get_info()

zz_get_info <- function(usr = NULL, latest = TRUE) {
  
  endpoint <- zz_endpoint()$prod[[2]]
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }
  
  status <- httr::GET(url = endpoint,
                config = httr::authenticate(
                  user = usr,
                  password = "",
                  type = "basic"
                )
  )
  
  content <- httr::content(status, as = "text", encoding = "UTF-8")
  content_df <- jsonlite::fromJSON(content, flatten = TRUE)

  if (latest == TRUE) {
    id <- content_df$paging$first
    extension <- content_df$data$format[[1]]
    created_at <- content_df$data$created_at[[1]]
  } else {
    id <- content_df$data$id
    extension <- content_df$data$format
    created_at <- content_df$data$created_at
  }

  res <- list(id = id, extension = extension, created_at = created_at)
  
}