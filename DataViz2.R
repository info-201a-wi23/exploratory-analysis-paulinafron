# Data Viz 2: Change in number of pet licenses during time
# Veronica Fula

pet_data <- read.csv("Seattle_Pet_Licenses.csv")

library("dplyr")
library("ggplot2")
library("stringr")
library("scales")

pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "January", "01")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "February", "02")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "March", "03")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "April", "04")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "May", "05")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "June", "06")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "July", "07")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "August", "08")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "September", "09")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "October", "10")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "November", "11")
pet_data$License.Issue.Date <- str_replace_all(pet_data$License.Issue.Date, "December", "12")
pet_data$License.Issue.Date <- as.Date(pet_data$License.Issue.Date, "%m %d %Y")

dates_grouped <- pet_data %>% group_by(License.Issue.Date) %>% summarise(Number.of.Licenses.Issued = n())

ggplot(data = dates_grouped, aes(x = License.Issue.Date, y = Number.of.Licenses.Issued)) +
  geom_point(aes(color = "red")) +
  geom_smooth(method = "loess") +
  theme(legend.position="none")
