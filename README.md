
<!-- README.md is generated from README.Rmd. Please edit that file -->

# tabularmaps

<!-- badges: start -->

<!-- badges: end -->

tabularmapsは、CC0で公開されている[カラム地図プロジェクト](https://github.com/tabularmaps/hq)が進める行政区分等のグリッドレイアウトによる可視化をRパッケージとして提供するものです。

## インストール

インストールはGitHubを経由して行います。まずremotesパッケージをCRANからインストールした後、`remotes::install_github()`で行ってください。

``` r
install.packages("remotes")
remotes::install_github("uribo/tabularmaps")
```

## 使い方

``` r
library(tabularmaps)
```

``` r
library(ggplot2)
tabularmap(jpn77, 
           fill = region_kanji, 
           label = prefecture_kanji, 
           size = 3,
           family = "IPAexGothic") +
  theme_tabularmap(base_family = "IPAexGothic") +
  scale_fill_jpregion(lang = "jp",
                      name = "八地方区分")
```

![](man/figures/README-demo_jpn77-2.png)

## Related works

  - [geofacet](https://github.com/hafen/geofacet)
  - [ggpol](https://github.com/erocoar/ggpol)
  - [waffle](https://github.com/hrbrmstr/waffle)
