# init_folder
#' 
#' Init a given folder containing script files for the R programming language
#' 
#' 
#' Per default init_folder will only initialize files with a capitalized
#' extension, that is a .R extension, and not files with a lowercase
#' .r exension.
#' 
#' This is in accordance with general guidelines in the community, as well as
#' advised by authorities within the community, e.g.:
#' Wickham, H. (2015). Advanced R . Boca Raton, FL: CRC Press.
#' 
#' 
#' 
#' @param src The the folder you want to initialize. This can either be the name
#' of a folder, or the relative path to a given folder.
#' If no folder or path is provided, the current wd is initialized.
#' 
#' @param strict Evaluate .R extensions in strict mode, that is, source only
#' script files with a capital .R extension. Defaults to TRUE.
#' 
#' @export
#' @return Returns object(s) assigned in .R files located in the folder initialized
#' by init_folder. 
#' 
#' @examples
#' init_folder("R")
#' 
init_folder <- function(src, strict = TRUE) {
  
  if(missing(src)) {
    warning("You didn't provide a src. Initializing from your current wd!")
    src <- getwd()
  }
  
  if(strict == TRUE) {
    file_pattern <- ".*\\.R$"
  } else {
    file_pattern <- ".*\\.(R|r)$"
  }
  
  src_contains <- list.files(path = src, pattern = file_pattern)
  
  if(identical(src_contains, character(0))) {
    warning("The assigned path doesn't contain any valid file(s)")
  } else {
    for (file in src_contains) {
      source(file.path(src, file, fsep = .Platform$file.sep))
    } 
  }
}