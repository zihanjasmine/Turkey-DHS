#### Preamble ####
# Purpose: Clean the data downloaded from "Turkey: DHS, 1998 - Final Report"
# Author: Zihan Zhang
# Data: 28 March 2022
# Contact: zhanzihan.zhang@mail.utoronto.ca 
# License: MIT




#### Workspace setup ####

# Load all the packages
library(reshape2)
library(stringi)
library(pointblank)

raw_data <- gsub("I", "1", raw_data$all)
raw_data <- gsub(",", ".", raw_data)


raw_data2 <- raw_data %>%
  str_replace("Don't know/Missing","Missing" ) %>%
  str_replace("Currently attending","Currently_attending") %>%
  str_replace("Got pregnant","Got_pregnant") %>%
  str_replace("Got married","Got_married")%>%
  str_replace("Take care of ehiidren","Take_care_of_chilidren") %>%
  str_replace("Take care of children","Take_care_of_children") %>%
  str_replace("Family needed help","Family_needed_help")%>%
  str_replace("Could not pay school fees","Could_not_pay_school_fees") %>%
  str_replace ("Needed to earn money","Needed_to_earn_money") %>%
  str_replace ("Graduated/had enough school","Graduated") %>%
  str_replace ("Did not pass exams","Did_not_pass_exams") %>%
  str_replace ("Did not like school","Did_not_like_school") %>%
  str_replace ("School not accessible","School_not_accessible") %>%
  str_replace ("Parents did not send to school","Parents_did_not_send_to_school")

raw_data2 <- gsub("\\. ", ".", raw_data2)




aa <- colsplit(raw_data2, ' ', names =  c("reason_stopped_attending_school",
                                          "primary_incomplete",
                                          "primary_complete",
                                          "secondary_incomplete",
                                          "secondary_complete",
                                          "higher",
                                          "total"))
aa[16, c("total")] = 1963
aa[33, c("total")] = 1068
aa[50, c("primary_complete", "total")] = c(1563, 3031)


# remove () in higher to make the whole dataset to be numeric
aa_new <- aa
aa_new$higher <- gsub("[()]", "", aa$higher)
write_csv(aa_new,"outputs/data/cleaned_data.csv")



# Read in datset
cleaned_data <- read.csv("outputs/data/cleaned_data.csv")


# Set up tests 

library(pointblank)

agent <-
  create_agent(tbl = cleaned_data) %>%
  # check primary_incomplete,primary_complete,secondary_incomplete ,secondary_complete,higher,total is numeric variable
  col_is_numeric(columns =vars(primary_incomplete,primary_complete,
                               secondary_incomplete ,
                               secondary_complete,
                               higher,
                               total)) %>%
  # check reason_stopped_attending_school is a character
  col_is_character(columns = vars(reason_stopped_attending_school)) %>%
  col_vals_in_set(columns = reason_stopped_attending_school,
                  set = c("Currently_attending",
                          "Got_pregnant",
                          "Got_married",
                          "Take_care_of_chilidren",
                          "Family_needed_help",
                          "Could_not_pay_school_fees",
                          "Needed_to_earn_money",
                          "Graduated",
                          "Did_not_pass_exams",
                          "Did_not_like_school",
                          "School_not_accessible",
                          "Parents_did_not_send_to_school",
                          "Other",
                          "Missing",
                          "Total",
                          "Number"
                          )) %>%
  interrogate()
agent
