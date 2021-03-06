% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sir.R
\name{sir}
\alias{sir}
\title{SIR Epidemiological Model}
\usage{
sir(time, init_s, init_i, init_r, gamma, beta)
}
\arguments{
\item{time}{Vector of time points at which to evaluate system}

\item{init_s}{Initial proportion susceptible}

\item{init_i}{Initial proportion infected}

\item{init_r}{Initial proportion resistant}

\item{gamma}{Transition rate from infected to resistant}

\item{beta}{Transition rate from susceptible to infected}
}
\value{
Tidy data frame with three columns:
\tabular{lll}{
  \code{Time} \tab \tab Same values and units as argument \code{time}\cr
  \code{Status} \tab \tab One of 'Susceptible', 'Infected', or 'Resistant'\cr
  \code{Proportion} \tab \tab Proportion of population with given status at given time\cr
}
}
\description{
SIR Epidemiological Model
}
\examples{
t <- seq(0, 50, 0.1)
sir(time = t, init_s = 0.9999, init_i = 0.0001, init_r = 0, gamma = 0.6,
    beta = 0.08)

}
