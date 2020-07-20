FROM rocker/tidyverse:4.0.2@sha256:ad4ef1a4f0c772acc0f4a27e9f8bb2c1e2efacfe317eddeb49b0783838edaeed

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fonts-ipaexfont \
    qpdf && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  install2.r --error --ncpus -1 --repos 'https://mran.revolutionanalytics.com/snapshot/2020-07-19' \
    countrycode \
    ggplot2 \
    zipangu \
    roxygen2 \
    roxygen2md && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
