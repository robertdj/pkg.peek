make_corrupted_archive <- function(tmp_file) {
    withr::with_tempdir({
        parent_dir <- dirname(tmp_file)
        if (!dir.exists(parent_dir))
            dir.create(parent_dir, recursive = TRUE)

        writeLines("foobar", con = tmp_file)

        targz_file <- file.path(tempdir(), "baz_0.0.1.tar.gz")

        utils::tar(
            tarfile = targz_file, files = tmp_file,
            compression = "gzip", compression_level = 9L, tar = "tar"
        )
    })

    return(targz_file)
}


create_empty_package <- function(package_name, version, ...) {
    package_path <- file.path(tempdir(), package_name)
    if (!dir.exists(package_path))
        dir.create(package_path)

    withr::defer(unlink(package_path, recursive = TRUE))

    writeLines(
        "exportPattern(\"^[^\\\\.]\")",
        con = file.path(package_path, "NAMESPACE")
    )

    writeLines(c(
        paste("Package:", package_name),
        "Title: Test package for pkg.peek",
        paste("Version:", version),
        "Authors@R: person('First', 'Last', role = c('aut', 'cre'), email = 'first.last@example.com')",
        "Description: Test package for pkg.peek.",
        "License: MIT",
        "Encoding: UTF-8",
        "LazyData: true"
        ),
        con = file.path(package_path, "DESCRIPTION")
    )

    pkgbuild::build(path = package_path, ...)
}
