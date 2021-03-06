% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/logistic_delay.R
\name{logistic_delay}
\alias{logistic_delay}
\title{Delayed Logistic Growth Model}
\usage{
logistic_delay(time, init_n, r, k, tau)
}
\arguments{
\item{time}{Vector of time points at which to evaluate system}

\item{init_n}{Initial population abundance}

\item{r}{Per-capita growth rate}

\item{k}{Population carrying capacity}

\item{tau}{Time lag of density-dependent feedback}
}
\value{
Data frame with two columns:
\tabular{lll}{
  \code{Time} \tab \tab Same values and units as argument \code{time}\cr
  \code{Abundance} \tab \tab Abundance of population at given time\cr
}
}
\description{
Delayed Logistic Growth Model
}
\examples{
t <- seq(0, 50, 0.1)
logistic_delay(time = t, init_n = 450, r = 1.1, k = 500, tau = 1.12)

}
