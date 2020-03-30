#' @title Create Tile-Grid
#'
#' @description A ggplot2-based tabularmap that places a coordinated dataset in a rectangle.
#' @import ggplot2
#' @import rlang
#' @importFrom dplyr select
#' @param data data.frame. Contain x, y variables used as coordinates.
#' @param fill Fill colour variable.
#' @param label Label variable.
#' @param ... All other arguments passed on to [ggplot2::geom_text()] include label `family`.
#' @examples
#' library(ggplot2)
#' tabularmap(jpn77, label = prefecture, size = 3)
#' tabularmap(jpn77, fill = region, label = prefecture, size = 3)
#' tabularmap(jpn77, fill = region, label = prefecture, size = 3) +
#'   theme_tabularmap() +
#'   scale_fill_jpregion(lang = "en")
#' tabularmap(data.frame(
#'   x = rep(c(1,2,3), each = 3),
#'   y = rep(c(1,2,3), times = 3),
#'   fill = seq.int(9),
#'   label = letters[seq.int(9)]),
#'   fill = fill, label = label)
#' # Global (ISO 3166 code)
#' tabularmap(iso3166, fill = 1, label = iso2c) +
#'   theme_tabularmap() +
#'   guides(fill = FALSE)
#' tabularmap(iso3166, fill = continent, label = iso3c) +
#'   theme_tabularmap()
#' @rdname tabularmap
#' @export
tabularmap <- function(data, fill = 1, label, ...) {
  x <- y <- value <- NULL
  data_adjust <-
    dplyr::select(data,
                  x,
                  y,
                  value = !! rlang::enquo(fill),
                  label = !! rlang::enquo(label))
  p <- ggplot2::ggplot(data_adjust,
                       ggplot2::aes(xmin = x, ymin = y, xmax = x + 1, ymax = y + 1)) +
    ggplot2::geom_rect(ggplot2::aes(fill = value),
                       color = "white") +
    ggplot2::geom_text(ggplot2::aes(x, y, label = !! rlang::quo(label)),
                       nudge_x = 0.5, nudge_y = 0.5,
                       ...) +
    ggplot2::coord_equal() +
    ggplot2::scale_x_continuous(limits = c(1, max(data_adjust$x) + 1),
                       expand = ggplot2::expansion(add = c(0.5, 0.5))) +
    ggplot2::scale_y_continuous(limits = c(1, max(data_adjust$y) + 1),
                       expand = ggplot2::expansion(add = c(0.5, 0.5)))
  suppressWarnings(print(p))
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

