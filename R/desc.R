#' Get package DESCRIPTION file
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package's DESCRIPTION file parsed by [read.dcf()]
#'
#' @export
get_package_desc <- function(archive) {
    package_name <- package_name_from_filename(archive)

    desc_file <- get_file_in_archive(archive, paste(package_name, "DESCRIPTION", sep = "/"))
    on.exit(file.remove(desc_file), add = TRUE)
    # on.exit(unlink(dirname(desc_file)), add = TRUE)

    desc <- tryCatch(read.dcf(desc_file), error = identity)

    if ((inherits(desc, "error")) || (length(desc) == 0))
        stop("Malformed DESCRIPTION in ", archive)

    return(desc[1L, ])
}


#' Get fields from DESCRIPTION file
#'
#' @inheritParams get_file_in_archive
#' @param field `[character]` A vector of field names to return.
#'
#' @return The fields in a named vector.
#'
#' @export
get_desc_field <- function(archive, field) {
    assertthat::assert_that(
        is.character(field)
    )

    desc <- get_package_desc(archive)

    desc_entry_matches <- field %in% names(desc)
    if (!all(desc_entry_matches))
        stop("These fields are not in DESCRIPTION: ", paste(field[!desc_entry_matches], collapse = ", "))

    desc[field]
}
