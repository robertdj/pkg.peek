test_that("Get name from package", {
    expect_equal(get_package_name(source_package), "foo")
})
