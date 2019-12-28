# zz_config
#' 
#' Handler for Zamzar configs.
#' 
#' 
#' Per default zz_configs expects an inst folder in the current working directory (initialized via getwd()).
#' and looks for a config.json with the appropriate attributes.
#'
#'
#'
#' @export
#' @return A list containing attributes from config.json.
#' 
#' @import jsonlite
#' 
#' @examples 
#' zz_config()

zz_config <- function() {

  if(identical(list.files(path = getwd(), pattern = "^inst$"), character(0))) {
    warning("Please make sure your wd has an inst folder containing a config.json file")
  }
  
  usr <- fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$usr
  pswd <- fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$pswd
  type <- "basic"
  
  dev <- fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$dev
  prod <- fromJSON(file.path("inst", "config.json", fsep = .Platform$file.sep))$prod
  
  configs <- list("usr" = usr, "pswd" = pswd, "type" = type, "dev" = dev, "prod" = prod)
}

