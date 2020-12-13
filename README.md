pkg.peek
========

<!-- badges: start -->
[![R build status](https://github.com/robertdj/pkg.peek/workflows/R-CMD-check/badge.svg)](https://github.com/robertdj/pkg.peek/actions)
<!-- badges: end -->

R packages are bundled in a `tar.gz`, a `tgz` or a `zip` archive.
Information about a package is included in the archive and {pkg.peek} can help to extract it.
As an example, if the archive contains a binary package it includes the version of R used to compile it.

## Installation

{pkg.peek} is only on GitHub and can be installed using the [remotes package](https://remotes.r-lib.org) with the command:

``` r
remotes::install_github("robertdj/pkg.peek")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(pkg.peek)
## basic example code
```

