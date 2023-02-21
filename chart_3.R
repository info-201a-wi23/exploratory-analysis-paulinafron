#load-packages
library(knitr)
library(tidyverse)
library(openintro)
library(GGally)
library(ggridges)
library(janitor)
library(tidymodels)
library(infer)
library(broom)
library(stringr)
library(dplyr)

#Load csv
pet <- read.csv("Seattle_Pet_Licenses.csv")
zipcode <- read.csv("usa_zipcode_of_wa-1564j.csv")

#Proceed csv
zipcode$ZIP.Code <- as.numeric(as.character(zipcode$ZIP.Code))
pet <- left_join(pet, zipcode, by = "ZIP.Code")

#Proceed Data
pet_year1 <- pet %>% 
  select(License.Issue.Date, Species) %>%
  filter(str_detect(License.Issue.Date, "2015|2016|2017|2018|2019|2020"))
pet_year1 <- pet_year1 %>%
  mutate(License.Issue.Date = "2015-2020")
pet_year2 <- pet %>% 
  select(License.Issue.Date, Species) %>%
  filter(str_detect(License.Issue.Date, "2021"))
pet_year2 <- pet_year2 %>%
  mutate(License.Issue.Date = "2021")
pet_year3 <- pet %>% 
  select(License.Issue.Date, Species) %>%
  filter(str_detect(License.Issue.Date, "2022"))
pet_year3 <- pet_year3 %>%
  mutate(License.Issue.Date = "2022")
pet_year4 <- pet %>% 
  select(License.Issue.Date, Species) %>%
  filter(str_detect(License.Issue.Date, "2023"))
pet_year4 <- pet_year4 %>%
  mutate(License.Issue.Date = "2023")

pet_species <- rbind(pet_year1 , pet_year2, pet_year3, pet_year4)

pet_dog <- pet %>% 
  select(County.Name, Species) %>%
  filter(str_detect(Species, "Dog"))

pet_cat <- pet %>% 
  select(County.Name, Species) %>%
  filter(str_detect(Species, "Cat"))

pet_special <- pet %>% 
  select(County.Name, Species) %>%
  filter(str_detect(Species, "Goat|Pig"))

#chart3_plot1.R, What about relationship between species and licence issue date?
p1 <- ggplot(data=pet_species, 
       mapping=aes(x = Species, fill=License.Issue.Date)) + 
  geom_bar(position="fill")  + ggtitle("Plot of species that lisence issued for different years")

#chart3_plot2.R, Why combine 2015-2020?"
slices <- c(nrow(pet_year1), nrow(pet_year2), nrow(pet_year3), nrow(pet_year4))
lbls <- c("2015-2020", "2021", "2022", "2023")
p2 <- pie(slices, labels = lbls, main="Pie chart of Lisences", radius = 1, col = rainbow(4))

#chart3_plot3.R, What about the counties?
p3 <- ggplot(data=pet, 
       mapping=aes(x = County.Name, fill=Species)) + 
  geom_bar(position="fill")  + ggtitle("Plot of species that lisence issued for counties")
