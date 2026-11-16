/* 
======================================================================
FUNNEL ANALYSIS - KEY FINDINGS 
======================================================================
1. Total users analysed : 38440

2. Funnel Distribution: 
   - view only : 90.83%
   - view->cart : 1.70%
   - view-> purchase : 4.9%
   - view->cart->purchase : 2.54%
   - cart->purchase : 0.0052%
   - purchase only : 0.0208%
   
3. Key Observations :
   - More than 90% of users only viewed the product and did not progress further. 
   - The largest drop-off occurs immediately after the view  stage
   - A significant number of purchases happen without generating a cart event (65.8% of purchases)
   - Multiple purchase paths exists. Therefore a simple linear funnel does not fully represent user behavior.
   
4. Business Implications :
   - Product page engagement and conversion optimization needs to be prioritized.
   - An investigation shall be performed to confirm if cart step is not mandatory or is there any data capturing issue.

*/

USE product_growth_analytics; 

# Unique users who performed the event - view
SELECT COUNT(DISTINCT user_id) AS view_users
FROM ecommerce_events_01
WHERE event_type = "view";

# Unique users who performed the event - cart addition
SELECT COUNT(DISTINCT user_id) AS cart_users
FROM ecommerce_events_01
WHERE event_type = "cart";

# Unique users who performed the event - Purchase 
SELECT COUNT(DISTINCT user_id) AS purchase_users
FROM ecommerce_events_01
WHERE event_type = "purchase"; 

# view -> cart conversion 
SELECT COUNT(DISTINCT CASE WHEN event_type = "cart" THEN user_id END) * 100.0 / 
	   COUNT(DISTINCT CASE WHEN event_type = "view" THEN user_id END) AS view_to_cart_conversion_rate
FROM ecommerce_events_01;

# cart -> purchase conversion 
SELECT COUNT(DISTINCT CASE WHEN event_type = "purchase" THEN user_id END) * 100.0 / 
	   COUNT(DISTINCT CASE WHEN event_type = "cart" THEN user_id END) AS cart_to_purchase_conversion_rate
FROM ecommerce_events_01;
# OBSERVATIONS : 
# cart_to_purchase_coversion_rate is 175.76%. 
# A conversion rate greater than 100% needs to be investigated as this is not consistent with the usual funnel behavior. 
# Generally views > cart > purchase. But here, the case is views > purchase > cart. 
# Possibilities for this scenario as follows: 
# 1. The current dataset is a sub-set of a larger dataset.
# 2. Purchases made without adding to the cart.

# view -> purchase conversion 
SELECT COUNT(DISTINCT CASE WHEN event_type = "purchase" THEN user_id END) * 100.0 / 
	   COUNT(DISTINCT CASE WHEN event_type = "view" THEN user_id END) AS view_to_purchase_conversion_rate
FROM ecommerce_events_01;

# user funnel table for deeper analysis
SELECT user_id, 
       MAX(CASE WHEN event_type = "view" THEN 1 ELSE 0 END) AS viewed, 
       MAX(CASE WHEN event_type = "cart" THEN 1 ELSE 0 END) AS added_to_cart,
       MAX(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) AS purchased
FROM ecommerce_events_01
GROUP BY user_id;
# OBSERVATIONS :
# we can see the following user-level funnel paths: 
# 1. view
# 2. view -> purchase ( no addition to cart) 
# 3. view -> cart 
# 4. view -> cart -> purchase 
# 5. cart -> purchase 
# 6. purchase
# These funnel paths are inconsistent with the assumption we made 
# i.e. view -> cart -> purchase.
# So we need to change our funnel metrics as per the current dataset. 

# funnel distribution in %
WITH sub_table AS(
SELECT user_id, 
       MAX(CASE WHEN event_type = "view" THEN 1 ELSE 0 END) AS viewed, 
       MAX(CASE WHEN event_type = "cart" THEN 1 ELSE 0 END) AS added_to_cart,
       MAX(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) AS purchased
FROM ecommerce_events_01
GROUP BY user_id)
SELECT SUM(CASE WHEN (viewed = 1 AND added_to_cart = 0 AND purchased = 0) THEN 1 ELSE 0 END) * 100.0 / 
       COUNT(*) AS only_view, 
	   SUM(CASE WHEN (viewed = 1 AND added_to_cart = 0 AND purchased = 1) THEN 1 ELSE 0 END) * 100.0 /
       COUNT(*) AS view_to_purchase, 
	   SUM(CASE WHEN (viewed = 1 AND added_to_cart = 1 AND purchased = 0) THEN 1 ELSE 0 END) * 100.0 /
       COUNT(*) AS view_to_cart, 
       SUM(CASE WHEN (viewed = 1 AND added_to_cart = 1 AND purchased = 1) THEN 1 ELSE 0 END) * 100.0 /
       COUNT(*) AS view_cart_purchase, 
       SUM(CASE WHEN (viewed = 0 AND added_to_cart = 1 AND purchased = 1) THEN 1 ELSE 0 END) * 100.0 /
       COUNT(*) AS cart_to_purchase,
       SUM(CASE WHEN (viewed = 0 AND added_to_cart = 0 AND purchased = 1) THEN 1 ELSE 0 END) * 100.0 /
       COUNT(*) AS only_purchase
FROM sub_table;
# OBSERVATIONS : 
# 1. More tham 90% of users are just viewing the product. This is where the biggest funnel drop is occuring.
# 2. The funnel is not following the traditional view->cart->purchase format.

# % of viewers who skipped cart for purchasing
#                 (view_to_purchase + only_purchase)
# ----------------------------------------------------------------------------  * 100
# (view_to_purchase + view_cart_purchase + cart_to_purchase + only_purchase)
WITH sub_table AS(
SELECT user_id, 
       MAX(CASE WHEN event_type = "view" THEN 1 ELSE 0 END) AS viewed, 
       MAX(CASE WHEN event_type = "cart" THEN 1 ELSE 0 END) AS added_to_cart,
       MAX(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) AS purchased
FROM ecommerce_events_01
GROUP BY user_id)
SELECT SUM(CASE WHEN (added_to_cart = 0 AND purchased = 1) THEN 1 ELSE 0 END) * 100.0 /
	   SUM(CASE WHEN purchased = 1 THEN 1 ELSE 0 END) AS skipped_cart_purchases
FROM sub_table;

# True cart conversion
#         (view_cart_purchase + cart_to_purchase) 
# ----------------------------------------------------------- * 100
# (view_cart_purchase + cart_to_purchase + view_to_cart)
WITH sub_table AS(
SELECT user_id, 
       MAX(CASE WHEN event_type = "view" THEN 1 ELSE 0 END) AS viewed, 
       MAX(CASE WHEN event_type = "cart" THEN 1 ELSE 0 END) AS added_to_cart,
       MAX(CASE WHEN event_type = "purchase" THEN 1 ELSE 0 END) AS purchased
FROM ecommerce_events_01
GROUP BY user_id)
SELECT SUM(CASE WHEN (added_to_cart = 1 AND purchased = 1) THEN 1 ELSE 0 END) * 100.0 /
       SUM(CASE WHEN added_to_cart = 1 THEN 1 ELSE 0 END) AS true_cart_to_purchase_conversion_rate 
FROM sub_table;

