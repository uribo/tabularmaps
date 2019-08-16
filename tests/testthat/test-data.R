test_that("dataset statement", {
  expect_is(jpn77, "data.frame")
  expect_named(jpn77, c("jis_code",
                        "prefecture", "capital", "region", "major_island",
                        paste0(c("prefecture", "capital", "region", "major_island"), "_en"),
                        "x", "y"))
  expect_equal(dim(jpn77), c(47, 11))
})
