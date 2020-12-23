#' Get package DESCRIPTION file
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package's DESCRIPTION file parsed by [read.dcf()]
#'
#' @export
get_package_desc <- function(archive) {
    package_name <- package_name_from_filename(archive)

    extract_dir <- unpacking_dir(archive)
    desc_path <- paste(package_name, "DESCRIPTION", sep = "/")
    desc_file <- get_file_in_archive(desc_path, archive, extract_dir)
    on.exit(unlink(extract_dir, recursive = TRUE), add = TRUE)

    desc <- tryCatch(read.dcf(desc_file), error = identity)

    if ((inherits(desc, "error")) || (length(desc) == 0))
        stop("Malformed DESCRIPTION in ", archive)

    return(desc[1L, ])
}
