library(dplyr)
library(rvest)

df_countrycode <-
  countrycode::codelist %>%
  select(country_name = country.name.en, continent, region, iso2c, iso3c, iso3n) %>%
  mutate(iso3n = if_else(is.na(iso3n),
                         NA_character_,
                         sprintf("%03d", iso3n))) %>%
  as_tibble() %>%
  mutate(iso2c = stringr::str_to_lower(iso2c)) %>%
  add_row(country_name = "Kosovo", continent = "Europe", iso2c = "xk", iso3c = "XKX", iso3n = NA)

df_hfu <-
  jsonlite::fromJSON("https://raw.githubusercontent.com/tabularmaps/8bit-tile/master/8bit.geojson") %>%
  tibble::as_tibble() %>%
  pull(features) %>%
  pull(properties) %>%
  as_tibble()

df_wiki <-
  xml2::read_html("https://en.wikipedia.org/wiki/ISO_3166-1") %>%
  rvest::html_nodes(xpath = '//*[@id="mw-content-text"]/div/table[2]') %>%
  rvest::html_table() %>%
  as.data.frame() %>%
  tibble::as_tibble() %>%
  mutate(Alpha.2.code = if_else(is.na(Alpha.2.code), "NA", Alpha.2.code)) %>%
  mutate(Alpha.2.code = stringr::str_to_lower(Alpha.2.code)) %>%
  select(country_name = English.short.name..using.title.case.,
         iso2c = Alpha.2.code,
         iso3c = Alpha.3.code,
         iso3n = Numeric.code) %>%
  add_row(country_name = "Kosovo", iso2c = "xk", iso3c = "XKX", iso3n = NA)

iso3166 <-
  tibble(
    iso2c = c("cl", "pe", "ec", "co", "pa", "cr", "ni", "sv", "gt", "mx", "bm", "us", "pm", "ca", "gl",
               "ar", "py", "bo", "ve", "aw", "ky", "hn", "bz", "gi", "pt", "fr", "gb", "im", "ie", "is",
               "fk", "uy", "br", "bq", "cw", "jm", "tc", "cu", "es", "ad", "mc", "je",
               "gg", "sj",
               "gs", "gy", "tt", "ai", "do", "ht", "bs", "pr", "mt", "it", "lu", "be", "nl", "fo", "no",
               "gf", "sr", "vc", "bl", "kn", "ag", "vg", "mf", "vi", "va", "sm", "ch", "li", "dk", "se",
               "na", "gd", "bb", "lc", "mq", "dm", "gp", "ms", "sx", "me", "hr", "si", "at", "cz", "de", "ax",
               "za", "bw", "gw", "gm", "sn", "cv", "sh", "mr", "eh", "gr", "al", "ba", "hu", "sk", "pl", "fi",
               "ls", "st", "gq", "ci", "lr", "sl", "gn", "ml", "ma", "cy", "mk", "xk", "rs", "lt", "lv", "ee",
               "sz", "cg", "ga", "cm", "ng", "gh", "bf", "ne", "dz", "il", "ps", "lb", "kw", "bg", "ro", "by",
               "zw", "ao", "cd", "cf", "td", "bj", "tg", "er", "tn", "jo", "sy", "bh", "iq", "md", "ua", "ru",
               "mz", "zm", "mw", "bi", "rw", "ug", "ke", "dj", "ly", "ye", "sa", "qa", "ir", "tr", "am", "ge",
               "bv", "tz", "yt", "km", "mu", "sc", "et", "ss", "sd", "om", "ae", "af", "np", "az", "tm", "uz",
               "aq", "hm", "au", "mg", "re", "io", "mv", "so", "eg", "in", "pk", "th", "mm", "bt", "tj", "kg",
               "tf", "nz", "nf", "pg", "wf", "tv", "pw", "gu", "cx", "lk", "bd", "my", "la", "mo", "cn", "kz",
               "nc", "fj", "vu", "ki", "nr", "mh", "fm", "mp", "tl", "cc", "kh", "sg", "vn", "hk", "tw", "mn",
               "pn", "ck", "pf", "sb", "to", "nu", "as", "ws", "tk", "um", "id", "bn", "ph", "jp", "kr", "kp")
  ) %>%
  add_row(.before = 1) %>%
  add_row(.after = 16) %>%
  add_row(.after = 32) %>%
  add_row(.after = 45) %>%
  add_row(.after = 48) %>%
  add_row(.after = 64) %>%
  mutate(x = c(rep(seq.int(16), each = 16)),
         y = c(rep(seq.int(16), times = 16))) %>%
  filter(!is.na(iso2c))

iso3166 <-
  iso3166 %>%
  left_join(df_hfu, by = c("iso2c" = "iso2cd")) %>%
  select(country_name = maplab, iso2c, iso3c = iso3cd, x, y) %>%
  left_join(df_countrycode %>%
              select(-country_name),
            by = c("iso2c", "iso3c")) %>%
  mutate(continent = if_else(is.na(continent),
                             recode(iso2c,
                                    gs = "Americas",
                                    bv = "Antarctica",
                                    aq = "Antarctica", # ATA
                                    hm = "Oceania",
                                    io = "Asia",
                                    tf = "Antarctica",
                                    cc = "Asia",
                                    um = "Oceania"),
                             continent)) %>%
  select(country_name, continent, region, iso2c, iso3c, iso3n, x, y)

iso3166 %>%
  anti_join(df_hfu, by = c("iso2c" = "iso2cd"))
iso3166 %>%
  anti_join(df_countrycode, by = c("iso2c"))
iso3166 %>%
  anti_join(df_countrycode, by = "country_name") # 43 rows
iso3166 %>%
  filter(is.na(region)) # 10 rows

usethis::use_data(iso3166, overwrite = TRUE)
