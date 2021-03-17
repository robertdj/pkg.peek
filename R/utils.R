#' Get file extension of package archive
#'
#' Get the file extension of a package archive if it is valid (`tar.gz`, `tgz` or `zip`).
#' An error is thrown if the extension is not valid.
#'
#' @param archive_file Path to a package archive.
#'
#' @return The file extension.
#'
#' @export
package_ext <- function(archive_file) {
    if (endsWith(archive_file, ".tar.gz")) {
        file_ext <- "tar.gz"
    } else {
        file_ext <- tools::file_ext(archive_file)
    }

    match.arg(file_ext, c("tar.gz", "tgz", "zip"))
}


package_name_from_filename <- function(package_file) {
    package_file_sans_path <- basename(package_file)
    package_name_end <- regexpr("_", package_file_sans_path) - 1

    substr(package_file_sans_path, 1, package_name_end)
}


is_string <- function(x) {
    is.character(x) && length(x) == 1
}


unpacking_dir <- function(archive) {
    file.path(
        tempdir(), "pkg.peek",
        tools::file_path_sans_ext(basename(archive), compression = TRUE)
    )
}
