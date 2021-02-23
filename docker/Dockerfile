FROM rocker/rstudio:4.0.3

LABEL maintainer="Nikhil Agarwal <r@niks.me>"

RUN apt-get update && apt-get install -y --no-install-recommends \
        libgit2-dev \
        libxml2-dev \
        libudunits2-dev \
        libgdal-dev \
        libcairo2-dev \
        libxt-dev \
        libv8-dev \
        libpoppler-cpp-dev \
        libtesseract-dev \
        libleptonica-dev \
        tesseract-ocr-eng \
        libmagick++-dev \
        libavfilter-dev \
        libzmq3-dev \
    	mesa-common-dev \
    	libglu1-mesa-dev \
        cargo \
        curl \
        tree \
        jq \
        htop \
        texinfo \
        nano \
        man-db \
        less 

# Install basic utility R packages
RUN install2.r -r https://packagemanager.rstudio.com/all/1517087 \
	--error \
	dplyr \
	ggplot2 \
	readr \
	tidyr \
	purrr \
	tibble \
	stringr \
	forcats \
	lubridate \
	hms \
	glue \
	furrr 

RUN install2.r -r https://packagemanager.rstudio.com/all/1517087 \
	--error \
	devtools \
	usethis \
	testthat

RUN install2.r -r https://packagemanager.rstudio.com/all/1517087 \
        --error \
        reprex \
        httr \
        curl \
        janitor \
        bookdown \
        blogdown \
        pagedown \
        tidyjson

# Install additional plotting packages
RUN install2.r -r https://packagemanager.rstudio.com/all/1517087 \
        --error \
        ggrepel \
        ggthemes \
        gridExtra \
        ggExtra

# Copy over my RStudio Preferences
COPY rstudio-prefs.json /etc/rstudio/

# Install hugo
WORKDIR /home/rstudio/bin/
RUN R -e "options(blogdown.hugo.dir = '/home/rstudio/bin'); blogdown::install_hugo(version = '0.70.0')"

# expose ports
EXPOSE 4321
EXPOSE 4870