% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/zz_delete.R
\name{zz_delete}
\alias{zz_delete}
\title{Delete file from Zamzar account}
\usage{
zz_delete(id = NULL, usr = NULL, verbose = FALSE)
}
\arguments{
\item{id}{The target id for a file you wish to delete. Most likely returned from ‘zz get info()‘.}

\item{usr}{The username/API key you are using. If not set, the function
will check if a key exists as a `ZAMZAR_USR` variable  in `.Renviron` and use that.    

See: \url{https://developers.zamzar.com/user}}

\item{verbose}{Boolean deciding whether or not verbose status messages
should be returned. Defaults to `FALSE`.}
}
\value{
A status message indicating either success or failure.
}
\description{
Delete file from Zamzar account provided a file id.
}
\details{
Please note that a Zamzar key passed as argument to `usr` takes precedence over a
Zamzar key extracted from an `.Renviron`.
}
\examples{
\dontrun{
# An example of zz_delete() with a hardcoded file id

zz_get(id = 12345678)
}
}
