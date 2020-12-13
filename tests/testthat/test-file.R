# Setup packages ------------------------------------------------------------------------------

source_package <- create_empty_package("foo", "0.0.1", binary = FALSE, quiet = TRUE)
binary_package <- create_empty_package("foo", "0.0.1", binary = TRUE, quiet = TRUE)


# Get data from packages ----------------------------------------------------------------------

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


test_that("Get meta data from binary package", {
    m <- get_package_meta(binary_package)
    expect_s3_class(m, "packageDescription2")
})


test_that("Get R version from binary package", {
    # r_version <- get_r_version(binary_package)
    # expect_equal(r_version, getRversion())
})


# Get expected errors -------------------------------------------------------------------------

test_that("Error getting meta data from source package", {
    expect_error(get_package_meta(source_package))
})


test_that("Error getting non-existing DESCRIPTION", {
    corrupted_archive <- make_corrupted_archive("DESCRIPTION")
    expect_error(get_package_desc(corrupted_archive), regexp = "baz/DESCRIPTION does not exist")
})


test_that("Error getting malformed DESCRIPTION", {
    corrupted_archive <- make_corrupted_archive("baz/DESCRIPTION")
    expect_error(get_package_desc(corrupted_archive), regexp = "Malformed DESCRIPTION")
})
