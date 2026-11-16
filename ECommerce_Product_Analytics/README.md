# E-Commerce Product Growth & Conversion Analytics

## Project Overview

This project analyzes user behavior, engagement, conversion funnels and revenue performance for an e-commerce platform.

The objective is to find out how users are interacting with the products, identify conversion bottle-necks, evaluate category and brand performance and generate actionable business insights using SQL, python and Power BI.

---

## Business Problem

The e-commerce platform receives significant user traffic but needs to understand:

- How users interact with product?
- Where users drop-off in the purchase funnel?
- Which category and brands drive business performances?
- How user engagement impacts revenue genration?

The goal is to identify opportunities to improve user engagement, conversion rates and revenue.

---

## Dataset 

### Source

E-Commerce Behavior Data from Multi Category Store

### Working Dataset

- ~200,000 events
- 38,440 unique users
- 47,697 unique sessions

### Key Fields

- event_time
- event_type
- product_id
- category_id
- category_code
- brand
- price
- user_id
- user_session

---

## Tools used

- MySQL
- Python
  - Pandas
  - Numpy
- Power BI
- VS Code

---

## Project Workflow

### 1. Data Understanding

- Dataset exploration
- Column analysis
- Event type analysis
- Missing value assessment

### 2. Data Cleaning

- Duplicate detection and removal
- Missing value analysis
- Datetime conversion
- Feature creation for date-based analysis

### 3. SQL Analytics

#### Growth Metrics

- Total users
- Total sessions
- Events per user
- Sessions per user

#### Funnel Analysis

- view->cart conversion
- cart->purchase conversion
- view->purchase conversion
- User Journey Analysis

#### Revenue Analysis

- Total Revenue
- Purchase volume
- APV (Average Purchase Value)
- Revenue by Category
- Revenue by Brand
- Top products by Revenue

#### Category & Brand Analysis

- Revenue Distribution
- Purchase Distribution
- Purchase rate Analysis

#### Engagement Analysis

- Event Distribution
- User Activity Segmentation
- Session Depth Analysis

### 4. Power BI Dashboard

- Executive Summary
- Funnel Analysis
- Engagement Analysis
- Category & Brand Analysis

---

## Key Insights

### Funnel Analysis

- Approximately 90.8% of users just viewed the products and did not progress further.
- View->Cart coversion was 4.25%.
- Nearly 60% of users who reached the cart stage, completed a purchase.
- Multiple purchase paths were observed including View->Purchase and View->Cart->Purchase journeys.

### Revenue Analysis

- Total Revenue generated was $1,104,983.78.
- Average Purchase Value(APV) was 303.65.
- Smartphones contributed 67.88% of total revenue.
- Apple and Samsung together contributed approximately 2/3rd of total revenue.

### Engagement Analysis

- 96.74% of all platform activity consisted of product views.
- Average events per user : 5.19.
- Average events per session : 4.19.
- Average sessions per user : 1.24.
- Most users generated fewer than 20 events.

### Category & Brand Analysis

- Smartphones led both purchase volume and revenue contribution.
- Apple and Samsung were the strongest performing brands.
- Purchhase rate remains below 4% for leading brands and categories.
- Revenue leadership appeared to e driven by traffic volume rather than high conversion efficieny.

---

## Business Recommendations

- Improve view->cart conversion through better product pages and merchandising.
- Investigate categories and brands with high traffic but with relatively low purchase rates.
- Increase user engagement by encouraging deeper product exploration within sessions.
- Focus conversion optimization on high-traffic categories, particularly smartphones.
- Reduce revenue concentration risk by improving the performance of non-smartphones categories.

---

## Dashboard Pages

### Page 1 - Executive Summary

- Revenue KPIs
- User KPIs
- Revenue by Category
- Revenue by Brand

### Page 2 - Funnel Analysis

- Funel visualization
- Users Journet Distribution
- Conversion metrics

### Page 3 - Engagement Analysis

- Event Distribution
- User segments
- Session Depth Analysis

### Page 4 - Category & Brand Analysis

- Revenue share by Category
- Revenue share by Brand
- Revenue rate by Category
- Revenue rate by Brand

## Project Outcome

This project demonstrates end-to-end Product Analytics skills including data preparation, SQL analysis, business metric development, visualization, and insight generation.

The analysis identified significant opportunities to improve user onversion and engagement while highlighting the dominant role of smartphone categories and premium brands in overall business performance.