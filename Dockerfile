# Use specific version of rocker/tidyverse for stability
FROM rocker/tidyverse:4.5.1 AS base

# Install system libraries needed for many R packages
RUN apt-get update && apt-get install -y \
    libcurl4-openssl-dev \
    libssl-dev \
    libxml2-dev \
    libgit2-dev \
    libpng-dev \
    libglpk-dev \
    && apt-get clean

# Set working directory inside container
WORKDIR /home/rstudio/project

# Install renv globally and restore packages (cached layer)
RUN R -e "install.packages('renv')"
COPY renv.lock ./renv.lock
COPY renv/activate.R ./renv/activate.R
RUN R -e "renv::restore(confirm = FALSE)"

# =============================================================================
# Interactive RStudio target
# =============================================================================
FROM base AS rstudio

# RStudio uses /init to start the server
CMD ["/init"]

# =============================================================================
# Pipeline runner target
# =============================================================================
FROM base AS runner

# Copy all project files for reproducible execution
COPY _targets.R ./
COPY code/ ./code/
COPY data/ ./data/
COPY classification/ ./classification/

# Create output directories
RUN mkdir -p html_reports graphs tables

# Run the targets pipeline
CMD ["R", "-e", "targets::tar_make()"]
