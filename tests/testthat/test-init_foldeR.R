library(fkoh111)

testthat::test_that("We can generate tests that are true", {
  
  testthat::expect_true(TRUE == TRUE)

})


#test_that("we're initializing `dummy_vector` and `dummy_function`", {
#
#  init_folder("tests/testdata")
#  
#  # Testing vectors
#  identical_dummy_vector <- c("Hello", "World!")
#  expect_identical(dummy_vector, identical_dummy_vector)
#  
#  
#  # Testing functions
#  identical_dummy_function <- function() {
#    not_print <- c("Hello World!")
#  }
#  expect_identical(dummy_function(), identical_dummy_function())
#})

#test_that("we're not reading files with lowercase R extensions. Testing by NOT having
#          object `dummy_with_lowercase_extension` in our globals", {
#  
#  init_folder("tests/testdata")
#  
#  expect_error(expect_null(dummy_with_lowercase_extension), "object 'dummy_with_lowercase_extension' not found")
#  
#})


