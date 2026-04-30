#  Ecommerce Analytics Project (dbt + PostgreSQL)

##  Project Overview

This project demonstrates an end-to-end analytics pipeline using **PostgreSQL** and **dbt (Data Build Tool)**.

It ingests raw transactional data, transforms it using layered modeling (Medallion Architecture), and exposes analytics-ready datasets using a **Star Schema**.

---

#  Architecture

## Data Lifecycle

```
Raw Layer (PostgreSQL)
    ↓
Staging Layer (dbt - cleaning & standardization)
    ↓
Intermediate Layer (business transformations)
    ↓
Marts Layer (fact & dimension tables)
    ↓
Analytics Layer (final views & queries)
```

---

##  Medallion Architecture

| Layer           | Description                                 |
| --------------- | ------------------------------------------- |
|  Bronze    | Raw data cleaning (`stg_*`)                 |
|  Silver    | Transformations (`int_*`)                   |
|  Gold      | Fact & Dimension tables (`fact_*`, `dim_*`) |

---

#  Data Model (Star Schema)

```
        dim_customers
              |
              |
        fact_orders
```

###  Fact Table: `fact_orders`

* order_id (PK)
* customer_id (FK)
* order_date
* amount

###  Dimension Table: `dim_customers`

* customer_id (PK)
* name

---

##  Why Star Schema (Not 3NF)

| Star Schema             | 3NF                        |
| ----------------------- | -------------------------- |
| Optimized for analytics | Optimized for transactions |
| Fewer joins             | Many joins                 |
| Faster queries          | Slower queries             |
| Denormalized            | Normalized                 |

 Star schema is chosen for **performance and simplicity in analytics**

---

#  Prerequisites

Make sure you have installed:

* Python (3.8+)
* PostgreSQL
* Git

---

#  Setup Virtual Environment

```bash
# Create virtual environment
python -m venv .dbt-env

# Activate (Windows Git Bash)
source .dbt-env/Scripts/activate

# Activate (Windows PowerShell)
.dbt-env\Scripts\activate

# Activate (Mac/Linux)
source .dbt-env/bin/activate
```

---

#  Install dbt

```bash
pip install dbt-core dbt-postgres
```

Check installation:

```bash
dbt --version
```

---

#  Setup PostgreSQL Database

```sql
CREATE DATABASE ecommerce_analytics;
```

---

#  Configure dbt Profile

📁 Location: `~/.dbt/profiles.yml`

```yaml
dbt_project:
  target: dev
  outputs:
    dev:
      type: postgres
      host: localhost
      user: postgres
      password: your_password
      port: 5432
      dbname: ecommerce_analytics
      schema: public
```

---

# Project Structure

```
models/
  staging/
    orders/
    customers/

  intermediate/
    orders/

  marts/
    sales/

macros/
tests/
```

---

#  Running dbt

## Install dependencies

```bash
dbt deps
```

## Run models

```bash
dbt run
```

## Run specific model

```bash
dbt run --select fact_orders
```

## Run tests

```bash
dbt test
```

---

#  Incremental Models

Used for large datasets to process only new data.

Example:

```sql
materialized = 'incremental'
```

---

#  Backfill Strategy

Run data for specific date range:

```bash
dbt run --select fact_orders \
  --vars '{"start_date": "2024-01-01", "end_date": "2024-01-03"}'
```

---

#  Full Refresh

Rebuild entire table:

```bash
dbt run --full-refresh --select fact_orders
```

---

#  Data Freshness Checks

## Run freshness check

```bash
dbt source freshness
```

## Fail pipeline if stale

```bash
dbt source freshness --warn-error && dbt run
```

---

#  Data Quality Tests

* not_null
* unique
* relationships
* freshness

Run:

```bash
dbt test
```

---

#  dbt Macros

Used to reduce repetitive SQL.

Example:

```sql
{{ filter_incremental('order_date') }}
```

---

#  Analytics Layer

## Final View

`fct_customer_orders`

Combines:

* fact_orders
* dim_customers

---

##  Example Queries

### Top 5 Customers by Revenue

```sql
SELECT
    customer_name,
    SUM(amount) AS total_revenue
FROM fct_customer_orders
GROUP BY customer_name
ORDER BY total_revenue DESC
LIMIT 5;
```

---

### Average Order Value

```sql
SELECT AVG(amount) AS avg_order_value
FROM fct_customer_orders;
```

---

### Daily Revenue

```sql
SELECT
    order_date,
    SUM(amount) AS revenue
FROM fct_customer_orders
GROUP BY order_date;
```

---

#  Generate Documentation

```bash
dbt docs generate
dbt docs serve
```

---

#  Features Implemented

* ✅ PostgreSQL raw data ingestion
* ✅ dbt transformations (staging → intermediate → marts)
* ✅ Fact & Dimension tables
* ✅ Incremental models
* ✅ Backfill strategy
* ✅ Data freshness checks
* ✅ Data tests
* ✅ Macros for reusable SQL
* ✅ Analytical queries



---

#  Author
Manisha Jangra
