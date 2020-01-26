test_that("An error is thrown if we forget various params", {
            
            expect_error(zzlite::zz_get(), "Whoops, seems like you forgot to pass an id!")
            expect_error(zzlite::zz_get(id = 123), "Excuse me, I'm not that smart, please let me know what file format I should get.")

          }
        )


with_mock_api({
  
  test_that("ABOUT TO GET FAMILIAR WITH HTTPTEST", {

        zz_get(id = 66297673, extension = "png")
  })

})