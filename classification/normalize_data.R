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
#write_csv(training_data,"training_data.csv")


create_examples_for_system <- function(data, max_examples = 10) {
  data <- head(data, max_examples)
  examples <- mapply(function(motivation, classification, idx) {
    paste0(
      "Example ", idx, ":\n",
      "Input: \"", motivation, "\"\n",
      "Category: ", classification, "\n"
    )
  }, data$motivation, data$classification, seq_len(nrow(data)))
  examples_text <- paste(examples, collapse = "\n\n")
  return(examples_text)
}

examples <- create_examples_for_system(training_data, max_examples = 200)
writeLines(examples, "classification_examples.txt")
