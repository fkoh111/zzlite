# zz_format
#' 
#' Simple wrapper for Zamzar endpoint returning a list of formats you can
#' convert between
#'
#'
#' @param usr The username/API key you are using for Zamzar.
#' See: https://developers.zamzar.com/user
#'
#' @param origin The origin format you want to convert. If param origin is passed,
#' zz_format returns a list containing a list of targets and a list of costs.
#' The target list contains tagets that you can convert your origin to.
#' The cost list contains the cost of for converting between origin and target.
#' 
#'
#' @export
#' @return A list of formats.
#' 
#' @examples 
#' zz_format()

zz_format <- function(usr = NULL, origin = NULL) {
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }

  if (is.null(origin)) {
    endpoint <- zz_endpoint()$format[[1]]
    #endpoint <- "https://sandbox.zamzar.com/v1/formats"
  } else {
    endpoint <- paste0(zz_endpoint()$format[[1]], origin)
    #endpoint <- paste0("https://sandbox.zamzar.com/v1/formats/", origin)
  }
  
  response <- httr::GET(endpoint,
                        config = httr::authenticate(
                          user = usr,
                          password = "",
                          type = "basic"
                        )
  )
  
  #httr::stop_for_status(response)
  
  #if (httr::http_error(response)) {
  #  stop(
  #    sprintf(
  #      "Whoops, you got a status code of %d", httr::status_code(response)
  #      )
  #    )
  #}
  
  content <- httr::content(response, as = "text", encoding = "UTF-8")
  content_df <- jsonlite::fromJSON(content, flatten = TRUE)
  
  if (is.null(origin)) {
    res <- content_df$data$name
  } else {
    target <- content_df$targets$name
    cost <- content_df$targets$credit_cost
    res <- list(target = target, cost = cost)
  }
  
  if (is.list(res) && is.null(res$target)) {
    warning("Whoops! Seems like you didn't a valid origin param")
  } else {
    return(res)
  }
  
}

