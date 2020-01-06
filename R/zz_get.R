# zz_get
#' 
#' Simple wrapper for Zamzar endpoint to fetch a file from a target id
#' 
#' 
#' Per default zz_get assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' @param target_id The target id for a previously passed file. Most likely
#' returned from zz_get_id()
#'
#' @param usr The username/API key you are using for Zamzar. See: https://developers.zamzar.com/user
#'
#' @param prod Boolean deciding whether to use a production endpoint or
#' a development endpoint. Defaults to FALSE (That is, development endpoint).
#'
#' @export
#' @return A file written to disk
#' 
#' @import httr jsonlite
#' 
#' @examples 
#' zz_get()

zz_get <- function(target_id = NULL, usr = NULL, prod = FALSE) {
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }
  
  if (prod == FALSE) {
    files_endpoint <- "https://sandbox.zamzar.com/v1/files"
  } 
  
  if (prod == TRUE) {
    files_endpoint <- "https://api.zamzar.com/v1/files"
  }
  
  url <- paste0(files_endpoint, "/", target_id,"/content") # Use a proper URL encoder
  
  GET(url,
      write_disk("test.png", overwrite = TRUE),
      config = httr::authenticate(
        user = usr,
        password = "",
        type = "basic"
      )
  )

}

