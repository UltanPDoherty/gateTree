% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/check_table.R
\name{check_table_inner}
\alias{check_table_inner}
\title{Inner function used by \link{check_table}.}
\usage{
check_table_inner(plusminus_table, initial = FALSE)
}
\arguments{
\item{plusminus_table}{Table indicating whether each population (row) is positive (+1),
negative (-1), or neutral / unknown (0) for each variable (column).}

\item{initial}{Logical: whether this is the initial check before the loop.}
}
\value{
If \code{initial = FALSE}, then \code{check_table_inner} returns a list:
\itemize{
\item pop_group_label: integer vector of population group labels
\item result: \code{"success"}, \code{"continue"}, or \code{"fail"}.
}

If \code{initial = TRUE}, \code{check_table_inner} returns \code{NULL}.
}
\description{
Non-recursive / non-iterative check of a single \code{plusminus_table} sub-table.
}
