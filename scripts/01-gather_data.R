#### Preamble ####
# Purpose: Import the data downloaded from DHS program
# Author: Zihan Zhang
# Contact: zhanzihan.zhang@mail.utoronto.ca
# License: MIT


#### Workspace setup ####


# Load all the packages

library(tidyverse)
library(janitor)
library(pdftools)
library(purrr)
library(stringi)

# Read in the data 

allcontent <-pdf_text("inputs/data/FR108.pdf")



# Read in table at page 46
page46 <- stri_split_lines(allcontent[[46]])[[1]]
# remove empty lines
page46 <- page46[page46 !=""]
page46


# Remove headers and footnotes
no_header <- page46[9:58]
no_header

# Create a dataframe
raw_data <- tibble(all = no_header)




raw_data <-raw_data %>%
  mutate(all = str_squish(all)) %>%
  mutate(all = str_replace(all,"~","")) %>%
  mutate(all = str_replace(all,"I","1"))





# Export raw data
write_csv(raw_data,"outputs/data/raw_data.csv")
