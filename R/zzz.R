# .zzz_endpoint
#' 
#' Auxiliary function
#' 
#' Holds Zamzar API endpoints
#' 
#' @keywords internal
.zz_endpoint <- function() {
  
  prod <- list(
    post <- c("https://api.zamzar.com/v1/jobs"),
    get <- c("https://api.zamzar.com/v1/files/")
  )
  
  dev <- list (
    post <- c("https://sandbox.zamzar.com/v1/jobs"),
    get <- c("https://sandbox.zamzar.com/v1/files/")
  )
  
  format <- list(
    format <- c("https://sandbox.zamzar.com/v1/formats")
  )
  
  conf <- list(prod = prod, dev = dev, format = format)
  class(conf) <- "config"
  conf
}

# .zz_endpoint_content
#' 
#' Auxiliary function
#' 
#' Decorate an endpoint with a content path
#' 
#' @keywords internal
.zz_endpoint_content <- function(endpoint, id) {
  url <- paste0(endpoint, id, "/content")
}

# .zz_get_key
#' 
#' Auxiliary function
#' 
#' Get Zamzar key from .Renviron
#' 
#' @keywords internal
.zz_get_key <- function(usr) {
  if (is.null(usr)) {
    Sys.getenv("ZAMZAR_USR", "")
  } else {
    usr <- usr
  }
}

