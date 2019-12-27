zz_config <- function() {
  
  wd <- getwd()

  if(identical(list.files(path = wd, pattern = "^inst$"), character(0))) {
    warning("Please make sure your wd has an inst folder containing a config.json file")
  }
  
  usr <- fromJSON(file.path(wd, "inst", "config.json", fsep = .Platform$file.sep))$usr
  pswd <- fromJSON(file.path(wd, "inst", "config.json", fsep = .Platform$file.sep))$pswd
  type <- "basic"
  
  configs <- list("usr" = usr, "pswd" = pswd, "type" = type)
}