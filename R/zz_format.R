# zz_format
#'
#' Get formats from Zamzar
#' 
#' @param usr The username/API key you are using for Zamzar.  
#' 
#' See: \url{https://developers.zamzar.com/user}
#'
#' @param origin The origin format you want to convert.
#' If param origin is passed, zz_format() returns a list of $targets and of $costs.
#' The target vector contains tagets that you can convert your origin to.
#' The cost vector contains the cost for conversion between your origin and target.  
#' 
#' See: \url{https://developers.zamzar.com/formats}
#' 
#' If no orign param has been passed to zz_format(), a character type of
#' all the origin formats accepted by the Zamzar API is returned.  
#' 
#' See: \url{https://developers.zamzar.com/formats}
#' 
#' @export
#' @return Either a list of formats from the API that you can convert to,
#' or a type character of all the origin formats accepted by the Zamzar API
#' 
#' @examples 
#' \donttest{
#' zz_format(usr = "79b88ef9889d909d533c0099h7432")
#' 
#' zz_format(usr = "79b88ef9889d909d533c0099h7432",
#'           origin = "invalid_origin")
#' 
#' zz_format(usr = "79b88ef9889d909d533c0099h7432",
#'           origin = "emf")
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
                    content_df$errors$message, response$status_code))
  }
  
  
  if (response$status_code %in% c(200, 201)) {
    if (is.list(res) && is.null(res$target)) {
      stop(sprintf("Whoops! Zamzar responded with: %s, and status code %d.",
                      content_df$errors$message, response$status_code))
    } else {
      return(res)
    }
  }
}