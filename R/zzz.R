# zz_endpoint
#' 
#' An auxiliary object that holds Zamzar endpoints
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
