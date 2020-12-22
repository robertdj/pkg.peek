#' Is package built?
#'
#' Determine if a package archive is built/compiled. Only relevant for `tar.gz` archives (on Linux).
#'
#' @inheritParams get_file_in_archive
#'
#' @return A boolean.
#'
#' @export
is_package_built <- function(archive) {
    desc <- get_package_desc(archive)

    if (is.na(desc["Built"]))
        return(FALSE)
    else
        return(TRUE)
}
