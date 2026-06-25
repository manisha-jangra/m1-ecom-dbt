# Sales Analytics Platform - Milestone 2

## Project Overview

This project builds an analytics-ready reporting layer on top of transformed sales data and delivers actionable business insights through Power BI dashboards.

The solution was built using:

- PostgreSQL
- dbt
- Power BI
- GitHub

The project follows a dimensional modeling approach using Fact and Dimension tables and provides insights for multiple business personas.

---

# Repository Structure

```text
sales_analytics_project/

├── dbt_project/
│   └── models/
│       └── gold/
│           ├── fact_orders.sql
│           ├── dim_customers.sql
│           └── dim_products.sql

├── dashboard/
│   └── Sales_Analytics_M2.pbix

├── sql/
│   ├── total_revenue.sql
│   ├── total_orders.sql
│   ├── total_customers.sql
│   ├── units_sold.sql
│   ├── revenue_pm.sql
│   ├── mom_percent.sql
│   ├── revenue_by_month.sql
│   ├── revenue_by_category.sql
│   ├── revenue_by_payment_method.sql
│   ├── revenue_by_brand.sql
│   ├── revenue_by_city.sql
│   ├── top_10_customers.sql
│   └── order_level_details.sql

└── README.md
```

---

# Analytics Ready Data Model

## Fact Table

### fact_orders

**Grain:** One row per order transaction.

Columns:

- Order ID
- Customer ID
- Product ID
- Order Date
- Quantity
- Amount
- Payment Method

---

## Dimension Tables

### dim_customers

- Customer ID
- Customer Name
- Email
- City
- Created At

### dim_products

- Product ID
- Product Name
- Category
- Brand
- Price
- Created At

---

# Semantic Layer

The semantic layer is implemented using the Power BI Data Model.

### Relationships

- fact_orders[customer_id] → dim_customers[customer_id]
- fact_orders[product_id] → dim_products[product_id]

### Semantic Consistency

Business-friendly names and centralized DAX measures are used across all dashboards to ensure consistent metric definitions and reporting.

---

# Metrics and Definitions

## Total Revenue

**Definition:** Total sales revenue generated.

```DAX
Revenue =
SUM(fact_orders[amount])
```

---

## Total Orders

**Definition:** Total number of unique orders.

```DAX
Total Orders =
DISTINCTCOUNT(fact_orders[order_id])
```

---

## Total Customers

**Definition:** Total number of unique customers.

```DAX
Total Customers =
DISTINCTCOUNT(fact_orders[customer_id])
```

---

## Units Sold

**Definition:** Total quantity sold.

```DAX
Units Sold =
SUM(fact_orders[quantity])
```

---

## Revenue PM

**Definition:** Revenue generated during the previous month.

**Business Purpose:** Enables comparison of current performance against the previous month.

---

## MoM %

**Definition:** Month-over-Month revenue growth percentage.

**Business Purpose:** Measures revenue growth and trend performance over time.

---

# Dashboard 1: Overview Dashboard

## Target Persona

All business users requiring a quick summary of business performance.

## Questions Answered

- What is the overall business performance?
- How much revenue has been generated?
- How many orders and customers are there?
- Which categories contribute the most revenue?
- Which products perform best?

### KPIs

- Total Revenue
- Total Orders
- Total Customers
- Units Sold

### Visualizations

- Revenue Trend (Line Chart)
- Revenue by Category (Donut Chart)
- Top Products by Revenue
- Revenue by City

### Key Insights

- Electronics contributes the highest share of revenue.
- Premium products drive a significant portion of sales.
- Revenue is concentrated in a few major cities.
- Overall business performance remains stable.

---

# Dashboard 2: Business / Leadership Dashboard

## Target Persona

Business Leaders and Decision Makers

## Questions Answered

- How much revenue is the business generating?
- What is the revenue growth trend?
- Which categories drive the most revenue?
- Which payment methods are most used?
- Which brands generate the highest revenue?
- Which cities contribute the most revenue?
- What is the expected future revenue trend?

### KPI Cards

- Total Revenue
- Total Orders
- Total Customers
- Units Sold
- Revenue PM
- MoM %

### Visualizations

#### Revenue by Month & Forecast

- Line Chart

#### Total Revenue by Category

- Donut Chart

#### Total Revenue by Payment Method

- Pie Chart

#### Total Revenue by Brand

- Revenue Comparison Visual

#### Total Revenue by City

- Revenue Comparison Visual

### Key Insights

- Electronics is the highest revenue-generating category.
- Premium brands contribute the majority of revenue.
- Digital payment methods dominate customer transactions.
- Revenue is concentrated in high-performing cities.
- Revenue trend shows stable business growth.
- Forecast suggests continued revenue generation in upcoming periods.

---

# Dashboard 3: Analyst Dashboard

## Target Persona

Business Analysts and Operations Teams

## Questions Answered

- Which customers generate the most revenue?
- What are the highest-value transactions?
- Which payment methods perform best?
- Are there unusual revenue spikes or drops?
- What purchasing patterns exist across customers?

### KPI Cards

- Total Revenue
- Total Orders
- Total Customers
- Units Sold

### Visualizations

#### Revenue Trend with Forecast

- Line Chart

#### Top 10 Customers by Revenue

- Revenue Ranking Visual

#### Revenue by Payment Method

- Donut Chart

#### Order Level Details

- Table Visual

Columns:

- Order ID
- Order Date
- Customer Name
- City
- Product Name
- Category
- Brand
- Quantity
- Amount
- Payment Method

### Key Insights

- Top customers contribute a significant portion of total revenue.
- Revenue is concentrated among a small number of high-value transactions.
- Payment preferences reveal customer behavior patterns.
- Revenue spikes can be identified and investigated.
- Detailed order-level analysis supports operational decision-making.

---

# SQL Queries

The SQL folder contains all queries used to derive dashboard metrics and visualizations.

Files include:

- total_revenue.sql
- total_orders.sql
- total_customers.sql
- units_sold.sql
- revenue_pm.sql
- mom_percent.sql
- revenue_by_month.sql
- revenue_by_category.sql
- revenue_by_payment_method.sql
- revenue_by_brand.sql
- revenue_by_city.sql
- top_10_customers.sql
- order_level_details.sql

---

# Stretch Goals Implemented

## Time-Based Comparison

Implemented:

- Revenue PM
- MoM %

Purpose:

Compare current revenue against previous periods.

---

## Forecasting

Implemented using Power BI Forecast functionality.

Purpose:

Predict future revenue trends based on historical sales performance.

---

## Anomaly Detection

Implemented using Power BI Analytics Pane.

Purpose:

Identify unusual spikes and drops in revenue performance for further investigation.

---

# Known Data Limitations

- Dataset contains a limited number of customers and products.
- Geographic analysis is restricted to city-level information.
- Historical data volume is limited for long-term forecasting.
- Customer segmentation attributes are unavailable.
- Marketing and campaign data are not available.

---

# Conclusion

This project delivers a complete analytics reporting layer with semantic consistency, business-focused KPIs, forecasting, anomaly detection, and persona-based dashboards that support data-driven decision-making for both leadership and analytical users.