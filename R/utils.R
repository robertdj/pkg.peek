package_name_from_filename <- function(package_file) {
    package_file_sans_path <- basename(package_file)
    package_name_end <- regexpr("_", package_file_sans_path) - 1

    substr(package_file_sans_path, 1, package_name_end)
}


package_ext <- function(archive_file) {
    if (endsWith(archive_file, ".tar.gz")) {
        file_ext <- "tar.gz"
    } else {
        file_ext <- tools::file_ext(archive_file)
    }

    match.arg(file_ext, c("tar.gz", "tgz", "zip"))
}


is_string <- function(x) {
    is.character(x) && length(x) == 1
}
