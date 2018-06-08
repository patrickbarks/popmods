#' Lotka-Volterra 2-Species Competition Model
#'
#' @param time Vector of time points at which to evaluate system
#' @param init_n1 Initial abundance of Population 1
#' @param init_n2 Initial abundance of Population 2
#' @param r1 Inherent per-capita growth rate of Population 1
#' @param r2 Inherent per-capita growth rate of Population 2
#' @param k1 Carrying capacity of Population 1
#' @param k2 Carrying capacity of Population 2
#' @param a1 Effect of Population 1 on growth of Population 2
#' @param a2 Effect of Population 2 on growth of Population 1
#'
#' @return Tidy data frame with three columns:
#' \tabular{lll}{
#'   \code{Time} \tab \tab Same values and units as argument \code{time}\cr
#'   \code{Population} \tab \tab One of 'Pop. 1' or 'Pop. 2'\cr
#'   \code{Abundance} \tab \tab Abundance of given population at given time\cr
#' }
#'
#' @export
#' @import deSolve
#' @import dplyr
#' @importFrom stats setNames
#' @importFrom tidyr gather
#'
#' @examples
#' t <- seq(0, 50, 0.1)
#' lotka_volterra_comp(time = t, init_n1 = 10, init_n2 = 10, r1 = 0.5, r2 = 0.1,
#'                     k1 = 100, k2 = 100, a1 = -0.001, a2 = -0.4)
lotka_volterra_comp <- function(time, init_n1, init_n2, r1, r2, k1, k2, a1, a2) {

  levs <- c('Pop. 1', 'Pop. 2')

  out <- ode(mod_lotka_volterra_comp,
             y = c(n1 = init_n1, n2 = init_n2),
             parms = list(r1 = r1, r2 = r2, k1 = k1, k2 = k2, a1 = a1, a2 = a2),
             times = time) %>%
    as.data.frame() %>%
    setNames(c('Time', levs)) %>%
    gather('Population', 'Abundance', 2:3)

  out$Population <- factor(out$Population, levs)

  return(out)
}


mod_lotka_volterra_comp <- function(time, state, pars) {
  with(as.list(c(state, pars)), {
    dn1 = r1 * n1 * (1 - (n1 + a1*n2)/k1)
    dn2 = r2 * n2 * (1 - (n2 + a2*n1)/k2)
    return(list(c(dn1, dn2)))
  })
}
