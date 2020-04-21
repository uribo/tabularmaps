FROM rocker/geospatial:3.6.3

RUN set -x && \
  apt-get update && \
  apt-get install -y --no-install-recommends \
    fonts-ipaexfont && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

ARG GITHUB_PAT

RUN set -x && \
  echo "GITHUB_PAT=$GITHUB_PAT" >> /usr/local/lib/R/etc/Renviron

RUN set -x && \
  install2.r --error --repos 'http://mran.revolutionanalytics.com/snapshot/2020-04-20' \
    countrycode \
    ggplot2 \
    zipangu \
    roxygen2 \
    roxygen2md && \
  rm -rf /tmp/downloaded_packages/ /tmp/*.rds
