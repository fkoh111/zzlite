test_that("An error is thrown if we forget various params", {
  
  expect_error(zzlite::zz_post(), "Excuse me, but I need to know the extension type; please pass it :-)")
  
  }
)