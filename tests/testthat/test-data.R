test_that("dataset statement", {
  expect_is(jpn77, "data.frame")
  expect_named(jpn77, c("jis_code",
                        "prefecture", "region", "major_island",
                        paste0(c("prefecture", "region"), "_kanji"),
                        "x", "y"))
  expect_equal(dim(jpn77), c(47, 8))
  expect_is(tky23, "data.frame")
  expect_named(tky23,
               c("no", "ward", "ward_kanji", "x", "y"))
  expect_identical(unname(sapply(tky23, class)),
                   c(rep("character", 3),
                     rep("numeric", 2)))
})
