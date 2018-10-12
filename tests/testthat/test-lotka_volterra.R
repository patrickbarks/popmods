context("lotka_volterra")

test_that("lotka_volterra works correctly", {

  t <- seq(0, 50, 0.1)
  x <- lotka_volterra(time = t, init_n = 50, init_p = 30, r = 0.8, c = 0.04,
                      a = 0.2, m = 0.3)

  expect_is(x, "data.frame")
  expect_true(nrow(x) == length(t) * 2)
  expect_true(all(x$abundance >= 0))
})
