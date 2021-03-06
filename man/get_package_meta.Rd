% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/metadata.R
\name{get_package_meta}
\alias{get_package_meta}
\title{Get package meta data}
\usage{
get_package_meta(archive)
}
\arguments{
\item{archive}{\verb{[character]} The path of the archive.}
}
\value{
The package meta data as a list.
}
\description{
The package meta data is a parsed version of the \code{DESCRIPTION} file plus information about the
installation/compilation of the package.
Note that this only works for \strong{compiled} package archives, that is, archives that are generated
with \code{devtools::build(binary = TRUE)} or on the command line with\preformatted{R CMD INSTALL --build
}
}
