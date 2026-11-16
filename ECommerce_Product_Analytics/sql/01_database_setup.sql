CREATE DATABASE product_growth_analytics;

USE product_growth_analytics;

CREATE TABLE ecommerce_events (
event_time DATETIME,
event_type VARCHAR(20),
product_id BIGINT,
category_id BIGINT,
category_code VARCHAR(255),
brand VARCHAR(100),
price DECIMAL(10,2),
user_id BIGINT,
user_session VARCHAR(100)
);

CREATE TABLE ecommerce_events_01 (
event_time DATETIME,
event_type VARCHAR(20),
product_id BIGINT,
category_id BIGINT,
category_code VARCHAR(255),
brand VARCHAR(100),
price DECIMAL(10,2),
user_id BIGINT,
user_session VARCHAR(100)
);

SHOW TABLES;

DESCRIBE ecommerce_events;

SELECT COUNT(*)
FROM ecommerce_events;

TRUNCATE TABLE ecommerce_events;

SELECT COUNT(*)
FROM ecommerce_events;

SELECT * 
FROM ecommerce_events 
LIMIT 5;

SELECT COUNT(DISTINCT product_id) 
FROM ecommerce_events;

INSERT INTO ecommerce_events_01
SELECT *
FROM ecommerce_events 
LIMIT 199862;

SELECT COUNT(*)
FROM ecommerce_events_01;

SELECT MAX(price)
FROM ecommerce_events_01;

SELECT MIN(price)
FROM ecommerce_events_01;

SELECT AVG(price)
FROM ecommerce_events_01;

DROP TABLE ecommerce_events;

SELECT * 
FROM ecommerce_events_01
LIMIT 50;
# OBSERVATION : 
# There are empty spaces in category_code and brand columns. 




