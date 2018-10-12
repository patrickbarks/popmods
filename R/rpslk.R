#' Rock-Paper-Scissors-Lizard-Spock Intransitive Competition Model
#'
#' @param time Vector of time points at which to evaluate system
#' @param init_r Initial proportion playing strategy Rock
#' @param init_p Initial proportion playing strategy Paper
#' @param init_s Initial proportion playing strategy Scissors
#' @param init_l Initial proportion playing strategy Lizard
#' @param init_k Initial proportion playing strategy Spock
#' @param b Benefit to winner of competition
#'
#' @return Tidy data frame with three columns:
#' \tabular{lll}{
#'   \code{Time} \tab \tab Same values and units as argument \code{time}\cr
#'   \code{Strategy} \tab \tab One of 'Rock', 'Paper', 'Scissors', 'Lizard', or 'Spock'\cr
#'   \code{Proportion} \tab \tab Proportion of population playing given strategy at given time\cr
#' }
#'

#'
#' @examples
#' t <- seq(0, 50, 0.1)
#' rpslk(time = t, init_r = 0.02, init_p = 0.02, init_s = 0.03, init_l = 0.9,
#'       init_k = 0.03, b = 0.7)
#'
#' @importFrom deSolve ode
#' @export rpslk
rpslk <- function(time, init_r, init_p, init_s, init_l, init_k, b) {
  # rock beats scissors and lizard; beaten by paper and spock
  # paper beats rock and spock; beaten by scissors and lizard
  # scissors beats paper and lizard; beaten by rock and spock
  # lizard beats paper and spock; beaten by scissors and rock
  # spock beats scissors and rock; beaten by paper and lizard

  init_sum <- sum(init_r, init_p, init_s, init_l, init_k)
  init_r = init_r / init_sum
  init_p = init_p / init_sum
  init_s = init_s / init_sum
  init_l = init_l / init_sum
  init_k = init_k / init_sum

  out <- ode(
    mod_rpslk,
    y = c(r = init_r, p = init_p, s = init_s, l = init_l, k = init_k),
    parms = list(b = b),
    times = time
  )

  levs <- c("rock", "paper", "scissors", "lizard", "spock")
  out <- tidy_fn(out, col_names = c("time", levs))
  out <- gather_fn(out, "strategy", "proportion", cols = 2:6, key_levs = levs)

  return(out)
}



mod_rpslk <- function(time, state, par) {
  with(as.list(c(state, par)), {
    dr = b*r*(s + l - p - k)
    dp = b*p*(r + k - s - l)
    ds = b*s*(p + l - r - k)
    dl = b*l*(p + k - s - r)
    dk = b*k*(s + r - p - l)
    return(list(c(dr, dp, ds, dl, dk)))
  })
}
