context("logistic_delay")

test_that("logistic_delay works correctly", {

  t <- seq(0, 50, 0.1)
  x <- logistic_delay(time = t, init_n = 450, r = 1.1, k = 500, tau = 1.12)

  expect_is(x, "data.frame")
  expect_true(nrow(x) == length(t))
  expect_true(all(x$abundance >= 0))
})
