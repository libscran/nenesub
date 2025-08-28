# library(testthat); library(nenesub); source("test-nenesub.R")

test_that("nenesub gives the same results as a reference calculation", {
    x <- matrix(rnorm(10000), nrow=10)

    ref <- reference(x, 20, 10)
    out <- compute(x, 20, 10)
    expect_identical(ref, out)

    ref <- reference(x, 20, 5)
    out <- compute(x, 20, 5)
    expect_identical(ref, out)

    ref <- reference(x, 10, 5)
    out <- compute(x, 10, 5)
    expect_identical(ref, out)
})

test_that("also works with a uniform distribution", {
    x <- matrix(runif(10000), nrow=5)

    ref <- reference(x, 20, 10)
    out <- compute(x, 20, 10)
    expect_identical(ref, out)

    ref <- reference(x, 20, 5)
    out <- compute(x, 20, 5)
    expect_identical(ref, out)

    ref <- reference(x, 10, 5)
    out <- compute(x, 10, 5)
    expect_identical(ref, out)
})
