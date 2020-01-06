# zz_formats
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
#' zz_formats()

zz_formats <- function(usr = NULL) {
  
  if (is.null(usr)) {
    usr <- as.character(sample(999999:99999999, 1)) # Dummy username if nothing has been passed as param
  }
  
  url <- "https://sandbox.zamzar.com/v1/formats"
  
  response <- GET(url,
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