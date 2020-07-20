#' @title Create Tile-Grid
#'
#' @description A ggplot2-based tabularmap that places a coordinated dataset
#' in a rectangle.
#' @import ggplot2
#' @import rlang
#' @importFrom ggforce geom_shape
#' @importFrom purrr pluck
#' @param data data.frame. Contain x, y, group and label variables used as
#' coordinates.
#' @param x,y A column containing the numbers to line up the items.
#' @param group Group variable.
#' @param fill Fill colour variable.
#' @param label Label variable.
#' @param ... All other arguments passed on to [ggplot2::geom_text()]
#' include label `family`.
#' @param .expand_size The value specified in the `expand` argument of
#' [ggforce::geom_shape()]. The unit is in mm.
#' @param .radius_size The value specified in the `radius` argument of
#' [ggforce::geom_shape()]. The unit is in pt.
#' @examples
#' library(ggplot2)
#' tabularmap(jpn77, x, y, group = jis_code, label = prefecture, size = 3)
#' tabularmap(jpn77, x, y, group = jis_code, fill = region, label = prefecture, size = 3) +
#'   theme_tabularmap() +
#'   scale_fill_jpregion(lang = "en")
#' tabularmap(data.frame(
#'              id = letters[seq.int(9)],
#'              x = rep(c(1,2,3), each = 3),
#'              y = rep(c(1,2,3), times = 3),
#'              fill = seq.int(9),
#'              label = letters[seq.int(9)]),
#'   x, y,
#'   group = id,
#'   fill = fill,
#'   label = label,
#'   .expand_size = 20, .radius_size = 10)
#' tabularmap(iso3166, x, y, group = iso2c,
#'            fill = continent,
#'            label = iso2c,
#'            .expand_size = 5) +
#'   theme_tabularmap() +
#'   guides(fill = FALSE)
#' @rdname tabularmap
#' @export
tabularmap <- function(data, x, y, group, fill = NULL, label = NULL, ...,
                       .expand_size = 10, .radius_size = 2) {
  ggplot(data, aes(x = {{ x }}, y = {{ y }})) +
    ggforce::geom_shape(aes(fill = {{ fill }}, group = {{ group }}),
                        expand = unit(.expand_size, "mm"),
                        radius = unit(.radius_size, "pt")) +
    geom_text(aes(label = {{ label }}), ...) +
    coord_equal() +
    scale_x_continuous(
      limits = c(0.5,
                 max(purrr::pluck(data,
                                  rlang::quo_text(rlang::enquo(x))),
                     na.rm = TRUE) + 0.5),
      expand = expansion(add = c(0.5, 0.5))) +
    scale_y_continuous(
      limits = c(0.5,
                 max(purrr::pluck(data,
                                  rlang::quo_text(rlang::enquo(y))),
                     na.rm = TRUE) + 0.5),
      expand = expansion(add = c(0.5, 0.5)))
}

#' @title Tabularmap theme
#'
#' @description Custom ggplot2 theme for tabulamap.
#' @import ggplot2
#' @param ... all other arguments passed on to [ggplot2::theme_minimal()]
#' @rdname theme_tabularmap
#' @export
theme_tabularmap <- function(...) {
  ggplot2::theme_minimal(...) +
    ggplot2::theme(
        panel.grid = ggplot2::element_blank(),
        axis.ticks = ggplot2::element_blank(),
        axis.text  = ggplot2::element_blank(),
        axis.title = ggplot2::element_blank())
}

#' @title Coloring the tabularmaps by region in Japan
#'
#' @description Custom ggplot2 scale for tabulamap.
#' @import ggplot2
#' @param lang Select whether the region variable is Japanese (`jp`) or English (`en`).
#' @param ... all other arguments passed on to [ggplot2::scale_fill_manual()]
#' @rdname scale_fill_jpregion
#' @export
scale_fill_jpregion <- function(lang, ...) {
  lang <-
    rlang::arg_match(lang,
                     c("jp", "en"))
  cols <-
    c("#FF9999", "#FFDB72", "#CCFF99", "#72FF95", "#99FFFF",
      "#7295FF", "#CC99FF", "#FF72DB")
  if (lang == "jp") {
    cols <-
      stats::setNames(cols,
                      c("\u5317\u6d77\u9053", "\u6771\u5317", "\u95a2\u6771", "\u4e2d\u90e8",
                        "\u95a2\u897f", "\u4e2d\u56fd", "\u56db\u56fd", "\u4e5d\u5dde"))
  } else {
    cols <-
      stats::setNames(cols,
               c("Hokkaido", "Tohoku", "Kanto", "Chubu",
                 "Kansai", "Chugoku", "Shikoku", "Kyushu"))
  }
  ggplot2::scale_fill_manual(
    values = cols,
    ...)
}

