% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/0_boundary_functions.R
\name{get_mclust_boundary}
\alias{get_mclust_boundary}
\title{Find the boundary between two Gaussian components.}
\usage{
get_mclust_boundary(mclust_params)
}
\arguments{
\item{mclust_params}{Parameters from \code{mclust::Mclust} output.}
}
\value{
Scalar value
}
\description{
Given the parameters of a two-component Gaussian mixture model fitted by
mclust, identify the point at which assignment two either component is
equally likely.
}
