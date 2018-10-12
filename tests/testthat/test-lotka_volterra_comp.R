context("lotka_volterra_comp")

test_that("lotka_volterra_comp works correctly", {

  t <- seq(0, 50, 0.1)
  x <- lotka_volterra_comp(time = t, init_n1 = 10, init_n2 = 10, r1 = 0.5,
                           r2 = 0.1, k1 = 100, k2 = 100, a1 = -0.001, a2 = -0.4)

  expect_is(x, "data.frame")
  expect_true(nrow(x) == length(t) * 2)
  expect_true(all(x$abundance >= 0))
})
