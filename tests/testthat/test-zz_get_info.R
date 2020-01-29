with_mock_api({
  
  test_that("zz_get_info returns proper values", {
    
    info <- zz_get_info()
    testthat::expect_output(print(info$extension), "gif")
    testthat::expect_output(print(info$id), "66741653")
    testthat::expect_output(print(info$created_at), "2020-01-29T15:27:41Z")
    
    testthat::expect_is(info, "list")

  })
  
})