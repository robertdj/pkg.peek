#' Get file in archive
#'
#' Get a file in a compressed archive.
#'
#' @details The extracted file will be in the R session's temporary folder and will *not* be
#' deleted (before the temporary folder is deleted upon ending the R session)..
#'
#' @param archive `[character]` The path of the archive.
#' @param package_file `[character]` The file inside the archive.
#'
#' @return The path to the *extracted* `package_file`.
#'
#' @export
get_file_in_archive <- function(archive, package_file) {
    stopifnot(
        is_string(archive),
        is_string(package_file)
    )

    unpacking_dir <- file.path(tempdir(), "pkg.peek", tools::file_path_sans_ext(basename(archive)))

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
    }

    if (inherits(status, "warning"))
        stop(package_file, " does not exist in ", archive)

    file.path(unpacking_dir, package_file)
}
