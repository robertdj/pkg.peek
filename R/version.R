#' Get R version used for build
#'
#' Get the R version used to build the package archive.
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package as an `R_system_version` -- see [getRversion()].
#'
#' @export
get_r_version <- function(archive) {
    if (!is_package_built(archive))
        stop(archive, " is not a binary package")

    md <- get_package_meta(archive)

    md$Built$R
}


#' Get version of package
#'
#' Get the version of the package as it is specified in the DESCRIPTION file.
#'
#' @inheritParams get_file_in_archive
#'
#' @return A [package_version()].
#'
#' @export
get_package_version <- function(archive) {
    desc <- get_package_desc(archive)

    package_version_as_string <- as.character(desc["Version"])
    package_version(package_version_as_string)
}
