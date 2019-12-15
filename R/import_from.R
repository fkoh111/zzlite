# import_from
#' 
#' Import script files for the R programming language from a given folder. 
#' 
#' 
#' Per default import_from will only import files with a capitalized
#' extension, that is an .R extension, and not files with a lowercase
#' .r exension.
#' 
#' This is in accordance with general guidelines in the community, as well as
#' advised by authorities within the community, e.g.:
#' Wickham, H. (2015). Advanced R . Boca Raton, FL: CRC Press.
#' 
#' 
#' 
#' @param src The the folder containg .R files that you want to import.
#' This can either be the name of a folder, or the relative path to a given folder.
#' If no folder or path is provided, the current wd is imported.
#' 
#' @param strict Evaluate .R extensions in strict mode, that is, source only
#' script files with a capital .R extension. Defaults to TRUE.
#' 
#' @export
#' @return Returns object(s) assigned in .R files located in the folder imported
#' by import_from 
#' 
#' @examples
#' import_from("R")
#' 
import_from <- function(src, strict = TRUE) {
  
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
