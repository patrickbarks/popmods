context("rps")

test_that("rps works correctly", {

  t <- seq(0, 50, 0.1)
  x <- rps(time = t, init_r = 0.01, init_p = 0.4, init_s = 0.5, b = 0.6)

  expect_is(x, "data.frame")
  expect_true(nrow(x) == length(t) * 3)
  expect_true(all(x$proportion <= 1 & x$proportion >= 0))
})
