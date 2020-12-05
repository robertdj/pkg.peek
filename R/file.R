#' Get package DESCRIPTION file
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package's DESCRIPTION file parsed by [read.dcf()]
#'
#' @export
get_package_desc <- function(archive) {
    package_name <- package_name_from_filename(archive)

    desc_file <- get_file_in_archive(archive, fs::path(package_name, "DESCRIPTION"))

    desc <- tryCatch(read.dcf(desc_file), error = identity)

    if ((inherits(desc, "error")) || (length(desc) == 0))
        stop("Malformed DESCRIPTION in ", archive)

    return(desc[1L, ])
}


#' Get package meta data
#'
#' The package meta data is a parsed version of the `DESCRIPTION` file plus information about the
#' installation/compilation of the package.
#' Note that this only works for **compiled** package archives, that is, archives that are generated
#' with `devtools::build(binary = TRUE)` or on the command line with
#' ```
#' R CMD INSTALL --build <package folder>
#' ```
#'
#' @inheritParams get_file_in_archive
#'
#' @return The package meta data as a list.
#'
#' @export
get_package_meta <- function(archive) {
    package_name <- package_name_from_filename(archive)

    # TODO: Check that archive is a compiled package

    meta_file <- get_file_in_archive(archive, fs::path(package_name, "Meta", "package.rds"))

    meta <- tryCatch(readRDS(meta_file), error = identity)

    if (inherits(meta, "error"))
        stop("Malformed package meta data in ", archive)

    return(meta)
}


#' Get file in archive
#'
#' Get a file in a compressed archive.
#'
#' @param archive `[character]` The path of the archive.
#' @param package_file `[character]` The file inside the archive.
#'
#' @return The path to the *extracted* `package_file`. This will be in the R session's temporary
#' folder.
#'
#' @export
get_file_in_archive <- function(archive, package_file) {
    assertthat::assert_that(
        assertthat::is.string(package_file)
    )

    unpacking_dir <- fs::path_temp("cranitor", tools::file_path_sans_ext(basename(archive)))
    withr::defer_parent(fs::dir_delete(unpacking_dir))

    # Running "untar" is noisy if system tar has warnings/errors
    # I don't know how to avoid this, since untar does not allow passing arguments on to "system"
    # (ignore.stdout and ignore.stderr)
    if (package_ext(archive) == "zip") {
        status <- tryCatch(
            utils::unzip(archive, files = package_file, exdir = unpacking_dir),
            warning = identity
        )
    } else if (package_ext(archive) %in% c("tgz", "tar.gz")) {
        status <- tryCatch(
            utils::untar(archive, files = package_file, exdir = unpacking_dir),
            warning = identity
        )
    } else {
        rlang::abort("Unknown archive extension")
    }

    if (inherits(status, "warning"))
        stop(package_file, " does not exist in ", archive)

    fs::path(unpacking_dir, package_file)
}
