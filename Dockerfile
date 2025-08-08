# Use specific version of rocker/tidyverse for stability
FROM rocker/tidyverse:4.5.1

# Install system libraries needed for many R packages (adjust as needed)
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

# Install renv globally (restoration happens later)
RUN R -e "install.packages('renv')"
COPY renv.lock ./renv.lock
COPY renv/activate.R ./renv/activate.R
RUN R -e "renv::restore(confirm = FALSE)"


# Copy only renv-related files first (to leverage Docker layer caching)
# COPY renv.lock renv/activate.R ./renv.lock ./renv/activate.R
# COPY renv.lock  ./renv.lock 
# Restore package environment from renv.lock
# RUN R -e "renv::restore(confirm = FALSE)"

# Now copy the rest of your project files
# COPY . .

# Set default command to start R (useful for CLI script runs)
CMD ["/init"]
