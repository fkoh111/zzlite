# zz_post
#' 
#' Simple wrapper for Zamzar endpoint accepting images for conversion
#' 
#' 
#' Per default zz_post() assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#'
#' @param file The file you want to convert. Potentially the path to the file
#' you want to convert.
#' 
#' @param target The file type you want to convert to. E.g., "png".
#' 
#' @param usr The username/API key you are using for Zamzar.
#' See: \url{https://developers.zamzar.com/user}
#' 
#' @param prod Boolean deciding whether to use a production endpoint or
#' a development endpoint. Defaults to FALSE (That is, development endpoint).
#'
#' @export
#' @return A response object
#' 
#' @examples
#' \donttest{
#' zz_post()
#' }

zz_post <- function(file = NULL, target = NULL, usr = NULL, prod = FALSE) {
  
  # Creating temp file if no file has been passed to the file param 
  if (is.null(file)) {
    file <- tempfile(fileext = ".tmp")
    writeLines("temp", file)
  }
  
  if (is.null(target)) {
    stop("Excuse me, but i pretty much need to know what file type it is
         that Zamzar is supposed to convert to")
  }
  
  if (is.null(usr)) {
    # Add check for .Renviron token
    stop("Whoops, seems like you forgot to pass a token to the usr param!")
  }
  
  if (prod == FALSE) {
    endpoint <- endpoint <- .zz_endpoint()$dev[[1]]
  } 
  
  if (prod == TRUE) {
    endpoint <- endpoint <- .zz_endpoint()$prod[[1]]
  }
  
  body <- list(source_file = httr::upload_file(path = file),
               target_format = target)
  
  response <- httr::POST(url = endpoint,
       config = httr::authenticate(
         user = usr,
         password = "",
         type = "basic"
       ),
       body = body
  )
  
  httr::message_for_status(response)
}