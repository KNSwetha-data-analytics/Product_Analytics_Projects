/* 
======================================================================
CATEGORY & BRAND ANALYSIS - KEY FINDINGS 
======================================================================
1. Category Performance: 
   - Smartphones generated the highest number of views and purchases.
   - Smartphones category contributed the largest share of revenue. 
   
2. Brand Performmance:
   - Apple and Samsung were the dominant revenue-generating brands. 
   - They are ranked among the leading brands in purchase volume.
   
3. Purchase Rate analysis:
   - Although Category - Smartphones and Brands - Apple & Samsung lead in purchases, 
     their purchase_rates remain relatively low.
   - This indicates that only a small fraction of product views are resulting in purchases. 
   
4. Conversion Opportunity: 
   - Smartphone products generate sustantial user interest but most views do not convert to purchases. 
   - Also there is an unknown brand which has higher views than Apple or Samsung but its purchase_rate 
     is lower than the other two brands.
   - There is potential to improve conversion by understanding why users view products but do not 
	 proceed to purchase. 
     
5. Key Observations:
  - Category and Brand performance is driven by traffic volume.
  - Category - Smartphones and Brands - Apple & Samsung dominate user attention and purchase activity, 
	making them most important business segments within the dataset. 
  - However, purchase_rates remain low even in best-performing segments. This represents significant 
	business opportunity for conversion optimization. 
    
*/
USE product_growth_analytics; 

# Category-wise analysis
WITH sub_table AS (
SELECT category_id, 
       category_code, 
       SUM(CASE WHEN event_type = "view" THEN 1 ELSE 0 END) AS views,  
       SUM(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) AS purchases, 
       ROUND((SUM(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) * 100.0 /
			  SUM(CASE WHEN event_type = "view" THEN 1 ELSE 0 END)) , 2) AS purchase_rate
FROM ecommerce_events_01
GROUP BY category_id, 
         category_code ) 
SELECT *
FROM sub_table
ORDER BY purchases DESC;

# Brand-wise analysis
WITH sub_table AS (
SELECT brand, 
       SUM(CASE WHEN event_type = "view" THEN 1 ELSE 0 END) AS views,  
       SUM(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) AS purchases,
       ROUND((SUM(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) * 100.0 /
			  SUM(CASE WHEN event_type = "view" THEN 1 ELSE 0 END)) , 2) AS purchase_rate
FROM ecommerce_events_01
GROUP BY brand ) 
SELECT *
FROM sub_table
ORDER BY purchases DESC;