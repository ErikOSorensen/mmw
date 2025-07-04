library(targets)
library(tidyverse)
library(gt)
library(modelsummary)
library(haven)
library(tarchetypes)

list(
  tar_target(
    mmw2014_file,
    "data/mmwinner.dta",
    format = "file"
  ),
  tar_target(
    mmw2014,
    read_dta(mmw2014_file)
  ),
  tar_target(
    mmw2018_file,
    "data/mmwinner_RN2018.dta",
    format = "file"
  ),
  tar_target(
    mmw2018,
    read_dta(mmw2018_file)
  ),
  tar_target(
    mmw2025_file,
    "data/mmwinner_Prolific2025.dta",
    format = "file"
  ),
  tar_target(
    mmw2025,
    read_dta(mmw2025_file)
  ),
  tar_target(
    classified_motivations_file,
    "classification/classified_motivations.csv",
    format="file"
  ),
  tar_target(
    classified_motivations,
    read_csv(classified_motivations_file)
  )
)
