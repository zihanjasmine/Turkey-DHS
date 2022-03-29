# We simulate some tidy data that mimics the raw data we have here.

#### Preamble ####
# Purpose: Obtain and prepare data about reason for leaving school for women 
# aged 15-24 in 1998 in Turkey.
# Author: Yuxuan Yang
# Email: yuxuanmaggie.yang@mail.utoronto.ca
# Date:29 March 2022
# Prerequisites: - 

#### Workspace set-up ####
library(janitor)
library(lubridate)
library(tidyverse)

#### Simulate data ####
set.seed(446)

simulated_data <-
  tibble(
    area = c(
      rep('urban', 14),
      rep('rural', 14),
      rep('urban', 14),
      rep('rural', 14),
      rep('urban', 14),
      rep('rural', 14),
      rep('urban', 14),
      rep('rural', 14),
      rep('urban', 14),
      rep('rural', 14)
    ),
    edu_level = 
      c(
        rep('primary_incomplete', 28),
        rep('primary_complete', 28),
        rep('secondary_incomplete', 28),
        rep('secondary_complete', 28),
        rep('higher', 28)
      ),
    reason_leave = 
      rep(c('currently_attending', 'got_pregnant', 'got_married', 
            'take_care_children', 'family_need_help', 'cant_afford_school',
            'earn_money', 'had_enough_school', 'not_pass_exams', 
            'dislike_school', 'school_unaccessible', 'parent_not_send',
            'other', 'missing'), 10),
    percentage =
      runif(n = 140,
            min = 0, 
            max = 100)
  )

# Note: there are 4 variables: area (urban or rural), highest education level, 
# reason leaving school, and percentage. Because we have 2 areas, 5 possible
# education levels, and 14 reasons to leave school, we generated 2*5*14 = 140
# observations in total. Each observation has a percentage representing the 
# percent of women aged 15-24 in Turkey, 1998, who left school for different 
# reason in different areas, at different education levels. 



