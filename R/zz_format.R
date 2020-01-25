# zz_format
#'
#' Get vector of accepted formats from Zamzar
#' 
#' @param usr The username/API key you are using for Zamzar.  
#' 
#' See: \url{https://developers.zamzar.com/user}
#'
#' @param origin The origin format you want to convert from.
#' If a valid param is passed to origin, zz_format() returns a list of __targets__ and __costs__.  
#' 
#'   * `targets`: A vector containing the formats your origin can be converted to.
#'   * `costs`: A vector containing the cost for converting between your origin and a given target.
#' 
#' See also: \url{https://developers.zamzar.com/formats}  
#'
#' If no orign param is passed to zz_format(), a character vector containing all
#' the accepted formats for the __origin__ param is returned.  
#' 
#' See: \url{https://developers.zamzar.com/formats}
#' 
#' @md
#' 
#' @export
#' @return Either a list of formats from the API that you can convert to,
#' or a character vector of accepted origin formats.
#' 
#' @examples 
#' \donttest{
#' # Returns a character vector of all the accepted formats for the origin param
#' zz_format(usr = "key")
#' 
#' # Returns an error since the origin param isn't recognized by the Zamzar API
#' zz_format(usr = "key", origin = "invalid_origin")
#' 
#' # Returns a list of targets that origin can be converted to, and of the cost of
#' # converting to a given target.
#' zz_format(usr = "key", origin = "emf")
#' }

zz_format <- function(usr = NULL, origin = NULL) {
  
  if (is.null(usr)) {
    # Add check for .Renviron token
    stop("Whoops, seems like you forgot to pass a token to the usr param!")
  }
  
  if (is.null(origin) || origin == "") {
    endpoint <- .zz_endpoint()$format[[1]]
    #endpoint <- "https://sandbox.zamzar.com/v1/formats"
  } else {
    endpoint <- paste0(.zz_endpoint()$format[[1]], "/", origin)
    #endpoint <- paste0("https://sandbox.zamzar.com/v1/formats/", origin)
  }
  
  response <- httr::GET(endpoint,
                        config = httr::authenticate(
                          user = usr,
                          password = "",
                          type = "basic"
                        )
  )
  
  content <- httr::content(response, as = "text", encoding = "UTF-8")
  content_df <- jsonlite::fromJSON(content, flatten = TRUE)
  
  if (is.null(origin) || origin == "") {
    origin <- content_df$data$name
  } else {
    target <- content_df$targets$name
    cost <- content_df$targets$credit_cost
    res <- list(target = target, cost = cost)
  }
  
  
  if (!response$status_code %in% c(200, 201)) {
    stop(sprintf("Zamzar responded with: %s, and a status code of: %d",
                    content_df$errors$message, response$status_code)
         )
  }
  
  
  if (response$status_code %in% c(200, 201)) {
    if (is.list(res) && is.null(res$target)) {
      stop(sprintf("Whoops! Zamzar responded with: %s, and status code %d.",
                      content_df$errors$message, response$status_code)
           )
    } else {
      return(res)
    }
  }
}
