#' Lotka-Volterra Predator-Prey Model
#'
#' @param time Vector of time points at which to evaluate system
#' @param init_n Initial abundance of prey population
#' @param init_p Initial abundance of predator population
#' @param r Prey per-capita growth rate
#' @param c Predator consumption efficiency (of turning prey into offspring)
#' @param a Predator search/attack efficiency
#' @param m Predator mortality rate
#'
#' @return Tidy data frame with three columns:
#' \tabular{lll}{
#'   \code{Time} \tab \tab Same values and units as argument \code{time}\cr
#'   \code{Population} \tab \tab One of 'Prey' or 'Predator'\cr
#'   \code{Abundance} \tab \tab Abundance of given population at given time\cr
#' }
#'
#' @examples
#' t <- seq(0, 50, 0.1)
#' lotka_volterra(time = t, init_n = 50, init_p = 30, r = 0.8, c = 0.04, a = 0.2,
#'                m = 0.3)
#'
#' @importFrom deSolve ode
#' @export lotka_volterra
lotka_volterra <- function(time, init_n, init_p, r, c, a, m) {

  out <- ode(
    mod_lotka_volterra,
    y = c(n = init_n, p = init_p),
    parms = list(r = r, c = c, a = a, m = m),
    times = time
  )

  levs <- c("prey", "predator")
  out <- tidy_fn(out, col_names = c("time", levs))
  out <- gather_fn(out, "population", "abundance", cols = 2:3, key_levs = levs)

  return(out)
}



mod_lotka_volterra <- function(time, state, pars) {
  with(as.list(c(state, pars)), {
    dn = r*n - c*n*p
    dp = a*c*n*p - m*p
    return(list(c(dn, dp)))
  })
}
