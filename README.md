pkg.peek
========

<!-- badges: start -->
[![R build status](https://github.com/robertdj/pkg.peek/workflows/R-CMD-check/badge.svg)](https://github.com/robertdj/pkg.peek/actions)
[![Codecov test coverage](https://codecov.io/gh/robertdj/pkg.peek/branch/master/graph/badge.svg)](https://codecov.io/gh/robertdj/pkg.peek?branch=master)
<!-- badges: end -->

R packages are bundled in a `tar.gz`, a `tgz` or a `zip` archive.
Information about a package is included in the archive and {pkg.peek} can help to extract it.

My usecase is in the [{cranitor} package](https://github.com/robertdj/cranitor) where an archive is handled according to the operating system and R version used to generate it.


## Installation

{pkg.peek} is only on GitHub and can be installed using the [remotes package](https://remotes.r-lib.org) with the command:

``` r
remotes::install_github("robertdj/pkg.peek")
```

## Example

Archives come in two forms: Compiled or only with source code.

If the archive is created with e.g. `devtools::build(binary = FALSE)` it only contains the source code and it is a `tar.gz` file.

If the archive is created with e.g. `devtools::build(binary = TRUE)` all code in the package is compiled and the file type depends on the operating system used to perform the compilation.
Such a compiled package is specific to the operating system -- a package compiled on Linux cannot be used on macOS.

A compiled package archive contains information about the operating system and R used to compile it.
As an example, {pkg.peek} has a function to extract the version of R used for compilation:

``` r
pkg.peek::get_r_version("<path/to/package_archive>")
```
