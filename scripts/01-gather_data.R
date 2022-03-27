#### Preamble ####
# Purpose: Clean the survey data downloaded from [...UPDATE ME!!!!!]
# Author: 
# Data: 
# Contact: 
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


raw_data <- tibble(all = no_header)



raw_data <-raw_data %>%
  mutate(all = str_squish(all)) %>%
  mutate(all = str_replace(all,"~","")) %>%
  mutate(all = str_replace(all,",",".")) %>%
  mutate(all = str_replace(all,"Don't know/Missing","Missing" )) %>%
  mutate(all= str_replace(all,"Currently attending","Currently_attending")) %>%
  mutate(all= str_replace(all,"Got pregnant","Got_pregnant")) %>%
  mutate(all= str_replace(all,"Got married","Got_married") )%>%
  mutate(all= str_replace(all,"Take care of ehiidren ","Take_care_of_chilidren")) %>%
  mutate(all = str_replace(all,"Take care of children","Take_care_of_children")) %>%
  mutate(all=str_replace(all,"Family needed help","Family_needed_help")) %>%
  mutate(all=str_replace(all,"Could not pay school fees","Could_not_pay_school_fees")) %>%
  mutate(all=str_replace (all,"Needed to earn money","Needed_to_earn_money") )%>%
  mutate(all=str_replace (all, "Graduated/had enough school","Graduated")) %>%
  mutate(all=str_replace (all, "Did not pass exams ","Did_not_pass_exams")) %>%
  mutate(all=str_replace (all,"Did not like school ","Did_not_like_school ")) %>%
  mutate(all=str_replace (all,"School not accessible","School_not_accessible")) %>%
  mutate(all=str_replace (all,"Parents did not send to school","Parents_did_not_send_to_school"))%>%
  separate(col = all,
           into = c("reason_stopped_attending_school",
                    "primary_incomplete",
                    "primary_complete",
                    "secondary_incomplete",
                    "secondary_complete",
                    "higher",
                    "total"),
           sep = " ",
           remove = TRUE,
           fill = "right",
           extra = "drop")



write_csv(raw_data,"outputs/data/raw_data.csv")
