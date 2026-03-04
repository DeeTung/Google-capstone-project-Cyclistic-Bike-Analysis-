# 1. Load necessary libraries
library(tidyverse)
library(lubridate)
library(geosphere) # Library for calculating geographic distance

# 2. Setup & Merge
setwd("C:/Data Analysis/dataset")
# Read and combine all .csv files in the directory into a single dataframe
trips <- list.files(pattern = "*.csv") %>% 
  map_df(~read_csv(.))

# 3. Check & Handle Missing Values
colSums(is.na(trips)) # View missing value statistics
trips <- trips %>% drop_na() # Remove rows containing missing values

# 4. Data Transformation (Breakdown)
trips$month <- format(as.Date(trips$started_at), "%b")
trips$year <- format(as.Date(trips$started_at), "%Y")
trips$day_of_week <- format(as.Date(trips$started_at), "%A")

# Calculate ride_length (in minutes) and ride_distance (in km)
trips <- trips %>%
  mutate(hour = strftime(started_at, "%H"),
         ride_length = as.numeric(difftime(ended_at, started_at, units = "mins")),
         ride_distance = distGeo(matrix(c(start_lng, start_lat), ncol = 2),
                                 matrix(c(end_lng, end_lat), ncol = 2)) / 1000)

# 5. Ordering Categorical Variables
trips$day_of_week <- ordered(trips$day_of_week, 
                             levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"))

# 6. Final Clean: Remove trips shorter than 1 minute or longer than 24 hours
trips_v2 <- trips %>% 
  filter(ride_length >= 1 & ride_length <= 1440)

# Save cleaned results for analysis
summary(trips_v2)
