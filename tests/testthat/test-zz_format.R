with_mock_api({
  
  test_that("zz_format is extracting proper values if no origin param is provided", {
    
    out <- zz_format()
    testthat::expect_output(print(out[[1]]), "3g2")
    testthat::expect_output(print(out[[20]]), "csv")
    testthat::expect_output(print(out[[27]]), "emf")
    testthat::expect_output(print(out[[35]]), "gvi")
    testthat::expect_output(print(out[[50]]), "msg")

    # General sanity
    testthat::expect_length(out, 50)
    
    testthat::expect_is(out, "character")
    
    
  })
  
})