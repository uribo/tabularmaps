## code to prepare `jpn77` dataset goes here
library(dplyr)

jpn77 <-
  tibble(
  jis_code = sprintf("%02d",
                     c(47, 46, 43, 41, 42, 35,
                       39, 38, 45, 44, 40, 32,
                       36, 37, 27, 28, 34, 33, 31,
                       24, 30, 29, 26, 25, 18, 17,
                       23, 22, 21, 19, 20, 16, 15,
                       14, 13, 11, 10, 6, 5, 2,
                       12, 8, 9, 7, 4, 3, 1))
) %>%
  left_join(jpndistrict::jpnprefs %>%
              select(-capital_latitude, -capital_longitude) %>%
              mutate_at(vars(starts_with("region")), .funs = forcats::as_factor),
            by = "jis_code") %>%
  add_row(.after = 6) %>%
  add_row(.after = 13) %>%
  mutate(x = c(rep(seq.int(7), each = 7)),
         y = c(rep(seq.int(7), times = 7))) %>%
  filter(!is.na(jis_code))

usethis::use_data(jpn77, overwrite = TRUE)


