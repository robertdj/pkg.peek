#' Get file in archive
#'
#' Get a file in a compressed archive.
#'
#' @details The extracted `package_file` is *not* deleted automatically. Cleaning up is left to the
#' caller.
#'
#' @param package_file `[character]` The file inside the archive.
#' @param archive `[character]` The path of the archive.
#' @param extract_dir `[character]` The folder to extract `package_file` to. If missing it will be
#' in the R session's temporary folder.
#'
#' @return The path to the extracted `package_file`.
#'
#' @export
get_file_in_archive <- function(package_file, archive, extract_dir) {
    stopifnot(
        is_string(archive),
        is_string(package_file),
        missing(extract_dir) || is_string(extract_dir)
    )

    if (missing(extract_dir))
        extract_dir <- unpacking_dir(archive)

    # Running "untar" is noisy if system tar has warnings/errors
    # I don't know how to avoid this, since untar does not allow passing arguments on to "system"
    # (ignore.stdout and ignore.stderr)
    if (package_ext(archive) == "zip") {
        status <- tryCatch(
            utils::unzip(archive, files = package_file, exdir = extract_dir),
            warning = identity
        )
    } else if (package_ext(archive) %in% c("tgz", "tar.gz")) {
        status <- tryCatch(
            utils::untar(archive, files = package_file, exdir = extract_dir),
            warning = identity
        )
    }

    if (inherits(status, "warning"))
        stop(package_file, " does not exist in ", archive)

    file.path(extract_dir, package_file)
}
