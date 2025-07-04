library(tidyverse)

classifications_defs <- read_csv("classifications_defs.csv")
B1 <- read_csv2("B1.csv") |> dplyr::select(c("id","classification_code"))
B2 <- read_csv2("B2.csv") |> dplyr::select(c("id","classification_code"))
motivations <- read_csv("motivations.csv")

training_data <- list(B1,B2) |> 
  bind_rows() |> 
  left_join(classifications_defs) |>
  left_join(motivations) |> 
  dplyr::select(c("id","classification","motivation"))
write_csv(training_data,"training_data.csv")


