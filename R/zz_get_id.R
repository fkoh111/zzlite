# zz_get_id
#' 
#' Simple wrapper for Zamzar endpoint returning an id(s) for a posted file(s)
#' 
#'
#' Per default zz_get_id() assumes that you only want the target id for the latest 
#' assigned file. Set latest bool to FALSE to change this behaviour.
#'
#' Please note: zz_get_id() doesn't differentiate between files that have been
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
#' zz_get_id()

zz_get_id <- function(usr = NULL, latest = TRUE) {
  
  files_endpoint <- "https://api.zamzar.com/v1/files"
  
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
  
  content <- httr::content(status, as = "text", encoding = "UTF-8")
  content_df <- jsonlite::fromJSON(content, flatten = TRUE)

  if (latest == TRUE) {
    content_df$paging$first
  } else {
    content_df$data$id
  }

}