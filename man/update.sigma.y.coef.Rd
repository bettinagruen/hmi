% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hmi_smallfunctions_2016-07-05.R, R/hmi_smallfunctions_2016-07-14.R
\name{update.sigma.y.coef}
\alias{update.sigma.y.coef}
\title{update.sigma.y.coef}
\usage{
\method{update}{sigma.y.coef}(y_obs, X_obs, beta.new, Z_obs, alpha.new,
  clID_obs, n.obs)

\method{update}{sigma.y.coef}(y_obs, X_obs, beta.new, Z_obs, alpha.new,
  clID_obs, n.obs)
}
\arguments{
\item{y_obs}{The target variable of those observations with an observed value of y.}

\item{X_obs}{The fixed effects data matrix of those observations with an observed value of y.}

\item{beta.new}{The vector of fixed effects parameters.}

\item{Z_obs}{The random effects data matrix of those observations with an observed value of y.}

\item{alpha.new}{The matrix of cluster specific random effects.}

\item{clID_obs}{The cluster ID vector of those observations with an observed value of y.}

\item{n.obs}{The number of individuals with an observed y.}

\item{y_obs}{The target variable of those observations with an observed value of y.}

\item{X_obs}{The fixed effects data matrix of those observations with an observed value of y.}

\item{beta.new}{The vector of fixed effects parameters.}

\item{Z_obs}{The random effects data matrix of those observations with an observed value of y.}

\item{alpha.new}{The matrix of cluster specific random effects.}

\item{clID_obs}{The cluster ID vector of those observations with an observed value of y.}

\item{n.obs}{The number of individuals with an observed y.}
}
\value{
The numeric residual variance.

The numeric residual variance.
}
\description{
The function updates the residual variance parameter by drawing from a chisquared distribution.

The function updates the residual variance parameter by drawing from a chisquared distribution.
}

