/* 
======================================================================
GROWTH METRICS ANALYSIS - KEY FINDINGS 
======================================================================
1. Dataset overview:
   - Total records : 199862
   - Total unique users : 38440
   - Total sessions : 47697 

2. User Engagement:
   - Events per user : 5.19932
   - Sessions per user : 1.24082
   
3. Key Observation: 
   - On an average users are making 5 events.
   - Every user is interacting within a single session. Only a few return for another.
   
4. Dataset Limitation:
   - The data used for analysis is a subset of a larger dataset. Currently ~200K records of the larger dataset is considered.
   - This subset represents data of a short time frame of the day 2019-10-01.
   - Therefore, comprehensive DAU trends, WAU,MAU , retention and cohort analysis are not applicable for this dataset.
   
5. Business Implication:
   - User engagement as per the session frequency seems modest.
   - For Long-term trends analysis, multi-day data is required.
   
*/

USE product_growth_analytics; 

SHOW TABLES;

## Basic Data Validation 

# Total rows
SELECT COUNT(*) AS total_rows
FROM ecommerce_events_01;

# Unique users
SELECT COUNT(DISTINCT user_id) AS total_users
FROM ecommerce_events_01;

# Total sessions 
SELECT COUNT(DISTINCT user_session) AS total_sessions
FROM ecommerce_events_01;

# Events per user
SELECT COUNT(*) * 1.0 /
	   COUNT(DISTINCT user_id) AS events_per_user
FROM  ecommerce_events_01;

# Session per user
SELECT COUNT(DISTINCT user_session) * 1.0 /
	   COUNT(DISTINCT user_id) AS sessions_per_user
FROM  ecommerce_events_01;

# DAU
SELECT DATE(event_time) AS event_date, 
       COUNT(DISTINCT user_id) AS dau 
FROM  ecommerce_events_01
GROUP BY DATE(event_time)
ORDER BY event_date;

SELECT MIN(event_time) , 
       MAX(event_time) 
FROM ecommerce_events_01;
