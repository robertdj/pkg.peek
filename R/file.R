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

    unpacking_dir <- fs::path_temp("pkg.peek", tools::file_path_sans_ext(basename(archive)))
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
