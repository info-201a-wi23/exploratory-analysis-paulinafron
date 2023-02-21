# Load libraries 
library(zipcodeR)
library(maps)
library(mapproj)
library(dplyr)
library(ggplot2)
library(viridis)
library(hrbrthemes)
library(knitr)
library(gridExtra)
library(stringr)


# Load files
pet_licenses <- read.csv("Seattle_Pet_Licenses.csv")

# Mutate zip codes to have leading zeros
pet_licenses <- pet_licenses %>% mutate(ZIP.Code = str_pad(ZIP.Code, 5, side = "left", "0"))

# Calculate number of licenses per zip code
pet_licenses_count <- pet_licenses %>% group_by(ZIP.Code) %>% summarise(count = n_distinct(License.Number))

# Get data for Washington State
WA <- search_state('WA')

# Create a dataframe of zip codes. Be sure to have leading zeros.
zip <- pet_licenses %>% select(ZIP.Code) 

# Filter the shape file to the zip codes to be drawn. 
uspoly <- subset(WA, zipcode %in% zip$ZIP.Code)

# Join pet_licenses_count and zip codes data
joined <- left_join(pet_licenses_count, uspoly, by = c("ZIP.Code" = "zipcode"))

# Only include rows with data for long and lat
joined <- joined %>% filter(!is.na(lat))

# Shapefile data for Washington State
state_shape <- map_data("state", region = "washington")


# Plot the count of pet licenses
  Chart_1 <- ggplot(data = state_shape) + 
  geom_polygon(aes(x = long,
                   y = lat,
                   group = group)) +
  geom_point(data = joined, aes(x = lng,
                                y = lat,
                                size = count, color = county), alpha = 0.3) +
  scale_size(range = c(.5, 5)) +
  scale_fill_viridis(discrete=TRUE, option="A") +
  ggtitle("Number of pet licenses") +
  theme_ipsum() +
  theme(legend.position="none") +
    guides(count=FALSE) +
  ylab("Latitude") +
  xlab("Longitude") +
  coord_map()

# Plot median household income
Chart_2 <- ggplot(data = state_shape) + 
  geom_polygon(aes(x = long,
                   y = lat,
                   group = group)) +
  geom_point(data = joined, aes(x = lng,
                                y = lat,
                                size = median_household_income, color = county), alpha = 0.3) +
  scale_size(range = c(.1, 5)) +
  scale_fill_viridis(discrete=TRUE, option="A") +
  ggtitle("Median household income") +
  theme_ipsum() +
  theme(legend.position="none") +
  guides(count=FALSE) +
  ylab("Latitude") +
  xlab("Longitude") +
  coord_map()

