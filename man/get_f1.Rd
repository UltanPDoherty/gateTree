% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/get_f1.R
\name{get_f1}
\alias{get_f1}
\title{Compute the F1 measure of a clustering solution.}
\usage{
get_f1(
  class_labels,
  clust_labels,
  remove_class = NULL,
  no_match_class = NULL,
  no_match_clust = NULL,
  prec_rec = FALSE
)
}
\arguments{
\item{class_labels}{Vector of true / reference labels to compare to.}

\item{clust_labels}{Vector of cluster labels to evaluate.}

\item{remove_class}{Vector of class labels to be removed from the data.}

\item{no_match_class}{Vector of class labels to which cluster labels should
not be matched.}

\item{no_match_clust}{Vector of cluster labels which should not be matched
to class labels.}

\item{prec_rec}{Logical: whether precision and recall vectors are returned.}
}
\value{
List:
\itemize{
\item f1_mat: matrix of pairwise F1 measure values for every class and cluster
with matched values on the diagonal.
\item f1_vec: vector of matched F1 measure values for each class.
\item pr_vec (if \code{prec_rec = TRUE}): vector of matched precision values for each
class.
\item re_vec (if \code{prec_rec = TRUE}): vector of matched recall values for each
class.
}
}
\description{
Compare a vector of cluster labels to another vector of class labels using
the F1 measure with cluster - class matching carried out using the Hungarian
algorithm. Particular classes or clusters may be excluded from this matching.
Observations of a certain class may also be removed completely.
}
