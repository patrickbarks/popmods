#' SIR Epidemiological Model
#'
#' @param time Vector of time points at which to evaluate system
#' @param init_s Initial proportion susceptible
#' @param init_i Initial proportion infected
#' @param init_r Initial proportion resistant
#' @param beta Transition rate from susceptible to infected
#' @param gamma Transition rate from infected to resistant
#'
#' @return Tidy data frame with three columns:
#' \tabular{lll}{
#'   \code{Time} \tab \tab Same values and units as argument \code{time}\cr
#'   \code{Status} \tab \tab One of 'Susceptible', 'Infected', or 'Resistant'\cr
#'   \code{Proportion} \tab \tab Proportion of population with given status at given time\cr
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
#' sir(time = t, init_s = 0.9999, init_i = 0.0001, init_r = 0, gamma = 0.6,
#'     beta = 0.08)
sir <- function(time, init_s, init_i, init_r, gamma, beta) {

  init_sum <- sum(init_s, init_i, init_r)

  if (init_sum != 1) {
    init_s = init_s / init_sum
    init_i = init_i / init_sum
    init_r = init_r / init_sum
  }

  levs <- c('Susceptible', 'Infected', 'Resistant')

  out <- deSolve::ode(mod_sir,
             y = c(s = init_s, i = init_i, r = init_r),
             parms = list(b = beta, g = gamma),
             times = time) %>%
    as.data.frame() %>%
    setNames(c('Time', levs)) %>%
    gather('Status', 'Proportion', 2:4)

  out$Status <- factor(out$Status, levs)

  return(out)
}


mod_sir <- function (time, state, pars) {
  with(as.list(c(state, pars)), {
    ds = -g*s*i
    di = g*s*i - b*i
    dr = b*i
    return(list(c(ds, di, dr)))
  })
}
