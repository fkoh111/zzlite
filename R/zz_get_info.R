# zz_get_info
#' 
#' Get info from Zamzar
#' 
#' @section Details:
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
#' Please note that a Zamzar key passed as usr param takes precedence over a
#' Zamzar key extracted from the .Renviron.  
#'
#'
#' @param usr The username/API key you are using for Zamzar. If not set, zz_get_info()
#' will see if a key exists as ZAMZAR_USR variable  in .Renviron and use that.   
#' 
#' See: \url{https://developers.zamzar.com/user}
#'
#' @param latest Boolean deciding whether or not zz_get_info() should solely
#' return attributes for the latest target id.  
#' 
#' If switched to FALSE, zz_get_info() will return attributes for all files
#' that have been sumitted to the API within a reasonable timeframe.  
#' 
#' The returned dataframe contains the following columns:  
#' 
#'   * `id`: The unique file identifier assigned to a file by Zamzar. 
#'   * `extension`: The extension representing the format of the file you can download. 
#'   * `created_at`: The time at which the file was created at the Zamzar servers. 
#'
#'@md
#'
#' @export
#' @return A dataframe.
#' 
#' 
#' @examples
#' \donttest{
#' # Provided a valid token in .Renvirion, a dataframe of metadata for the last 
#' # submitted file will be returned.
#' zz_get_info()
#' 
#' # Same as above, we're just passing the key manually.
#' zz_get_info(usr = "key")
#'  
#' # Provided a valid token, will return a dataframe of files
#' # submitted to the API within a reasonable timeframe.
#' zz_get_info(usr = "key", latest = FALSE)
#' 
#' # Same as above, we're just using the .Renviron.
#' zz_get_info(latest = FALSE)
#' }

zz_get_info <- function(usr = NULL, latest = TRUE) {
  
  endpoint <- .zz_endpoint()$prod[[2]]
  
  usr <- .zz_get_key(usr = usr)
  
  response <- httr::GET(url = endpoint,
                      config = .zz_authenticate(usr)
  )
  
  content <- .zz_parse_response(response = response)
  
  #Temporary solution:
  if (is.null(content$data$id[[1]]) && is.null(content$data$id[[1]]) && is.null(content$data$created_at[[1]])) {
    stop("Whoops, we can't find any valid key!")
  }

  if (latest == TRUE) {
    res <- data.frame(id = content$data$id[[1]],
                      extension = content$data$format[[1]],
                      created_at = content$data$created_at[[1]],
                      stringsAsFactors = FALSE)
  } else {
    res <- data.frame(id = content$data$id,
                      extension = content$data$format,
                      created_at = content$data$created_at,
                      stringsAsFactors = FALSE)
  }
  
  return(res)

}