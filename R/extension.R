package_ext <- function(archive_file) {
    if (endsWith(archive_file, ".tar.gz")) {
        file_ext <- "tar.gz"
    } else {
        file_ext <- tools::file_ext(archive_file)
    }

    match.arg(file_ext, c("tar.gz", "tgz", "zip"))
}
