## code to prepare `jpn77` dataset goes here
library(dplyr)
data("jpnprefs", package = "zipangu")
jpnprefs <-
  jpnprefs %>%
  mutate(
    region_kanji =
    c("北海道",
      rep("東北", 6),
      rep("関東", 7),
      rep("中部", 9),
      rep("関西", 7),
      rep("中国", 5),
      rep("四国", 4),
      rep("九州", 8))
  ) %>%
  mutate_at(vars(contains("region")),
            forcats::as_factor)

jpn77 <-
  tibble::tibble(
  jis_code = sprintf("%02d",
                     c(47, 46, 43, 41, 42, 35,
                       39, 38, 45, 44, 40, 32,
                       36, 37, 27, 28, 34, 33, 31,
                       24, 30, 29, 26, 25, 18, 17,
                       23, 22, 21, 19, 20, 16, 15,
                       14, 13, 11, 10, 6, 5, 2,
                       12, 8, 9, 7, 4, 3, 1))) %>%
  left_join(jpnprefs,
            by = "jis_code") %>%
  tibble::add_row(.after = 6) %>%
  tibble::add_row(.after = 13) %>%
  mutate(x = rep(seq.int(7), each = 7),
         y = rep(seq.int(7), times = 7)) %>%
  filter(!is.na(jis_code)) %>%
  select(jis_code, prefecture, region, major_island, ends_with("kanji"), x, y) %>%
  mutate(y = if_else(y == 7L & x == 5L,
                     6L,
                     if_else(y == 6L & x == 5L,
                             7L,
                             y)))
usethis::use_data(jpn77, overwrite = TRUE)
