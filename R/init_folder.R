# init_folder
#' Init a a given folder containing .R files
#' 
#' This function initializes files with a proper .R extension.
#' 
#' @param src Which is a path or a folder name
#' 
#' @param strict Evaluate .R extensions in strict mode, that is, only source capital R. Defaults to TRUE
#' 
#' @export
#' @return Nuttin' expect for more objects in your environment
#' 
#' @examples
#' init_folder("R")
init_folder <- function(src, strict = TRUE) {
  if (strict == TRUE) {
    file_pattern <- ".*\\.R$"
  } else {
    file_pattern <- ".*\\.(R|r)$"
  }
    
  src_contains <- list.files(path = src, pattern = file_pattern)
  
  for (file in src_contains) {
    source(file.path(src, file))
  }
}
