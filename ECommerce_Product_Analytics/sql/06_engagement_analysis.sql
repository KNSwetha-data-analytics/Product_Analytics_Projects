/* 
======================================================================
USER ENGAGEMENT ANALYSIS - KEY FINDINGS 
======================================================================
1. Event Distribution:
   - views : 193,355 (96.7%) 
   - cart : 2,868 (1.43%)
   - purchases : 3,639 (1.2%) 
   - User activity is highly concentrated in product viewing. Only a small portion 
     of interactions progress to cart additions or purchases. 

2. User-level engagement: 
   - Average events per user : 5.19
   - Average sessions per user : 1.24
   - users perform approximately 5 actions on an average and generally interact through a single session.
     Repeated engagement appears to be limited within the analyzed data. 

3. Session-level engagement:
   - Average events per session : 4.19
   - Most sessions contain only a few interactions. 
   
4. User activity segmentation:
   - Highly active users (>90 events) : 19 users
   - Moderately active users (20-90 events) : 1,447 users
   - Least active users (<20 events) : 36,974 users
   - User activity is highly concentrated among very small group of highly active users, 
     while mjority of users have light interactions. 
     
5. Session-depth analysis:
   - 0-10 events : 43,686 sessions
   - 11-50 events : 3,933 sessions
   - 51-100 events : 73 sessions
   - 100+ events : 5 sessions 
   - Most sessions are short and have limited product exploration while deep engagement sessions are 
     very rare. 
     
6. Business Implication:
   - Product browsing dominates the platform activity.
   - Most users and sessions show low engagement.
   - A small sub-set of users generate more activity
   - There exists business opportunity to increase session depth, encourage repeated visits and improve 
	 progression from product views to purchase events. 
     
*/

USE product_growth_analytics; 

# Event Distribution 
SELECT event_type, 
       COUNT(*) AS num_events 
FROM ecommerce_events_01
GROUP BY event_type
ORDER BY num_events DESC;

# Average events per event_type
SELECT event_type, 
       ROUND(COUNT(*) * 100.0 /
             (SELECT COUNT(*) 
			  FROM ecommerce_events_01), 2) AS num_events 
FROM ecommerce_events_01
GROUP BY event_type
ORDER BY num_events DESC;

# Average Events per user
SELECT COUNT(*) * 1.0 / 
	   COUNT(DISTINCT user_id) AS events_per_user
FROM ecommerce_events_01;

# Average Events for session
SELECT COUNT(*) * 1.0 / 
	   COUNT(DISTINCT user_session) AS events_per_session
FROM ecommerce_events_01;

# Average sessions per user
SELECT COUNT(DISTINCT user_session) * 1.0 / 
	   COUNT(DISTINCT user_id) AS session_per_user 
FROM ecommerce_events_01;

# Most active users
SELECT user_id,
       COUNT(*) AS total_events 
FROM ecommerce_events_01
GROUP BY user_id
ORDER BY total_events DESC
LIMIT 10;

# User active segmentation
WITH sub_table AS(
SELECT user_id,
       COUNT(*) AS total_events 
FROM ecommerce_events_01
GROUP BY user_id
ORDER BY total_events DESC)
SELECT 
	CASE 
		WHEN total_events <= 20 THEN 'least active users'
        WHEN total_events <= 90 THEN 'moderately active users'
        ELSE 'highly active users'
	END AS user_bucket, 
    COUNT(*) AS users
FROM sub_table
GROUP BY user_bucket;

# Most active sessions
SELECT user_session,
       COUNT(*) AS session_events 
FROM ecommerce_events_01
GROUP BY user_session
ORDER BY session_events DESC
LIMIT 10;

# Session-depth distribution
WITH sub_table AS(
SELECT user_session,
       COUNT(*) AS session_events 
FROM ecommerce_events_01
GROUP BY user_session
ORDER BY session_events DESC)
SELECT 
	CASE 
		WHEN session_events <= 10 THEN '0-10'
        WHEN session_events <= 50 THEN '11-50'
        WHEN session_events <= 100 THEN '51-100'
        ELSE '100+'
	END AS session_bucket, 
    COUNT(*) AS sessions
FROM sub_table
GROUP BY session_bucket;