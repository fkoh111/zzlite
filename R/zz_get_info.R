# zz_get_info
#' 
#' Get info from Zamzar
#' 
#' @section zz_get_info:
#' Get info on files submitted to the Zamzar API via your current token
#'
#' Per default zz_get_info() assumes you want information for the last 
#' submitted file. To get information on all the files that have been submitted
#' within a reasonable timeframe, set bool latest to FALSE.
#' 
#' Please note: objects returned from zz_get_info() doesn't differentiate
#' between files that have been assigned to either the development or
#' production endpoint. You have to keep track of this yourself.
#'
#' @param usr The username/API key you are using for Zamzar.
#' See: \url{https://developers.zamzar.com/user}
#'
#' @param latest Boolean deciding whether or not zz_get_info() should solely
#' return attributes for the latest target id. If switched to FALSE, zz_get_info()
#' will return attributes for all files that have been sumitted to the API
#' within a reasonable timeframe.
#'
#' @export
#' @return A list of file attributes.
#' 
#' @details The returned list contains the following attributes:
#' * `id` The unique file identifier assigned to a file by Zamzar.
#' * `extension` The extension representing the format of the file.
#' * `created_at` The time at which the file was created at the Zamzar servers.
#' @md
#' 
#' @examples
#' \donttest{
#' # Provided a valid token, will return a list of attributes
#' zz_get_info(usr = "passwd")
#' 
#' # Provided a valid token, will return a list of files submitted to the API
#' # within a reasonable timeframe.
#' zz_get_info(usr = "passwd", latest = FALSE)
#' 
#' }

zz_get_info <- function(usr = NULL, latest = TRUE) {
  
  endpoint <- .zz_endpoint()$prod[[2]]
  
  if (is.null(usr)) {
    # Add check for .Renviron token
    stop("Whoops, seems like you forgot to pass a token to the usr param!")
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