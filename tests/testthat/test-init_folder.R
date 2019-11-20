path_to_src <- file.path(getwd(), "testdata")

test_that("we're initializing `dummy_vector` and `dummy_function`", {
  
  init_folder(path_to_src)
  
  # Testing vectors
  identical_dummy_vector <- c("Hello", "World!")
  expect_identical(dummy_vector, identical_dummy_vector)
  
  
  # Testing functions
  identical_dummy_function <- function() {
    not_print <- c("Hello World!")
  }
  expect_identical(dummy_function(), identical_dummy_function())
})


test_that("we're NOT reading files with lowercase R extensions. Verified by
          receiving the error `object 'dummy_with_lowercase_extension' not found`", {
  
  init_folder(path_to_src)
  
  expect_error(expect_null(dummy_with_lowercase_extension), "object 'dummy_with_lowercase_extension' not found")
  
})
