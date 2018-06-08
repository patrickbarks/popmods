#' Delayed Logistic Growth Model
#'
#' @param time Vector of time points at which to evaluate system
#' @param init_n Initial population abundance
#' @param r Per-capita growth rate
#' @param k Population carrying capacity
#' @param tau Time lag of density-dependent feedback
#'
#' @return Data frame with two columns:
#' \tabular{lll}{
#'   \code{Time} \tab \tab Same values and units as argument \code{time}\cr
#'   \code{Abundance} \tab \tab Abundance of population at given time\cr
#' }
#'
#' @export
#' @import deSolve
#' @import dplyr
#' @importFrom stats setNames
#'
#' @examples
#' t <- seq(0, 50, 0.1)
#' logistic_delay(time = t, init_n = 450, r = 1.1, k = 500, tau = 1.12)
logistic_delay <- function(time, init_n, r, k, tau) {
  out <- dede(mod_logistic_delay,
              y = c(n = init_n),
              parms = list(r = r, k = k, tau = tau),
              times = time) %>%
    as.data.frame() %>%
    setNames(c('Time', 'Abundance'))

  return(out)
}


mod_logistic_delay <- function(time, state, pars) {
  with(as.list(c(state, pars)), {
    tlag <- time - tau
    nlag <- ifelse(tlag <= 0, 10, lagvalue(tlag))
    dn = r * n * (1 - nlag/k)
    return(list(dn, nlag = nlag))
  })
}
