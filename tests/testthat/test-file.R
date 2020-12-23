test_that("Get NAMESPACE from source package", {
    n <- get_file_in_archive("foo/NAMESPACE", source_package)

    expect_true(startsWith(readLines(n), "exportPattern"))
})


test_that("Error getting non-existing file", {
    expect_error(get_file_in_archive("NAMESPACE", source_package))
})
