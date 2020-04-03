####################################
# 東京23区
####################################
tky23 <-
  tibble::tibble(
    no = sprintf("%02d", seq.int(23)),
    ward = c("Chiyoda", "Chyuo", "Minato", "Shinjuku", "Bunkyo",
             "Taito", "Sumida", "Koto", "Shinagawa", "Meguro",
             "Ota", "Setagaya", "Shibuya", "Nakano", "Suginami",
             "Toshima", "Kita", "Arakawa", "Itabashi", "Nerima",
             "Adachi", "Katsushika", "Edogawa"),
    ward_kanji = c("千代田区", "中央区", "港区", "新宿区", "文京区",
                 "台東区", "墨田区", "江東区", "品川区", "目黒区",
                 "大田区", "世田谷区", "渋谷区", "中野区", "杉並区",
                 "豊島区", "北区", "荒川区", "板橋区", "練馬区",
                 "足立区", "葛飾区", "江戸川区"),
  x = c(3, 4, 3, 2, 3,
        4, 4, 5, 2, 2,
        1, 1, 2, 1, 1,
        3, 3, 4, 2, 1, 4, 5,
        5),
  y = c(2, 1, 1, 4, 3,
        3, 2, 3, 1, 2,
        1, 2, 3, 4, 3,
        4, 5, 4, 5, 5, 5, 5,
        4))
usethis::use_data(tky23, overwrite = TRUE)
