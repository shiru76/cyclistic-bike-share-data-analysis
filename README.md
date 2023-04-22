# Cyclistic Bike-Share Data Analysis
This is the data analysis case study of Cyclistic Bike-Share dataset from the Google Data Analytics Professional Certificate.

## Scenario
The director
of marketing believes the company’s future success depends on maximizing the number of annual memberships. Therefore,
your team wants to understand how casual riders and annual members use Cyclistic bikes differently. From these insights,
your team will design a new marketing strategy to convert casual riders into annual members.

## ❓ Business Task
To provide compelling data insights and professional data visualizations to the marketing director, and the executive team that will help design a new marketing strategy to convert casual riders into annual members.

Additionally, these are the three questions that will guide the future marketing program:

1. How do annual members and casual riders use Cyclistic bikes differently?
2. Why would casual riders buy Cyclistic annual memberships?
3. How can Cyclistic use digital media to influence casual riders to become members

## 📝 Data Preparation
In this case study, I used the Cyclistic dataset from April 2022 to March 2023 that can be found [here](https://divvy-tripdata.s3.amazonaws.com/index.html). The data is stored in 12 CSV files separated by different months.

The data has been made available by
Motivate International Inc. under this [license](https://www.divvybikes.com/data-license-agreement).

Upon checking the dataset, there are NULL values in "start_station_name", "start_station_id", "end_station_name", and "end_station_id" columns.
 
Realistically, this issue should be inquired to the company to check if they could provide the correct values before proceding with the analysis.
However, since I have limited access to their dataset, I deleted all the rows with NULL values.

## 🔎 Data Process and Analysis
I chose MS SQL to do the data cleaning and analysis for this case study. All the sql codes can be found in this repository.

First, I combined all the tables into one table called "cyclistic_tripdata". Then, I dropped the columns that were not necessary for the analysis. I also removed the rows with NULL values as mentioned in the previous section. Lastly, I checked for any duplicated rows in the database. There were no rows with duplicated data.

After cleaning the data, I queried the data to answer the following questions:
1. How many cyclists have membership?
2. How many cyclists per month per rider category?
3. What is the average ride length per month per cyclist category?
4. How many cyclists per day per rider category?
5. What is the average ride length per day per cyclist category?
6. How many cyclists per bike category?
7. What are the top 10 stations with the highest number of casual cyclists? 

## 📊 Presentation
I created the data visualization using Tableau. The dashboard can be found [here](https://public.tableau.com/app/profile/iron.lao/viz/CyclisticBike-ShareDashboard_16821753709830/CyclisticBike-ShareDashboard?publish=yes).

## 💡 Recommendation

