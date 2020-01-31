# zz_post
#' 
#' Post file to Zamzar endpoint
#' 
#' @section Details:
#' Per default zz_post() assumes that you're doing development, thus using a 
#' development endpoint. Set prod bool to TRUE to change this behaviour.
#'
#' Please note that a Zamzar key passed as usr param takes precedence over a
#' Zamzar key extracted from the .Renviron.  
#'
#'
#' @param file The path to the file you want to convert.
#' 
#' @param extension The file type you want to convert to. E.g., "png".
#' 
#' @seealso \code{\link{zz_format}} for a list of formats you can convert to.
#' 
#' @param usr The username/API key you are using for Zamzar. If not set, zz_post()
#' will see if a key exists as ZAMZAR_USR variable  in .Renviron and use that. 
#' 
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
#' # Per default zz_post uses the development endpoint.
#' zz_post(file = "avatar.emf", extension = "png")
#' 
#' # Setting prod param to FALSE is the same as above.
#' zz_post(file = "avatar.emf", extension = "png", prod = FALSE)
#' 
#' # You need to flip prod to TRUE if you want to use the production endpoint.
#' zz_post(file = "avatar.emf", extension = "png", prod = TRUE)
#' 
#' # Remember you can always pass a Zamzar key to the usr param if you don't
#' # want to use an .Renviron file.
#' zz_post(file = "avatar.emf", usr = "key", extension = "png", prod = TRUE)
#'  
#' }

zz_post <- function(file = NULL, extension = NULL, usr = NULL, prod = FALSE) {
  
  if (is.null(file)) {
    stop("Pretty pls, Zamzar needs a file!")
  }
  
  if (is.null(extension)) {
    stop("Excuse me, but I need to know the extension type; please pass it :-)")
  }
  
  usr <- .zz_get_key(usr = usr)
  
  if (prod == FALSE) {
    endpoint <- .zz_endpoint()$dev[[1]]
  } 
  
  if (prod == TRUE) {
    endpoint <- .zz_endpoint()$prod[[1]]
  }
  
  body <- list(source_file = httr::upload_file(path = file),
               target_format = extension)
  
  response <- httr::POST(url = endpoint,
       config = .zz_authenticate(usr),
       body = body
  )

  httr::message_for_status(response)
}