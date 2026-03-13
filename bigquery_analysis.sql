-- Calculate total rides and percentage for each user type
-- This helps quantify the scale of both segments
SELECT 
    member_casual, 
    COUNT(*) AS total_rides,
    ROUND(COUNT(*) / SUM(COUNT(*)) OVER() * 100, 2) AS percentage_of_total
FROM capstone_project.cyclistic_trips_data
GROUP BY member_casual;

-- Compare average, maximum, and minimum ride duration (in minutes)
-- Typically, Casual riders have longer average durations than Members
SELECT 
    member_casual, 
    ROUND(AVG(ride_length), 2) AS avg_ride_duration,
    MAX(ride_length) AS max_ride_duration,
    MIN(ride_length) AS min_ride_duration
FROM capstone_project.cyclistic_trips_data
GROUP BY member_casual;

-- Identify the busiest days of the week for each user group
-- Helps verify if Members use bikes for commuting (weekdays) vs Casuals for leisure (weekends)
SELECT 
    member_casual, 
    day_of_week, 
    COUNT(*) AS number_of_rides
FROM capstone_project.cyclistic_trips_data
GROUP BY member_casual, day_of_week
ORDER BY member_casual, day_of_week;

-- Analyze ride frequency by hour of the day
-- Look for spikes at 8 AM and 5 PM for Members (commuters)
SELECT 
    member_casual, 
    hour, 
    COUNT(*) AS total_rides
FROM capstone_project.cyclistic_trips_data
GROUP BY member_casual, hour
ORDER BY hour, member_casual;

-- Find the top 10 most popular start stations for Casual riders
-- Targeted locations for marketing campaigns to convert users to annual members
SELECT 
    start_station_name, 
    COUNT(*) AS casual_ride_count
FROM capstone_project.cyclistic_trips_data
WHERE member_casual = 'casual'
GROUP BY start_station_name
ORDER BY casual_ride_count DESC
LIMIT 10;

-- Compare average travel distance between user types
-- Helps understand if one group travels further or stays within specific zones
SELECT 
    member_casual, 
    ROUND(AVG(ride_distance), 2) AS avg_travel_distance_km
FROM capstone_project.cyclistic_trips_data
GROUP BY member_casual;