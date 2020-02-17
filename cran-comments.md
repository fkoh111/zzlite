## TEST ENV

* local OS X install, R 3.6.2
* ubuntu 16.04 LTS (on travis-ci), (R:oldrel, R:release, R:devel, R:bioc-devel)
* win-builder (devel and release)

## R CMD check results

* 0 ERRORS
* 0 WARNINGS
* 0 NOTES

## Cran comments

**Comments:**  
The Title field should be in title case. Current version is:  
'Lite wrapper for the Zamzar conversion API'  
In title case that is:  
'Lite Wrapper for the Zamzar Conversion API'  

**Updated to:**  
Lite Wrapper for the 'Zamzar File Conversion' API

**Comments:**  
Please do not ship the full license but only additional restrictions,
otherwise omit the file and its reference entirely. A copy of the GPL-3
is part of R.

**Updated to:**  
Omitted file and reference.  

**Comments:**  
Please always write package names, software names and API names in
single quotes in title and description. e.g: --> 'Zamzar conversion'  

**Updated to:**  
Title: --> Lite Wrapper for the 'Zamzar File Conversion' API  
Description: --> ... 'Zamzar File Conversion' .  

**Comments:**  
The Description field is intended to be a (one paragraph) description
of what the package does and why it may be useful.
Please elaborate.

**Updated to:**  
A minor collection of HTTP wrappers for the 'Zamzar File Conversion'
    API. The wrappers makes it easy to utilize the API and thus convert
    between more than 100 different file formats (ranging from audio files,
    images, movie formats, etc., etc.) through an R session.  
    For specifics regarding the API, please see <https://developers.zamzar.com/>.

**Comments:**  
Please add a web reference for the API in the form https:.....
with no space after 'https:' and angle brackets for auto-linking.

**Updated to:**  
Please see last line previous updated to section.  


**Comments:**  
You have examples wrapped in \donttest which return errors. Please wrap
those in \dontrun instead.
\dontrun{} should only be used if the example really cannot be executed
(e.g. because of missing additional software, missing API keys, ...) by
the user. That's why wrapping examples in \dontrun{} adds the comment
("# Not run:") as a warning for the user.  

**Updated to:**  
Changed from \donttest to to \dontrun in all affected functions.  