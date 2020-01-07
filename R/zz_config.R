# zz_config
#' 
#'
#' @return Nuttin
#' 
#' 
#' @keywords internal
#'   
#' 
#' @examples 
#' zz_config()

zz_config <- function() {
  dev_endpoint <- "https://sandbox.zamzar.com/v1/files"
  prod_endpoint <- "https://api.zamzar.com/v1/files"
  
  conf <- list(dev_endpoint = dev_endpoint, prod_endpoint = prod_endpoint)
  class(conf) <- "config"
  conf
}