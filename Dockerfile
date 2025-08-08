FROM rocker/tidyverse:4.5.1

# Install required system libraries (optional, depending on your packages)
RUN apt-get update && apt-get install -y libcurl4-openssl-dev libssl-dev libxml2-dev

# Set working directory inside container
WORKDIR /home/rstudio/project

# Install renv
RUN R -e "install.packages('renv')"

# Copy your project files into the image
COPY . /home/rstudio/project

# Restore R package environment
RUN R -e "renv::restore(confirm = FALSE)"

# Set R as the default command (for debugging)
CMD ["R"]
