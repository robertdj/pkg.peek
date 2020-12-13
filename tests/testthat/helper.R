make_corrupted_archive <- function(tmp_file) {
    withr::with_tempdir({
        fs::dir_create(dirname(tmp_file))
        writeLines("foobar", con = tmp_file)

        targz_file <-  fs::path_temp("baz_0.0.1.tar.gz")

        utils::tar(
            tarfile = targz_file, files = tmp_file,
            compression = "gzip", compression_level = 9L, tar = "tar"
        )
    })

    return(targz_file)
}


create_empty_package <- function(package_name, version, ...) {
    if (!rlang::is_installed("pkgbuild"))
        rlang::abort("'create_empty_package' requires pkgbuild")

    package_path <- fs::path_temp(package_name)
    fs::dir_create(package_path)
    withr::defer(fs::dir_delete(package_path))

    writeLines(
        "exportPattern(\"^[^\\\\.]\")",
        con = fs::path(package_path, "NAMESPACE")
    )

    writeLines(c(
        paste("Package:", package_name),
        "Title: Test package for archivist",
        paste("Version:", version),
        "Authors@R: person('First', 'Last', role = c('aut', 'cre'), email = 'first.last@example.com')",
        "Description: Test package for archivist.",
        "License: MIT",
        "Encoding: UTF-8",
        "LazyData: true"
        ),
        con = fs::path(package_path, "DESCRIPTION")
    )

    pkgbuild::build(path = package_path, ...)
}
