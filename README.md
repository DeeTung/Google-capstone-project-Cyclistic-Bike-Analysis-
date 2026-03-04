# About the Cyclistic Case Study
The **Cyclistic Case Study** is a capstone project from the **Google Data Analytics Professional Certificate** on Coursera. It presents a real-world scenario where data analysts examine how different customer segments use Cyclistic’s bike-sharing services.

Cyclistic is a fictional bike-share company based in Chicago, and the dataset used for this case study is provided by **Motivate International Inc.** under a public license. The goal of this analysis is to uncover usage patterns, compare customer behaviors, and provide data-driven recommendations to convert casual riders into annual members.
  
## Why Choose This Case Study?
This project offers a practical application of data analytics skills in a business context and allows hands-on experience with:

* **Data Cleaning & Preprocessing:** Handling missing values, ensuring data consistency.
* **Exploratory Data Analysis (EDA):** Identifying trends and usage patterns.
* **Data Visualization & Insights:** Creating charts and dashboards to communicate findings.
* **Business Strategy Development:** Making data-driven recommendations to increase memberships.

Additionally, this case study aligns with real-world business decision-making, making it an excellent opportunity to apply analytical skills in a structured way.

## Key Objectives
* Understand customer usage patterns (Casual vs. Annual Members).
* Identify trends in ride duration, peak usage times, and station preferences.
* Recommend strategies to increase annual memberships.

## Key Objectives
* Understand customer usage patterns (Casual vs. Annual Members).
* Identify trends in ride duration, peak usage times, and station preferences.
* Recommend strategies to increase annual memberships.

## Approach
Since this case study is part of the Google Data Analytics Professional Certification Capstone Project, I will follow the data analysis process as outlined by Google:

* Ask
* Prepare
* Process
* Analyze
* Share
* Act

These steps will form the basis for my analysis on the Cyclistic dataset.

## Tools Used

* **Language:** R
* **Libraries:** `here`, `yaml`, `dplyr`, `tidyr`, `tidyverse`, `ggplot2`, `showtext`, `scales`, `tidytext`
* **IDE & Development**: RStudio
* **Version Control**: Git, GitHub
* **Large File Storage**: Google Drive
* **Documentation & Presentation**: Google Docs, Google Slides
* **Visualization:** Custom-styled `ggplot2` plots exported to PNG

# Phase 1: Ask

## Business Task

Analyze Cyclistic's historical trip data to understand the behavioral differences between annual members and casual riders. The goal is to identify high-value conversion opportunities by examining usage patterns related to time, duration, and geographical distribution. These insights will guide the development of a marketing strategy to maximize annual memberships.

## Key Stakeholders

* **Lily Moreno**: Director of Marketing and my manager, responsible for developing campaigns to promote the bike-share program.
* **Cyclistic Marketing Analytics Team**: A team of data analysts responsible for collecting, analyzing, and reporting data to guide marketing strategy.
* **Cyclistic Executive Team**: The detail-oriented team that will decide whether to approve the recommended marketing program.

## Guiding Questions

* **Spatial Patterns**: How do the starting and ending locations differ between members and casual riders? Are casual riders more concentrated in tourist areas or parks compared to members?

* **Travel Efficiency**: Does the average ride distance (ride_distance) correlate with the user type? Do members take more direct, shorter-distance trips (suggesting commuting) while casual riders take longer, wandering routes?

* **Peak Hour Geospatial Trends**: During peak hours (e.g., 5 PM), where is the highest density of casual riders located? Can we target these specific "hotspot" stations for digital conversion ads?

* **Weather & Seasonal Impact on Distance**: How does the average travel distance change across different months for each user group?

* **Conversion Incentives**: Based on the average distance and duration, would a "Long-Distance Weekend Pass" or "Commuter-Only Membership" be more effective in converting the identified casual rider segments?

# Phase 2: Prepare

### Data Source

