# zz_get
#' 
#' Simple wrapper for Zamzar endpoint to fetch a file from a target id
#' 
#' 
#' Per default zz_get() assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' @param target_id The target id for a previously passed file. Most likely
#' returned from zz_get_id().
#'
#' @param usr The username/API key you are using for Zamzar.
#' See: https://developers.zamzar.com/user
#' 
#' @param name The name of the file you are fetching from Zamzar. If a name is
#' not assigned to the file, then we're using the target_id as name.
#'
#' @param extension The extension of the file you are fetching from Zamzar. 
#' If an extension is not assigned, then we're using .png extension.
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

zz_get <- function(target_id = NULL,
                   usr = NULL,
                   name = NULL,
                   extension = NULL,
                   prod = FALSE) {
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }
  
  if (is.null(name)) {
    target_id <- as.character(target_id)
  }
  
  if (is.null(extension)) {
    extension <- as.character("png")
  }
  
  if (prod == FALSE) {
    endpoint <- zz_endpoint()$prod[[2]]
  } 
  
  if (prod == TRUE) {
    endpoint <- zz_endpoint()$dev[[2]]
  }
  
  # Concatenating an URL
  url <- paste0(endpoint, target_id, "/content")
  
  httr::GET(url,
      write_disk(paste0(target_id, ".", extension), overwrite = TRUE),
      config = httr::authenticate(
        user = usr,
        password = "",
        type = "basic"
      )
  )

}

