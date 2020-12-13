test_that("Get R version from binary package", {
    r_version <- get_r_version(binary_package)

    expect_equal(r_version, getRversion())
})
