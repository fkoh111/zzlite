# zz_get
#' 
#' Get file from Zamzar endpoint
#' 
#' @section 
#' Get file from Zamzar endpoint via id.
#' Per default zz_get() assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' @param id The target id for a previously passed file. Most likely
#' returned from zz_get_info().
#'
#' @param usr The username/API key you are using for Zamzar.
#' See: \url{https://developers.zamzar.com/user}
#' 
#' @param name The name of the file you are fetching from Zamzar. If a name is
#' not assigned to the file, then we're using the id as name.
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
#' @examples
#' \donttest{
#' zz_get()
#' }

zz_get <- function(id = NULL,
                   usr = NULL,
                   name = NULL,
                   extension = NULL,
                   prod = FALSE) {
  

  if (is.null(id)) {
    stop("Whoops, seems like you forgot to pass a id!")
  }
  
  if (is.null(usr)) {
    # Add check for .Renviron token
    stop("Whoops, seems like you forgot to pass a token to the usr param!")
  }
  
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
  
  httr::GET(url,
      httr::write_disk(paste0(id, ".", extension), overwrite = TRUE),
      config = httr::authenticate(
        user = usr,
        password = "",
        type = "basic"
      )
  )

}

