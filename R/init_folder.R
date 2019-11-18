init_foldeR <- function(folder) {
  src <- file.path(getwd(), folder)
  src_contains <- list.files(path = src, "*.R$")
  
  for (file in src_contains) {
    source(file.path(src, file))
  }  
}