The data used in this analysis is public data provided by Motivate International Inc. 
You can download the historical trip data from this link (01/2025 - 12/2025): 
[Cyclistic Trip Data](https://divvy-tripdata.s3.amazonaws.com/index.html)

## Data Storage and Organization

### Where is your data located? 

The data is stored locally in organized folders, with subdirectories for the original 12 months of raw CSV files and a separate folder for processed data. 

### How is the data organized? 

The data is organized by month, with each CSV file containing trip details such as ride ID, bike type, start/end times, station names, and member type (casual vs. annual). 

## Data Credibility and Integrity (ROCCC)

### Are there issues with bias or credibility in this data? Does your data ROCCC? 

**Reliable:** The data is reliable as it contains a large volume of actual trip records from a functional bike-share system. 

**Original:** The data is primary-source data provided by Motivate International Inc., which operates the City of Chicago’s Divvy bicycle-sharing service. 

**Comprehensive:** It includes all necessary variables (time, duration, station, user type) to answer how usage differs between members and casual riders. 

**Current:** The analysis uses the most recent 12 months of historical trip data, ensuring the findings reflect current trends. 

**Cited:** The data is officially licensed and made public under a specific data license agreement. 

### How did you verify the data’s integrity? 

Data integrity was verified by checking for consistent column names across all 12 files, ensuring data types matched, and identifying any outliers or null values in critical fields like started_at and ended_at. 

## Licensing, Privacy, and Security

### How are you addressing licensing, privacy, security, and accessibility? 

**Licensing:** The data is used according to the license provided by Motivate International Inc. 

**Privacy:** To ensure rider privacy, all personally identifiable information (PII) such as credit card numbers or home addresses has been excluded from the dataset. 

**Security:** Raw data is kept as read-only to prevent accidental modification, and all cleaning steps are documented for transparency. 

## Analysis Readiness

### How does it help you answer your question? 

The data allows for granular comparison of ride frequency, trip duration, and peak usage times between annual members and casual riders. 

### Are there any problems with the data? 

Common issues include missing station names for some entries and occasional records where the ride length is zero or negative (due to maintenance or system errors), which must be removed during the cleaning phase.

# Phase 3: Process 

## 1. Data Merging and Initial Inspection

**Merging:**  
Merged 12 individual CSV files (covering January 2025 to December 2025) into a single integrated dataframe called `trips` using the `bind_rows()` function.

**Missing Value Analysis:**  
Performed a thorough check for null values using `colSums(is.na(trips))`. Significant missing data was identified in station-related columns (`start_station_name`, `start_station_id`, `end_station_name`, `end_station_id`) and geographical coordinates.

**Integrity Enforcement:**  
Applied `drop_na()` to remove rows with missing values, ensuring the analysis of station popularity and trip distance remains accurate.

---

## 2. Detailed Data Transformation (Breakdown)

To enable deep-dive analysis into user behavior, the following features were engineered using R:

**Time Feature Extraction:**  
Created specific columns for `month`, `year`, `day_of_week`, and `hour` derived from the `started_at` timestamp.

**Ride Metrics Calculation:**

- **ride_length:** Calculated the duration of each trip in minutes by finding the difference between `ended_at` and `started_at`.
- **ride_distance:** Computed the geographical distance (in kilometers) between start and end coordinates using the `distGeo()` function from the `geosphere` library to analyze travel efficiency.

**Categorical Ordering:**  
Organized `day_of_week` (Monday–Sunday) and `month` (Jan–Dec) into ordered factors to ensure logical chronological display in visualizations.

---

## 3. Data Cleaning and Quality Assurance

A final filtered dataset, `trips_v2`, was established to remove noise and system errors:

**Removal of Outliers:**

- Excluded trips with a duration of less than 1 minute, which often represent false starts or docking errors.
- Excluded trips exceeding 24 hours (1,440 minutes), as these likely indicate stolen bikes or system logging failures.

**Renaming for Clarity:**  
Standardized column names, such as renaming column 2 to `bike` and column 13 to `user`, to enhance code readability.

---

## 4. Process Summary

**Tool Used:** RStudio  

**Total Cleaned Records:** 5,552,063 valid trips.  

**Outcome:**  
The dataset is now clean, structurally consistent, and enriched with temporal and geospatial metrics, making it ready for the Analyze phase.
