# zz_post
#' 
#' Post file to Zamzar endpoint
#' 
#' @section zz_post:
#' Per default zz_post() assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' @param file The path to the file you want to convert.
#' 
#' @param extension The file type you want to convert to. E.g., "png".
#' 
#' @seealso \code{\link{zz_format}} for a list of formats you can convert to.
#' 
#' @param usr The username/API key you are using for Zamzar.
#' See: \url{https://developers.zamzar.com/user}
#' 
#' @param prod Boolean deciding whether to use prod or dev endpoint.
#' Defaults to FALSE (That is, dev endpoint).
#'
#' @export
#' @return A response object as defined by httr::message_for_status()
#' 
#' @examples
#' \donttest{
#' # Per default zz_post uses the development endpoint
#' zz_post(file = "avatar.emf", usr = "passwd", extension = "png")
#' 
#' # Setting prod param to FALSE is the same as above
#' zz_post(file = "avatar.emf", usr = "passwd", extension = "png", prod = FALSE)
#' 
#' # You need to flip prod to TRUE if you want to use the production endpoint
#' zz_post(file = "avatar.emf", usr = "passwd", extension = "png", prod = TRUE)
#' 
#' }

zz_post <- function(file = NULL, extension = NULL, usr = NULL, prod = FALSE) {
  
  # Creating temp file if no file has been passed to the file param
  #TODO: Consider whether or not this is a good enough approach
  if (is.null(file)) {
    file <- tempfile(fileext = ".tmp")
    writeLines("temp", file)
  }
  
  if (is.null(extension)) {
    stop("Excuse me, but I need to know the extension type; please pass it :-)")
  }
  
  if (is.null(usr)) {
    # Add check for .Renviron token
    stop("Whoops, seems like you forgot to pass a token to the usr param!")
  }
  
  if (prod == FALSE) {
    endpoint <- .zz_endpoint()$dev[[1]]
  } 
  
  if (prod == TRUE) {
    endpoint <- .zz_endpoint()$prod[[1]]
  }
  
  body <- list(source_file = httr::upload_file(path = file),
               target_format = extension)
  
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