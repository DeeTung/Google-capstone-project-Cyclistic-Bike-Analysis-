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

The primary objective is to analyze Cyclistic's historical trip data to identify how annual members and casual riders use the bike-share service differently. These insights will serve as the foundation for designing a targeted marketing strategy aimed at converting casual riders into annual members to ensure the company's future growth and profitability.

## Key Stakeholders

* **Lily Moreno**: Director of Marketing and my manager, responsible for developing campaigns to promote the bike-share program.
* **Cyclistic Marketing Analytics Team**: A team of data analysts responsible for collecting, analyzing, and reporting data to guide marketing strategy.
* **Cyclistic Executive Team**: The detail-oriented team that will decide whether to approve the recommended marketing program.

## Guiding Questions

* **Metrics**: Which specific metrics (e.g., average ride_length, frequency by day_of_week, or peak usage hours) will most effectively highlight the behavioral gaps between the two user types?
* How do annual members and casual riders use Cyclistic bikes differently?  
* Why would casual riders buy Cyclistic annual memberships?  
* How can Cyclistic use digital media to influence casual riders to become members?  

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

# Phase 3: Process - Data Cleaning & Transformation Documentation

## Data Transformation Steps

To prepare the data for analysis, the following transformations were performed using R:

### Data Merging:

Merged 12 individual CSV files covering the period from January 2025 to December 2025 into a single integrated dataframe called all_trips.

### New Features:

* Created a ride_length column by calculating the difference between ended_at and started_at. The result was formatted as numeric (seconds) for precise statistical calculations.

* Created a day_of_week column using the wday() function, where 1 represents Sunday and 7 represents Saturday.

### Data Type Conversion:

Ensured that started_at and ended_at columns were converted to datetime format (POSIXct) to enable chronological analysis.

## Data Cleaning Records

A cleaned dataset named all_trips_v2 was created to ensure the integrity of the findings:

### Filtering Records:

Removed all entries where ride_length was less than or equal to 0 seconds (representing system errors or maintenance trips).

### Handling Missing Values:

Verified and addressed null values in critical geographical and station-related fields.

## Cleaned Dataset Overview:

### Total Records: 5,552,063 valid trips.

### Ride Length Statistics:

* Minimum: 0.046 seconds.

* Maximum: 944,494 seconds (approximately 262 hours).

* Mean: 965.8 seconds (approximately 16 minutes).

### Temporal Range:
The primary analysis focuses on trips starting from January 31, 2025, through the end of December 2025.

### Integrity Check:

Confirmed that the member_casual column contains only "member" and "casual" categories and that day_of_week values fall strictly within the 1-7 range.
