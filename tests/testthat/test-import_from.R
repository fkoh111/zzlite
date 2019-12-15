# path_to_src is a Global var that is being set in the helper-path_to_src.R file

test_that("we can init `dummy_vector`", {

              import_from(path_to_src)
  
              identical_dummy_vector <- c("Hello", "World!")
              expect_identical(dummy_vector, identical_dummy_vector)
            }
          )

test_that("we can init `dummy_function`", {
  
              import_from(path_to_src)
  
              identical_dummy_function <- function() {
              not_print <- c("Hello", "World!")}

              expect_identical(dummy_function(), identical_dummy_function())
            }
          )


test_that("we're only reading in files with capital .R extension
          (strict param defaults to true)", {
            
              import_from(path_to_src)
              expect_error(dummy_with_lowercase_extension, "object 'dummy_with_lowercase_extension' not found")
            
              import_from(path_to_src, strict = TRUE)
              expect_error(dummy_with_lowercase_extension, "object 'dummy_with_lowercase_extension' not found")
            }
          )


test_that("we're reading in files with both capital and lowercase .R/.r extensions
          by switching param strict to FALSE", {
            
              import_from(path_to_src, strict = FALSE)
            
              #Lowercase .R extension
              expect_identical(dummy_with_lowercase_extension, TRUE)
            
              #Capitalized .R extension
              identical_dummy_vector <- c("Hello", "World!")
              expect_identical(dummy_vector, identical_dummy_vector)
            }
          )


test_that("we get a warning when assigning a path that doesn't
          contain any valid files", {
            
              expect_warning(import_from(path_to_folder_without_r, strict = FALSE))
              expect_warning(import_from(path_to_folder_without_r, strict = TRUE))
              expect_warning(import_from(path_to_folder_without_r))
            }
          )
