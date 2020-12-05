package_name_from_filename <- function(package_file) {
    package_file_sans_path <- basename(package_file)
    substr(package_file_sans_path, 1, regexpr("_", package_file_sans_path) - 1)
}
