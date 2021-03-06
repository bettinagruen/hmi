#' The function for imputation of contiuous variables.
#'
#' The function is called by the wrapper (hmi). It uses \code{mice} with the method "norm".
#' @param y_imp_multi A Vector with the variable to impute.
#' @param X_imp_multi A data.frame with the fixed effects variables.
#' @return A n x 1 matrix.
imp_cont_single <- function(y_imp_multi,
                      X_imp_multi){

  #Initialising the returning vector
  y_imp <- as.matrix(y_imp_multi, ncol = 1)

  #the missing indactor indicates, which values of y are missing.
  missind <- is.na(y_imp_multi)


  types <- array(dim = ncol(X_imp_multi))
  for(j in 1:length(types)){
    types[j] <- get_type(X_imp_multi[, j])
  }

  categorical <- types == "categorical"

  #remove categories with more than 10 observations as the model in the current form
  #will cause later numerical probles
  too_many_levels <- colnames(X_imp_multi[, categorical, drop = FALSE])[
    apply(X_imp_multi[, categorical, drop = FALSE], 2, function(x) nlevels(factor(x))) > 10]
  X_imp_multi <- X_imp_multi[, !names(X_imp_multi) %in% too_many_levels, drop = FALSE]

  # remove variables with just one observation
  is_constant <- apply(X_imp_multi, 2, function(x) length(unique(x)) <= 1)
  X_imp_multi <- X_imp_multi[, !is_constant, drop = FALSE]

  # -- standardise the covariates in X (which are numeric and no intercept)
  need_stand <- apply(X_imp_multi, 2, get_type) == "cont"

  X_imp_multi[, need_stand] <- scale(X_imp_multi[, need_stand])


  n <- length(y_imp_multi)
  lmstart <- stats::lm(stats::rnorm(n) ~ 0 +., data = X_imp_multi)

  X_model_matrix_1 <- stats::model.matrix(lmstart)
  xnames_1 <- paste("X", 1:ncol(X_model_matrix_1), sep = "")

  tmp_1 <- data.frame(y = stats::rnorm(n))
  tmp_1[, xnames_1] <- X_model_matrix_1

  reg_1 <- stats::lm(y ~ 0 + . , data = tmp_1)

  blob <- y_imp_multi
  tmp_2 <- data.frame(y = blob)

  xnames_2 <- xnames_1[!is.na(stats::coefficients(reg_1))]
  tmp_2[, xnames_2] <- X_model_matrix_1[, !is.na(stats::coefficients(reg_1)), drop = FALSE]

  everything <- mice::mice(data = tmp_2, m = 1,
                     method = "norm",
                     predictorMatrix = (1 - diag(1, ncol(tmp_2))),
                     visitSequence = (1:ncol(tmp_2))[apply(is.na(tmp_2),2,any)],
                     post = vector("character", length = ncol(tmp_2)),
                     defaultMethod = "norm",
                     maxit = 10,
                     diagnostics = TRUE,
                     printFlag = FALSE,
                     seed = NA,
                     imputationMethod = NULL,
                     defaultImputationMethod = NULL,
                     data.init = NULL)


  y_imp[is.na(y_imp_multi),] <- everything$imp[[1]][, 1]

  return(y_imp)

}


# Generate documentation with devtools::document()
# Build package with devtools::build() and devtools::build(binary = TRUE) for zips
