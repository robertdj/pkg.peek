#' Get R version used for build
#'
#' Get the R version used to build the package archive.
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package as a `R_system_version` -- see [getRversion()].
#'
#' @export
get_r_version <- function(archive) {
    md <- get_package_meta(archive)

    md$Built$R
}
