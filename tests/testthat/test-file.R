test_that("Get NAMESPACE from source package", {
    n <- get_file_in_archive(source_package, "foo/NAMESPACE")

    expect_true(startsWith(readLines(n), "exportPattern"))
})


test_that("Error getting non-existing file", {
    expect_error(get_file_in_archive(source_package, "NAMESPACE"))
})

