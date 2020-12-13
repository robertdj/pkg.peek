test_that("Get package extension", {
    expect_equal(package_ext("package.tar.gz"), "tar.gz")
    expect_equal(package_ext("package.tgz"), "tgz")
    expect_equal(package_ext("package.zip"), "zip")

    expect_error(package_ext("package.bar"), regexp = "'arg' should be one of")
})
