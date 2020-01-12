# zz_format
#' 
#' Simple wrapper for Zamzar endpoint returning a list of formats you can
#' convert between
#'
#'
#' @param usr The username/API key you are using for Zamzar.
#' See: https://developers.zamzar.com/user
#'
#' @export
#' @return A list of formats
#' 
#' @import httr jsonlite
#' 
#' @examples 
#' zz_format()

zz_format <- function(usr = NULL) {
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }
  
  endpoint <- zz_endpoint()$format[[1]]

  response <- GET(endpoint,
                  config = authenticate(
                    user = usr,
                    password = "",
                    type = "basic"
                  )
  )
  
  content <- content(response, as = "text", encoding = "UTF-8")
  content_df <- fromJSON(content, flatten = TRUE)
  content_df$data$name
}