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

# .zz_authenticate
#' 
#' Auxiliary function
#' 
#' Wrapper for httr auth
#' 
#' @keywords internal
.zz_authenticate <- function(usr) {
  httr::authenticate(
    user = usr,
    password = "",
    type = "basic"
  )
}

# .zz_do_paging
#' 
#' Auxiliary function
#' 
#' @keywords internal
.zz_do_paging <- function(content_flat, endpoint = endpoint, usr = usr) {
  if (content_flat$paging$total_count > length(content_flat$data$name)) {
    
    storage <- list()
    container <- data.frame(target = content_flat$data$name,
                            stringsAsFactors = FALSE)
    
    counter <- ceiling(content_flat$paging$total_count / length(content_flat$data$name))
    
    for(i in 1:counter) {
      state_last_target <- content_flat$paging$last
      
      paged_endpoint <- httr::modify_url(endpoint, query = list(after=state_last_target))
      
      paged_response <- httr::GET(paged_endpoint,
                                  config = .zz_authenticate(usr)
      )
      
      content <- httr::content(paged_response, as = "text", encoding = "UTF-8")
      content_flat <- jsonlite::fromJSON(content, flatten = TRUE)
      
      temp <- data.frame(target = content_flat$data$name,
                         stringsAsFactors = FALSE)
      
      storage[[i]] <- temp
      
    }
    
    storage <- do.call(rbind, storage)
    container <- rbind(container, storage)
  }
}

# .zz_parse_response
#' 
#' Auxiliary function
#' 
#' @keywords internal
.zz_parse_response <- function(response) {
  content <- httr::content(response, as = "text", encoding = "UTF-8")
  content_flat <- jsonlite::fromJSON(content, flatten = TRUE)
}