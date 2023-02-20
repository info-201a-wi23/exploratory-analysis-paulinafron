#load-packages
library(tidyverse)
library(broom)
library(stringr)
library(dplyr)
library(knitr)

#Load csv
pet <- read.csv("Seattle_Pet_Licenses.csv")
zipcode <- read.csv("usa_zipcode_of_wa-1564j.csv")

zipcode <- zipcode %>% filter(!is.na(`Zipcode.name`) & City == 'SEATTLE')
zipcode$'ZIP.Code' <- as.numeric(as.character(zipcode$'ZIP.Code'))
joined_df <- left_join(pet, zipcode, by = "ZIP.Code")

# create the aggregate table
agg_table <- joined_df %>%
  select('License.Issue.Date', Species, 'Primary.Breed', 'Secondary.Breed', 'ZIP.Code', 'Zipcode.name', 'County.Name') %>%
  group_by('ZIP.Code')

# display the first five tuples
summarized_table <- head(agg_table, 5)
summarized_table <- summarized_table[ , 1:(ncol(summarized_table)-1)]
