test_that("Get meta data from binary package", {
    m <- get_package_meta(binary_package)
    expect_s3_class(m, "packageDescription2")
})


test_that("Error getting meta data from source package", {
    expect_error(get_package_meta(source_package), regexp = "Meta/package.rds does not exist")
})
