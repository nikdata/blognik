FROM rocker/tidyverse:4.0.2

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
RUN install2.r -r https://packagemanager.rstudio.com/all/__linux__/focal/latest \
        --error \
        reprex \
        httr \
        curl \
        janitor \
        bookdown \
        blogdown \
        data.table \
        vroom \
        tidyjson

# Install tidymodel packages
RUN install2.r -r https://packagemanager.rstudio.com/all/__linux__/focal/latest \
        --error \
        infer \
        recipes \
        rsample \
        yardstick \
        parsnip \
        dials \
        embed

# Install text analytics packages
RUN install2.r -r https://packagemanager.rstudio.com/all/__linux__/focal/latest \
        --error \
        tidytext \
        SentimentAnalysis \
        wordcloud2

# Install key analysis packages
RUN install2.r -r https://packagemanager.rstudio.com/all/__linux__/focal/latest \
        --error \
        randomForest \
        rpart \
        ranger \
        kernlab \
        e1071 \
        glmnet

# Install additional plotting packages
RUN install2.r -r https://packagemanager.rstudio.com/all/__linux__/focal/latest \
        --error \
        ggrepel \
        ggthemes \
        gridExtra \
        ggExtra

# Install shiny packages
RUN install2.r -r https://packagemanager.rstudio.com/all/__linux__/focal/latest \
        --error \
        shinyWidgets \
        htmlwidgets \
        kableExtra


# Install hugo
WORKDIR /home/rstudio/bin/
RUN R -e "options(blogdown.hugo.dir = '/home/rstudio/bin'); blogdown::install_hugo(version = '0.70.0')"

