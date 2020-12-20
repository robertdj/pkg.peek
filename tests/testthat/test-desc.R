test_that("Get DESCRIPTION from source package", {
    d <- get_package_desc(source_package)
    expect_type(d, "character")

    expect_false("Built" %in% names(d))
})


test_that("Get DESCRIPTION from binary package", {
    d <- get_package_desc(binary_package)
    expect_type(d, "character")

    expect_true("Built" %in% names(d))
})


test_that("Binary package is built", {
    expect_true(is_package_built(binary_package))
})


test_that("Source package is not built", {
    expect_false(is_package_built(source_package))
})

# Get expected errors -------------------------------------------------------------------------

test_that("Error getting non-existing DESCRIPTION", {
    corrupted_archive <- make_corrupted_archive("DESCRIPTION")
    expect_error(get_package_desc(corrupted_archive), regexp = "baz/DESCRIPTION does not exist")
})


test_that("Error getting malformed DESCRIPTION", {
    corrupted_archive <- make_corrupted_archive("baz/DESCRIPTION")
    expect_error(get_package_desc(corrupted_archive), regexp = "Malformed DESCRIPTION")
})
