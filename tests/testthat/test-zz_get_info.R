with_mock_api({
  
  test_that("zz_get_info ...", {
    
    info <- zz_get_info()
    testthat::expect_output(print(info$extension), "gif")
    testthat::expect_output(print(info$id), "66741653")

  })
  
})