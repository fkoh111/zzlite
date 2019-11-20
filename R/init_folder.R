# init_folder
#' Init a a given folder containing .R files
#' 
#' This function initializes files with a proper .R extension.
#' 
#' @param src which is a path or a folder name
#' 
#' @export
#' @return nuttin expect for more objects in your environment
#' 
#' @examples
#' init_folder("R")
init_folder <- function(src) {
  src_contains <- list.files(path = src, "*.R$")
  
  for (file in src_contains) {
    source(file.path(src, file))
  }
}
