# zz_get
#' 
#' Get file from Zamzar endpoint
#' 
#' @section zz_get:
#' Get file from Zamzar endpoint via id.
#' Per default zz_get() assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' @param id The target id for a previously passed file. Most likely
#' returned from zz_get_info().
#'
#' @param usr The username/API key you are using for Zamzar.  
#' 
#' See: \url{https://developers.zamzar.com/user}
#' 
#' @param name The name of the file you are fetching from Zamzar. If a name is
#' not assigned to the file, then we're using the id as file name.
#'
#' @param extension The extension of the file you are fetching from Zamzar. 
#'
#' @param prod Boolean deciding whether to use a production endpoint or
#' a development endpoint. Defaults to FALSE (That is, development endpoint).
#'
#' @export
#' @return A file written to disk
#' 
#' @examples
#' \donttest{
#' # An example of zz_get() utilized with hardcoded arguments
#' zz_get(id = 12345678, usr = "key", name = "my_avatar", extension = "png")
#' 
#' # An example zz_get() used in conjunction with zz_get_info()
#' response <- zz_get_info(usr = "key", latest = TRUE)
#' zz_get(usr = usr, id = response$id, extension = response$extension, prod = TRUE)
#' }


zz_get <- function(id = NULL,
                   usr = NULL,
                   name = NULL,
                   extension = NULL,
                   prod = FALSE) {


  if (is.null(id)) {
    stop("Whoops, seems like you forgot to pass an id!")
  }
  
  usr <- .zz_get_key(usr = usr)
  
  if (is.null(extension)) {
    stop("Excuse me, I'm not that smart, please let me know what file format I should get.")
  }
  
  if (is.null(name)) {
    id <- as.character(id)
  }
  
  if (prod == FALSE) {
    endpoint <- .zz_endpoint()$prod[[2]]
  } 
  
  if (prod == TRUE) {
    endpoint <- .zz_endpoint()$dev[[2]]
  }
  
  # Concatenating an URL
  url <- .zz_endpoint_content(endpoint = endpoint, id = id)
  
  identifier <- paste0(id, ".", extension)
  
  response <- httr::GET(url,
      httr::write_disk(identifier, overwrite = TRUE),
      config = httr::authenticate(
        user = usr,
        password = "",
        type = "basic"
      )
  )
  
  if (!response$status_code %in% c(200, 201)) {
    stop(sprintf("Zamzar responded with a status code of: %d",
                 response$status_code)
    )
  }
 
  # Delete file if status code indicates so 
  if (response$status_code %in% c(404)) {
    unlink(identifier)
  }

}