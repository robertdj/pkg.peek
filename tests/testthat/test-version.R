test_that("Get R version from binary package", {
    r_version <- get_r_version(binary_package)

    expect_equal(r_version, getRversion())
})


test_that("Error getting R version from source package", {
    expect_error(get_r_version(source_package), regexp = "is not a binary package")
})


test_that("Get package version from binary package", {
    package_version <- get_package_version(source_package)

    expect_equal(package_version, package_version("0.0.1"))
})
