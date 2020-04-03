#' @title Japan 7x7 grid dataset
#'
#' @description Prefectures dataset.
#' @format A data frame with 47 rows 8 variables:
#' \itemize{
#'   \item{jis_code: jis code}
#'   \item{prefecture: prefecture names}
#'   \item{region: region}
#'   \item{major_island: }
#'   \item{prefecture_kanji: }
#'   \item{region_kanji: }
#'   \item{x: Coordinates for displaying as tabularmap}
#'   \item{y: Coordinates for displaying as tabularmap}
#' }
"jpn77"

#' @title Special wards of Tokyo
#'
#' @description Tokyo 23 wards dataset.
#' @format A data frame with 23 rows 5 variables:
#' - no: Identifical number
#' - ward: Name
#' - ward_kanji: Names in Kanji
#' - x, y: Coordinates for displaying as tabularmap
"tky23"

#' @title Country list
#'
#' @description A data frame include ISO-3166 codes.
#' @format A data frame with 250 rows 8 variables:
#' \itemize{
#'   \item{country_name: }
#'   \item{continent: }
#'   \item{region: }
#'   \item{iso2c: }
#'   \item{iso3c: }
#'   \item{iso3n: 3 digits number (as character)}
#'   \item{x: Coordinates for displaying as tabularmap}
#'   \item{y: Coordinates for displaying as tabularmap}
#' }
"iso3166"
