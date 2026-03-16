library(tidyverse)
library(ggplot2)
library(scales) # To format labels (percent, comma)
# Calculate percentage for labels
user_dist <- trips_v2 %>% 
  group_by(member_casual) %>% 
  summarise(count = n()) %>% 
  mutate(perc = count/sum(count))

# Create a pie chart to visualize the overall percentage distribution of Members vs Casual riders
ggplot(user_dist, aes(x = "", y = perc, fill = member_casual)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) + 
  geom_text(aes(label = percent(perc)), position = position_stack(vjust = 0.5)) +
  labs(title = "Customer Segment Distribution") +
  theme_void()

# Create faceted bar charts to compare monthly ride trends and identify seasonal patterns for each user group
ggplot(trips_v2, aes(x = month, fill = member_casual)) +
  geom_bar() +
  facet_wrap(~member_casual) + 
  theme(axis.text.x = element_text(angle = 45)) + 
  labs(title = "Monthly Trends: Member vs Casual")

# Create a bar chart to compare the average ride duration between Members and Casual riders using statistical summary
ggplot(trips_v2, aes(x = member_casual, y = ride_length, fill = member_casual)) +
  stat_summary(fun = mean, geom = "bar") + 
  labs(title = "Average Ride Duration by User Type", y = "Duration (Minutes)") +
  theme_minimal()

# Create a grouped bar chart to compare the total number of rides per day between Members and Casual riders
ggplot(trips_v2, aes(x = day_of_week, fill = member_casual)) +
  geom_bar(position = "dodge") + 
  scale_y_continuous(labels = comma) + 
  labs(title = "Total Rides by Day of Week", x = "Day of Week", y = "Number of Rides") +
  theme_light()

# Create a line chart to visualize the hourly ride frequency and identify peak usage times for each user group
ggplot(trips_v2, aes(x = hour, color = member_casual, group = member_casual)) +
  geom_line(stat = "count", size = 1.2) + # Create line chart based on frequency
  labs(title = "Rides Trend Throughout the Day", x = "Hour (24h format)", y = "Total Rides") +
  theme_classic()