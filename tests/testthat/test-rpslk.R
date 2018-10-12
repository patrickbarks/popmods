context("rpslk")

test_that("rpslk works correctly", {

  t <- seq(0, 50, 0.1)
  x <- rpslk(time = t, init_r = 0.02, init_p = 0.02, init_s = 0.03,
             init_l = 0.9, init_k = 0.03, b = 0.7)

  expect_is(x, "data.frame")
  expect_true(nrow(x) == length(t) * 5)
  expect_true(all(x$proportion <= 1 & x$proportion >= 0))
})
