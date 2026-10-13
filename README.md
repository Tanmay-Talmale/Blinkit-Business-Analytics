# 🛒 Blinkit Business Analytics | SQL + Excel Dashboard

An end-to-end **Data & Business Analytics project** analyzing multi-year Blinkit order data to uncover insights into revenue performance, customer behavior, store operations, delivery efficiency, promotions, retention, and business risk.

---

## 📌 Project Overview

Blinkit is a quick-commerce platform where business performance depends on several interconnected factors such as:

- Order volume
- Revenue
- Customer retention
- Store performance
- Delivery efficiency
- Order cancellations and returns
- Promotions
- Customer satisfaction
- Repeat purchasing behavior

This project analyzes Blinkit's order-level transactional data from **2022 to 2026** using SQL and Excel to answer important business questions and convert raw transactional data into actionable business insights.

The project follows an end-to-end analytics workflow:

**Data → Cleaning → SQL Analysis → KPI Development → Business Insights → Dashboard → Recommendations**

---

# 🎯 Business Problem

Management needs to understand:

- How revenue and orders are changing over time
- Which stores and cities are driving the most revenue
- Which customer segments generate the most value
- How strong repeat-purchase behavior is
- Which stores have operational problems
- What causes cancellations and returns
- Whether delivery performance affects customer ratings
- Whether promotions are actually effective
- Which customers may be at risk of churn
- How concentrated the company's revenue is
- Which stores require operational intervention

The objective is to transform raw order data into **decision-ready business intelligence**.

---

# 🎯 Business Objectives

The project focuses on five major analytical areas:

### 1. Revenue & Sales Performance

Analyze:

- Total revenue
- Order volume
- Average Order Value
- Year-over-Year growth
- Monthly revenue trends
- Seasonal performance
- Store revenue contribution

### 2. Customer Analytics

Analyze:

- Customer tiers
- Customer spending
- High-value customers
- First-time vs repeat customers
- Reorder behavior
- Customer retention
- Customer churn risk
- Revenue concentration

### 3. Store & Operational Analytics

Analyze:

- Top-performing stores
- Store ranking within cities
- Store failure rate
- Cancellation and return rate
- Delivery efficiency
- Customer ratings
- Operational risk

### 4. Promotion Analytics

Analyze:

- Promotion usage
- Promotion vs non-promotion orders
- Average order value
- Quantity purchased
- Discount cost
- Promo-code revenue contribution

### 5. Customer Experience

Analyze:

- Delivery time
- Delivery slots
- Order ratings
- Express eligibility
- Relationship between delivery performance and satisfaction

---

# 📊 Dataset

The project uses five yearly cleaned order-level datasets:

| Year | Dataset |
|---|---|
| 2022 | blinkit_orders_2022_cleaned.csv |
| 2023 | blinkit_orders_2023_cleaned.csv |
| 2024 | blinkit_orders_2024_cleaned.csv |
| 2025 | blinkit_orders_2025_cleaned.csv |
| 2026 | blinkit_orders_2026_cleaned.csv |

Each row represents an individual order.

### Main Dataset

`blinkit_orders`

### Key dimensions

- Customer
- Store
- City
- Zone
- Platform
- Payment Method
- Delivery Slot
- Order Status
- Customer Tier

### Key measures

- MRP
- Product Discount
- Promo Discount
- Delivery Fee
- Tip
- Cashback
- Grand Total
- Delivery Time
- Order Rating
- Quantity

---

# ⚠️ Data Coverage Note

The 2026 dataset represents **partial/YTD data** rather than a complete calendar year.

Therefore, 2026 should not be interpreted as a full-year comparison against earlier years without first aligning the comparison period.

---

# 🧹 Data Preparation

The datasets were cleaned and prepared before SQL analysis.

Key preparation activities included:

- Standardizing order dates
- Validating order status
- Handling promotion values
- Validating cancellation/return reasons
- Handling delivery-time values
- Validating numerical fields
- Checking order and customer identifiers
- Preparing yearly datasets for database loading

The cleaned datasets were then prepared for MySQL analysis.

---

# 🗄️ Database Structure

The main analytical table is:

```text
blinkit_orders
