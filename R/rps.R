#' Rock-Paper-Scissors Intransitive Competition Model
#'
#' @param time Vector of time points at which to evaluate system
#' @param init_r Initial proportion playing strategy Rock
#' @param init_p Initial proportion playing strategy Paper
#' @param init_s Initial proportion playing strategy Scissors
#' @param b Benefit to winner of competition
#'
#' @return Tidy data frame with three columns:
#' \tabular{lll}{
#'   \code{Time} \tab \tab Same values and units as argument \code{time}\cr
#'   \code{Strategy} \tab \tab One of 'Rock', 'Paper', or 'Scissors'\cr
#'   \code{Proportion} \tab \tab Proportion of population playing given strategy
#'                               at given time\cr
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
#' rps(time = t, init_r = 0.01, init_p = 0.4, init_s = 0.5, b = 0.6)
rps <- function(time, init_r, init_p, init_s, b) {

  init_sum <- sum(init_r, init_p, init_s)

  if (init_sum != 1) {
    init_r = init_r / init_sum
    init_p = init_p / init_sum
    init_s = init_s / init_sum
  }

  levs <- c('Rock', 'Paper', 'Scissors')

  out <- ode(mod_rps,
             y = c(r = init_r, p = init_p, s = init_s),
             parms = list(b = b),
             times = time) %>%
    as.data.frame() %>%
    setNames(c('Time', levs)) %>%
    gather('Strategy', 'Proportion', 2:4)

  out$Strategy <- factor(out$Strategy, levs)

  return(out)
}


mod_rps <- function(time, state, par) {
  with(as.list(c(state, par)), {
    dr = b*r*s - b*r*p
    dp = b*p*r - b*p*s
    ds = b*s*p - b*s*r
    return(list(c(dr, dp, ds)))
  })
}
