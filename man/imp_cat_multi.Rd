% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/hmi_imp_cat_multi_2017-01-04.R
\name{imp_cat_multi}
\alias{imp_cat_multi}
\title{The function for hierarchical imputation of categorical variables.}
\usage{
imp_cat_multi(y_imp_multi, X_imp_multi, Z_imp_multi, clID, model_formula,
  M = 10, nitt = 3000, thin = 10, burnin = 1000)
}
\arguments{
\item{y_imp_multi}{A Vector with the variable to impute.}

\item{X_imp_multi}{A data.frame with the fixed effects variables.}

\item{Z_imp_multi}{A data.frame with the random effects variables.}

\item{clID}{A vector with the cluster ID.}

\item{model_formula}{A \code{\link[stats]{formula}} used for the analysis model.}

\item{M}{An integer defining the number of imputations that should be made.}

\item{nitt}{An integer defining number of MCMC iterations (see MCMCglmm).}

\item{thin}{An integer defining the thinning interval (see MCMCglmm).}

\item{burnin}{An integer defining the percentage of draws from the gibbs sampler
that should be discarded as burn in (see MCMCglmm).}
}
\value{
A n x M matrix. Each column is one of M imputed y-variables.
}
\description{
The function is called by the wrapper and relies on \code{MCMCglmm}.\cr
While in the single level function (\code{imp_cat_single}) we used regression trees
to impute data, here we run a multilevel multinomial model.
The basic idea is that for each category of the target variable (expect the reference category)
a own formula is set up, saying for example that the chances to end up in category
j increase with increasing X5. So there is a own regression coefficient beta_5_j present.
In a multilevel setting, this regression coefficient beta_5_j might be different for
different clusters so for cluster 1 it would be beta_5_j_1 = beta_5_j + u_5_1 and for
cluster 27 beta_5_j_27 = beta_5_j + u_5_27. This also leads to own random effect covariance
matrices for each category. Or, if you want to have all random effect variance parameters
in one matrix: a (very large) matrix where not for example only the random intercepts variance
and random slopes variance and their covariance is present. Instead there is even a
covariance between the random slopes in category 2 and the random intercepts in category 4.
For simplicity these covariances are set to be 0.
}

