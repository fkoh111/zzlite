# init_folder
#' Init a a given folder containing .R files
#' 
#' This function initializes files with a proper .R extension.
#' 
#' @param folder which is a path or a folder name
#' 
#' @export
#' @return nuttin expect for more objects in your environment
#' 
#' @examples
#' init_foldeR("R")
init_foldeR <- function(folder) {
  src <- file.path(getwd(), folder)
  src_contains <- list.files(path = src, "*.R$")
  
  for (file in src_contains) {
    source(file.path(src, file))
  }  
}


