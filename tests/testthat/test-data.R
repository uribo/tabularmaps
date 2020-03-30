test_that("dataset statement", {
  expect_is(jpn77, "data.frame")
  expect_named(jpn77, c("jis_code",
                        "prefecture", "region", "major_island",
                        paste0(c("prefecture", "region"), "_kanji"),
                        "x", "y"))
  expect_equal(dim(jpn77), c(47, 8))
})
