# zz_format
#'
#' Get accepted formats from Zamzar
#' 
#' @section Details:
#' Please note that a Zamzar key passed as usr param takes precedence over a
#' Zamzar key extracted from the .Renviron.  
#' 
#'
#' @param origin The origin format you want to convert from.
#' If a valid param is passed to origin, zz_format() returns a dataframe with cols __targets__ and __costs__.  
#' 
#'   * `targets`: The formats your origin can be converted to.
#'   * `costs`: The cost for converting between your origin and a given target.
#' 
#' See also: \url{https://developers.zamzar.com/formats}  
#'
#' If no orign param is passed to zz_format(), a dataframe containing all
#' the accepted formats for the __origin__ param is returned.  
#' 
#' See: \url{https://developers.zamzar.com/formats}
#'
#'
#' @param usr The username/API key you are using for Zamzar. If not set, zz_format()
#' will see if a key exists as a ZAMZAR_USR variable  in .Renviron and use that.    
#' 
#' See: \url{https://developers.zamzar.com/user}
#'
#'  
#' @md
#' 
#' @export
#' @return Either a dataframe of formats from the API that you can convert to,
#' or a single column dataframe of accepted origin formats.
#' 
#' @examples 
#' \donttest{
#' # Returns a single column dataframe of all the accepted formats
#' # for the origin param.
#' zz_format(usr = "key")
#' 
#' # Same as above (assuming a valid key in .Renviron).
#' zz_format()
#' 
#' # Returns an error since the origin param isn't recognized by the Zamzar API.
#' zz_format(origin = "invalid_origin")
#' 
#' # Returns a dataframe of targets that origin can be converted to,
#' # and of the cost of converting to a given target.
#' zz_format(origin = "emf")
#' }

zz_format <- function(origin = NULL, usr = NULL) {

  usr <- .zz_get_key(usr = usr)
  
  if (is.null(origin) || origin == "") {
    endpoint <- .zz_endpoint()$format[[1]]
  } else {
    endpoint <- paste0(.zz_endpoint()$format[[1]], "/", origin)
  }
  
  response <- httr::GET(endpoint,
                        config = .zz_authenticate(usr = usr)
                        )
  
  content <- .zz_parse_response(response = response)

  if (!response$status_code %in% c(200, 201)) {
    stop(sprintf("Whoops! Zamzar responded with: %s, and a status code of: %d",
                 content$errors$message,
                 response$status_code)
    )
  }
  
  container <- data.frame(target = content$data$name,
                          stringsAsFactors = FALSE)
  
  # Checking if we should do paging (more than 50)
  if(length(content$data$name) >= 50) {
    container <- .zz_do_paging(content = content,
                               container = container,
                               endpoint = endpoint,
                               usr = usr)
  }


  if (is.null(origin) || origin == "") {
    res <- container
  } else {
    res <- data.frame(target = content$targets$name,
                      cost = content$targets$credit_cost,
                      stringsAsFactors = FALSE)
  }
  

  if (response$status_code %in% c(200, 201)) {
    return(res)
  } else {
    stop(sprintf("Whoops! Zamzar responded with: %s, and status code %d.",
                 content$errors$message,
                 response$status_code)
    )
  }
}
