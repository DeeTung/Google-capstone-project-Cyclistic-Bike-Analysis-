# 1. Load necessary libraries
library(tidyverse)
library(lubridate)

# 2. Set the working directory to the folder containing 12 csv files
setwd("C:/Data Analysis/dataset")

# 3. Read and merge all .csv files into a single integrated dataframe
all_trips <- list.files(pattern = "*.csv") %>% 
  map_df(~read_csv(.))

# 4. Add ride_length column (calculated in seconds) and day_of_week column
all_trips <- all_trips %>% 
  mutate(ride_length = difftime(ended_at, started_at)) %>% 
  mutate(day_of_week = wday(started_at, label = FALSE))

# 5. Remove bad data (negative trip durations or system maintenance)
all_trips_v2 <- all_trips %>% 
  filter(ride_length > 0)

# 6. Check the final cleaned data summary
summary(all_trips_v2)