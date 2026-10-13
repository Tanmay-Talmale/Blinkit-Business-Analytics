# Blinkit Business & Data Analytics

![Blinkit](https://img.shields.io/badge/Project-Blinkit-yellow)
![SQL](https://img.shields.io/badge/SQL-MySQL-blue)
![Excel](https://img.shields.io/badge/Excel-Dashboard-green)
![Analytics](https://img.shields.io/badge/Analytics-Business%20Analytics-orange)

## 📌 Project Overview

This project presents an end-to-end **Business & Data Analytics analysis of Blinkit order data** using SQL, Excel, and business intelligence techniques.

The objective of this project is to transform multi-year transactional order data into meaningful business insights across:

- Revenue & Sales Performance
- Customer Behaviour
- Customer Retention
- Store Performance
- Delivery Operations
- Cancellation & Return Analysis
- Promotion Effectiveness
- Customer Churn
- Revenue Concentration
- Operational Risk

The project demonstrates how SQL and Excel can be used not only to analyze data, but also to support **business decision-making**.

---

# 🎯 Business Problem

Blinkit operates a large quick-commerce network where business performance depends on multiple factors such as:

- Customer acquisition and retention
- Order frequency
- Store-level performance
- Delivery efficiency
- Order cancellations and returns
- Promotional campaigns
- Customer satisfaction
- Revenue concentration

The business needs a structured analytical approach to understand **what is happening, why it is happening, and where management should take action.**

This project addresses these requirements through SQL-based analysis and an interactive Excel dashboard.

---

# 🎯 Business Objectives

The key objectives of this project are:

1. Analyze overall revenue and order performance.
2. Measure year-over-year business growth.
3. Identify monthly and seasonal revenue trends.
4. Identify top-performing stores and cities.
5. Analyze customer tiers and customer value.
6. Measure first-time vs repeat customer contribution.
7. Analyze reorder behaviour.
8. Identify cancellation and return patterns.
9. Evaluate delivery performance.
10. Measure customer satisfaction through ratings.
11. Analyze promotional effectiveness.
12. Identify customers at risk of churn.
13. Understand revenue concentration.
14. Identify operationally risky stores.
15. Build an executive-level business dashboard.

---

# 📊 Dataset

The project uses cleaned order-level Blinkit datasets covering:

| Year | Dataset |
|---|---|
| 2022 | `blinkit_orders_2022_cleaned.csv` |
| 2023 | `blinkit_orders_2023_cleaned.csv` |
| 2024 | `blinkit_orders_2024_cleaned.csv` |
| 2025 | `blinkit_orders_2025_cleaned.csv` |
| 2026 | `blinkit_orders_2026_cleaned.csv` |

> **Note:** 2026 contains partial/YTD data and should not be interpreted as a complete-year comparison with previous years.

---

# 🗂️ Dataset Structure

The main analytical table is:

```text
blinkit_orders
```

The dataset contains information related to:

- Orders
- Customers
- Stores
- Cities
- Zones
- Delivery
- Payments
- Promotions
- Discounts
- Ratings
- Order status
- Customer behaviour

---

# 🔍 Key Business KPIs

The analysis focuses on the following KPIs:

### Revenue KPIs

- Total Revenue
- Average Order Value
- Revenue Growth
- Monthly Revenue
- Revenue by City
- Revenue by Store

### Customer KPIs

- Total Customers
- Orders per Customer
- Customer Tier Performance
- Reorder Rate
- First vs Repeat Orders
- High-Value Customers
- Churn-Risk Customers

### Operational KPIs

- Total Orders
- Delivery Time
- Average Rating
- Cancellation Rate
- Return Rate
- Failure Rate
- Express Delivery Performance
- Operational Risk Score

### Promotion KPIs

- Promotion Usage
- Promotional Revenue
- Average Promotion Discount
- Revenue Contribution by Promo Code
- Promotion vs Non-Promotion AOV

---

# 🧠 Analytical Approach

The project follows a structured analytics workflow:

```text
Raw Data
   ↓
Data Cleaning
   ↓
Data Validation
   ↓
MySQL Database
   ↓
SQL Analysis
   ↓
Business KPIs
   ↓
Excel Dashboard
   ↓
Business Insights
   ↓
Recommendations
```

---

# 🛠️ Tools & Technologies

### Data Analysis

- SQL
- MySQL
- Microsoft Excel

### SQL Concepts

- SELECT
- WHERE
- GROUP BY
- HAVING
- CASE WHEN
- CTEs
- JOINs
- Aggregate Functions
- Window Functions
- LAG
- RANK
- NTILE
- NULLIF
- DATE Functions
- Cohort Analysis
- Customer Segmentation

### Business Analytics

- KPI Analysis
- Trend Analysis
- Customer Segmentation
- Retention Analysis
- Churn Analysis
- Operational Analysis
- Revenue Analysis
- Promotion Analysis

---

# 📈 SQL Business Analysis

The project contains **20 medium-to-hard SQL business analysis questions**.

| # | Business Analysis |
|---|---|
| 1 | Overall Business KPI Dashboard |
| 2 | Year-over-Year Revenue & Order Growth |
| 3 | Monthly Revenue Trend & Seasonal Performance |
| 4 | Top 10 Stores by Revenue |
| 5 | Store Performance Ranking Within Each City |
| 6 | High-Value Customer Identification |
| 7 | Customer Tier Performance |
| 8 | Reorder Rate by Customer Tier |
| 9 | First-Time vs Repeat Customer Revenue |
| 10 | Cancellation & Return Rate by Store |
| 11 | Reasons Behind Cancellations/Returns |
| 12 | Delivery Slot vs Customer Satisfaction |
| 13 | Express Eligibility vs Delivery Performance |
| 14 | High-Volume Stores with Poor Delivery Efficiency |
| 15 | Promotion Effectiveness |
| 16 | Promo Code Revenue Contribution |
| 17 | Customer Cohort / Retention Analysis |
| 18 | Customers at Risk of Churn |
| 19 | Revenue Concentration |
| 20 | Store Operational Risk Score |

---

# 📊 Dashboard

The Excel dashboard follows a **Blinkit-inspired business dashboard design** using:

- Yellow navigation panel
- Green KPI accents
- White analytical cards
- Dark typography
- Rounded visual sections
- Business-focused charts
- Interactive filters

## Dashboard Pages

### Page 1 — Executive Overview

Key metrics:

- Total Revenue
- Total Orders
- Total Customers
- Average Order Value
- Average Rating

Visuals:

- Revenue Trend
- Orders Trend
- Revenue by City
- Revenue by Zone
- Customer Tier Performance

---

### Page 2 — Customer & Revenue Analysis

Visuals:

- Customer Tier Revenue
- First vs Repeat Orders
- Reorder Rate
- High-Value Customer Segments
- Promotion Performance
- Revenue Concentration

---

### Page 3 — Operations

Visuals:

- Store Performance
- Delivery Time
- Average Rating
- Cancellation / Return Rate
- Delivery Slot Performance
- Express Eligibility
- Operational Risk Score

---

# 💡 Business Insights

The analysis is designed to answer questions such as:

### Revenue

- Is revenue consistently growing?
- Which months generate the highest revenue?
- Which cities and stores contribute the most?

### Customers

- Which customer tiers generate the most revenue?
- What percentage of orders come from repeat customers?
- Which customers have high lifetime value?
- Which customers are at risk of churn?

### Operations

- Which stores have high failure rates?
- Which high-volume stores have slow delivery?
- Which delivery slots perform better?
- Does express eligibility improve delivery performance?

### Promotions

- Are promotional orders generating higher AOV?
- Which promo codes contribute the most revenue?
- How much discount is being given?

---

# 🚨 Operational Risk Analysis

A composite operational risk score is created using:

- Store order volume
- Failure rate
- Delivery performance
- Customer rating

The objective is to identify stores that require operational attention rather than simply ranking stores by revenue.

---

# 📌 Business Recommendations

Based on the analytical framework, management can:

1. Prioritize high-performing stores for capacity expansion.
2. Investigate stores with unusually high cancellation/return rates.
3. Improve delivery operations at high-volume slow stores.
4. Target high-value customers with personalized retention strategies.
5. Create win-back campaigns for churn-risk customers.
6. Evaluate promotions based on incremental order value rather than revenue alone.
7. Monitor customer satisfaction alongside delivery speed.
8. Use operational risk scoring to prioritize store-level interventions.
9. Monitor revenue concentration to reduce dependency on a small customer segment.
10. Use customer tier and reorder behaviour to improve retention.

---

# 📁 Repository Structure

```text
Blinkit-Business-Analytics/
│
├── README.md
│
├── Data/
│   ├── blinkit_orders_2022_cleaned.csv
│   ├── blinkit_orders_2023_cleaned.csv
│   ├── blinkit_orders_2024_cleaned.csv
│   ├── blinkit_orders_2025_cleaned.csv
│   ├── blinkit_orders_2026_cleaned.csv
│   └── README.md
│
├── SQL/
│   ├── blinkit_date_import.sql
│   └── blinkit_business_analysis.sql
│
├── Excel/
│   └── Blinkit_Business_Analysis_Dashboard.xlsx
│
├── Dashboard/
│   ├── Dashboard_Page_1_Executive_Overview.png
│   ├── Dashboard_Page_2_Customer_Revenue.png
│   └── Dashboard_Page_3_Operations.png
│
├── Documentation/
│   ├── Project_Overview.md
│   ├── Data_Dictionary.md
│   └── Business_Insights.md
│
└── Presentation/
    └── Blinkit_SQL_Business_Analysis_20_Queries.pptx
```

---

# 📚 Project Documentation

Additional documentation can be found inside the `Documentation` folder.

- [Project Overview](Documentation/Project_Overview.md)
- [Data Dictionary](Documentation/Data_Dictionary.md)
- [Business Insights](Documentation/Business_Insights.md)

---

# 📊 Project Deliverables

This repository contains:

✅ Cleaned datasets  
✅ MySQL import script  
✅ SQL business analysis queries  
✅ Excel business dashboard  
✅ Dashboard screenshots  
✅ Data dictionary  
✅ Business insights  
✅ SQL analysis presentation  

---

# 👨‍💻 Author

**Tanmay Talmale**

Data Analyst | Business Analyst

GitHub: [Tanmay-Talmale](https://github.com/Tanmay-Talmale)

---

# ⭐ Conclusion

This project demonstrates an end-to-end approach to **data-driven business analysis**, from raw transactional data and SQL analysis to dashboard development and actionable business recommendations.

The objective is not only to understand the data, but to convert analytical findings into **business decisions and operational improvements**.
