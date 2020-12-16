test_that("Get package extension", {
    expect_equal(package_ext("package.tar.gz"), "tar.gz")
    expect_equal(package_ext("package.tgz"), "tgz")
    expect_equal(package_ext("package.zip"), "zip")

    expect_error(package_ext("package.bar"), regexp = "'arg' should be one of")
})

test_that("Check strings", {
    expect_true(is_string("foo"))
    expect_true(is_string(NA_character_))

    expect_false(is_string(c("foo", "bar")))

    expect_false(is_string(1))
    expect_false(is_string(TRUE))
})
