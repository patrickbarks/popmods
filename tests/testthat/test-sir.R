context("sir")

test_that("sir works correctly", {

  t <- seq(0, 50, 0.1)
  x <- sir(time = t, init_s = 0.9999, init_i = 0.0001, init_r = 0, gamma = 0.6,
           beta = 0.08)

  expect_is(x, "data.frame")
  expect_true(nrow(x) == length(t) * 3)
  expect_true(all(x$proportion <= 1 & x$proportion >= 0))
})
