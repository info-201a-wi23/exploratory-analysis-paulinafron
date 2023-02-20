# load libraries
library(dplyr)
library(knitr)

pet <- read.csv("Seattle_Pet_Licenses.csv")
zipcode <- read.csv("usa_zipcode_of_wa-1564j.csv")

zipcode <- zipcode %>% filter(!is.na(`Zipcode.name`) & City == 'SEATTLE')
zipcode$'ZIP.Code' <- as.numeric(as.character(zipcode$'ZIP.Code'))

pet_summary <- list(
  nrow = nrow(pet),
  n_distinct_species = n_distinct(pet$Species),
  n_distinct_p_breeds = n_distinct(pet$'Primary.Breed'),
  max_license_issue_date = max(pet$'License.Issue.Date'),
  min_license_issue_date = min(pet$'License.Issue.Date')
)

# calculate summary statistics for the zipcode dataframe
zipcode_summary <- list(
  nrow = nrow(zipcode),
  n_distinct_cities = n_distinct(zipcode$City),
  n_zipcodes = n_distinct(zipcode$'ZIP.Code'),
  max_zip_code = max(zipcode$'ZIP.Code'),
  min_zip_code = min(zipcode$'ZIP.Code')
)

# print the summary statistics
cat("Pet Summary:\n")
cat(paste0(names(pet_summary), ": ", unlist(pet_summary), "\n"), sep = "")
cat("\nZipcode Summary:\n")
cat(paste0(names(zipcode_summary), ": ", unlist(zipcode_summary), "\n"), sep = "")
