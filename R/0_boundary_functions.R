#' @title Find the optimal univariate GMM boundary.
#'
#' @description
#' Find the optimal two-component univariate GMM boundary and check if its
#' scaled BIC difference is greater than `min_scaled_bic_diff`.
#'
#' @inheritParams gatetree
#'
#' @import mclust
#'
#' @return Vector consisting of the boundary and its scaled BIC difference. The
#' boundary will be NA if its scaled BIC difference is less than
#' `min_scaled_bic_diff`.
find_boundary <- function(
    x, min_scaled_bic_diff = 0, boundary_noise_comp = TRUE) {
  gmm1 <- mclust::Mclust(x, G = 1, modelNames = "E", verbose = FALSE)
  gmm2 <- mclust::Mclust(x, G = 2, modelNames = "E", verbose = FALSE)

  if (boundary_noise_comp) {
    gmm1_dens <- mclust::dens(x, modelName = "E", gmm1$parameters)
    gmm1_noise <- gmm1_dens < mclust::hypvol(x, TRUE)
    gmm1n <- mclust::Mclust(
      x,
      G = 1, modelNames = "E", initialization = list("noise" = gmm1_noise),
      verbose = FALSE
    )

    gmm2_dens <- mclust::dens(x, modelName = "E", gmm2$parameters)
    gmm2_noise <- gmm2_dens < mclust::hypvol(x, TRUE)
    gmm2n <- mclust::Mclust(
      x,
      G = 2, modelNames = "E", initialization = list("noise" = gmm2_noise),
      verbose = FALSE
    )

    scaled_bic_diff <- (gmm2n$bic - gmm1n$bic) / (2 * length(x))
    boundary <- get_mclust_boundary(gmm2n$parameters)
  } else {
    scaled_bic_diff <- (gmm2$bic - gmm1$bic) / (2 * length(x))
    boundary <- get_mclust_boundary(gmm2$parameters)
  }

  if (scaled_bic_diff < min_scaled_bic_diff) {
    boundary <- NA
  }

  c(boundary, scaled_bic_diff)
}

# ==============================================================================

#' @title Find the boundary between two Gaussian components.
#'
#' @description
#' Given the parameters of a two-component Gaussian mixture model fitted by
#' mclust, identify the point at which assignment two either component is
#' equally likely.
#'
#' @param mclust_params Parameters from `mclust::Mclust` output.
#'
#' @return Scalar value
get_mclust_boundary <- function(mclust_params) {
  log_prop_diff <- log(mclust_params$pro[1]) - log(mclust_params$pro[2])
  mean_diff <- mclust_params$mean[2] - mclust_params$mean[1]
  sigma_sq <- mclust_params$variance$sigmasq

  mean_average <- (mclust_params$mean[2] + mclust_params$mean[1]) / 2

  modifier <- sigma_sq * log_prop_diff / mean_diff

  mean_average + modifier
}

# ==============================================================================

#' @title Apply [find_boundary] across a set of variables.
#'
#' @description
#' Apply [find_boundary] to each variable in a set of splittable
#' variables for a subset of observations.
#'
#' @inheritParams propose_splits
#'
#' @return List:
#' * splits: each variable's boundary
#' * scores: the corresponding scaled BIC difference.
propose_boundaries <- function(
    x,
    min_scaled_bic_diff = 0,
    subsetter_g,
    splittable_vars_g = rep(TRUE, ncol(x)),
    boundary_noise_comp) {
  boundaries <- matrix(nrow = 2, ncol = ncol(x))

  # loop over all variables to propose splits
  for (p in which(splittable_vars_g)) {
    boundaries[, p] <- find_boundary(
      x[subsetter_g, p], min_scaled_bic_diff, boundary_noise_comp
    )
  }

  return(list("splits" = boundaries[1, ], "scores" = boundaries[2, ]))
}
