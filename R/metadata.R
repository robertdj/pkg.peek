#' Get package meta data
#'
#' The package meta data is a parsed version of the `DESCRIPTION` file plus information about the
#' installation/compilation of the package.
#' Note that this only works for **compiled** package archives, that is, archives that are generated
#' with `devtools::build(binary = TRUE)` or on the command line with
#' ```
#' R CMD INSTALL --build
#' ```
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package meta data as a list.
#'
#' @export
get_package_meta <- function(archive) {
    package_name <- package_name_from_filename(archive)

    meta_file <- get_file_in_archive(archive, paste(package_name, "Meta", "package.rds", sep = "/"))
    # on.exit(file.remove(meta_file), add = TRUE)
    on.exit(unlink(dirname(meta_file)), add = TRUE)

    meta <- tryCatch(readRDS(meta_file), error = identity)

    if (inherits(meta, "error"))
        stop("Malformed package meta data in ", archive)

    return(meta)
}
