#' Get package DESCRIPTION file
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package's DESCRIPTION file parsed by [read.dcf()]
#'
#' @export
get_package_desc <- function(archive) {
    package_name <- package_name_from_filename(archive)

    desc_file <- get_file_in_archive(paste(package_name, "DESCRIPTION", sep = "/"), archive)
    # TODO: unpackage_dir is used internally in get_file_in_archive. Is using it here complecting?
    on.exit(unlink(unpacking_dir(archive), recursive = TRUE), add = TRUE)

    desc <- tryCatch(read.dcf(desc_file), error = identity)

    if ((inherits(desc, "error")) || (length(desc) == 0))
        stop("Malformed DESCRIPTION in ", archive)

    return(desc[1L, ])
}
