#' Get name of package
#'
#' Get the name of the package as it is specified in the DESCRIPTION file.
#'
#' @inheritParams get_file_in_archive
#'
#' @return A character.
#'
#' @export
get_package_name <- function(archive) {
    desc <- get_package_desc(archive)

    as.character(desc["Package"])
}
