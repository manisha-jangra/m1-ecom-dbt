# 📊 Ecommerce Analytics Project (dbt + PostgreSQL)

---

# 📌 Project Overview

This project demonstrates an end-to-end **data analytics pipeline** using:

* **PostgreSQL** → data storage
* **dbt (Data Build Tool)** → data transformation

Raw transactional data is ingested using **CSV seeds**, transformed using **Medallion Architecture (Bronze → Silver → Gold)**, and exposed as analytics-ready datasets using a **Star Schema**.

---

# 🔄 Data Lifecycle (Raw → Transformed → Analytics)

```text
CSV Files (Raw Data)
        ↓
dbt Seeds → PostgreSQL Tables
        ↓
Bronze Layer (stg_* → cleaning & validation)
        ↓
Silver Layer (orders_enriched → joins & business logic)
        ↓
Gold Layer (fact & dimension tables)
        ↓
Analytics Layer (queries & insights)
```

---

# 🏗️ Medallion Architecture Implementation

| Layer     | Models                                         | Purpose                   |
| --------- | ---------------------------------------------- | ------------------------- |
| 🟤 Bronze | `stg_customers`, `stg_orders`, `stg_products`  | Data cleaning, validation |
| ⚪ Silver  | `orders_enriched`                              | Joins & business logic    |
| 🟡 Gold   | `fact_orders`, `dim_customers`, `dim_products` | Analytics-ready tables    |

---

# 📦 Data Model (Star Schema)

```text
            dim_customers
                 |
                 |
dim_products —— fact_orders
```

---

## 📊 Fact Table: `fact_orders`

* `order_id` (Primary Key)
* `customer_id` (Foreign Key)
* `product_id` (Foreign Key)
* `order_date`
* `amount`

---

## 📋 Dimension Tables

### `dim_customers`

* `customer_id` (Primary Key)
* `name`
* `email`

### `dim_products`

* `product_id` (Primary Key)
* `product_name`
* `category`

---

# ❓ Why Star Schema (Not 3NF)

| Star Schema             | 3NF                        |
| ----------------------- | -------------------------- |
| Optimized for analytics | Optimized for transactions |
| Fewer joins             | Many joins                 |
| Faster queries          | Slower queries             |
| Denormalized            | Normalized                 |

👉 Star schema improves **performance and simplicity for reporting**

---

# ⚙️ Setup Instructions

## 1. Create Virtual Environment

```bash
python -m venv .dbt-env
source .dbt-env/Scripts/activate   # Windows Git Bash
export $(grep -v '^#' .env | xargs) # for read .env
```

---

## 2. Install dbt

```bash
pip install dbt-core dbt-postgres
dbt --version
```

---

## 3. Setup PostgreSQL

```sql
CREATE DATABASE dbt_ecom;
```

---

## 4. Configure dbt Profile

📁 `~/.dbt/profiles.yml`

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
      dbname: dbt_ecom
      schema: public
```

---

# 📁 Project Structure

```text
models/
  bronze/
    stg_customers.sql
    stg_orders.sql
    stg_products.sql

  silver/
    orders_enriched.sql

  gold/
    fact_orders.sql
    dim_customers.sql
    dim_products.sql

seeds/
analyses/
macros/
tests/
```

---

# 🚀 How to Run the Project

## 1. Load Raw Data

```bash
dbt seed
```

---

## 2. Check Data Freshness

```bash
dbt source freshness
```

---

## 3. Run Transformations

```bash
dbt run
```

---

## 4. Run Specific Model

```bash
dbt run --select fact_orders
```

---

## 5. Run Tests

```bash
dbt test
```

---

## 6. Full Refresh

```bash
dbt run --full-refresh
```

---

## 7. Backfill Historical Data

```bash
dbt run --select fact_orders \
  --vars '{"start_date": "2024-01-01", "end_date": "2024-01-10"}'
```

---

# 🔄 Incremental Model

```sql
{{ config(
    materialized='incremental',
    unique_key='order_id',
    incremental_strategy='merge'
) }}
```

### ✅ Benefits:

* Faster execution
* Handles large datasets
* Updates + inserts (MERGE)

---

# ⏱️ Data Freshness Checks

```yaml
freshness:
  warn_after: {count: 1, period: day}
  error_after: {count: 2, period: day}
```

---

# 🧠 dbt Macros (Reusable Logic)

### Example:

```sql
{{ incremental_filter('created_at') }}
```

```sql
{% macro incremental_filter(column_name) %}

{% if is_incremental() %}

    and {{ column_name }} > (
        select coalesce(max({{ column_name }}), '1900-01-01')
        from {{ this }}
    )

{% endif %}

{% endmacro %}
```

---

# 📊 Analytics Layer (Analyses)

Located in:

```text
analyses/
  daily_revenue.sql
  sales_summary.sql
  top_products.sql
```

---

## 🔹 Run Analysis Queries

```bash
dbt show --select analyses.daily_revenue
dbt show --select analyses.sales_summary
dbt show --select analyses.top_products
```

---

### Option 3 (Compile & Run)

```bash
dbt compile
```

Then run SQL from:

```text
target/compiled/dbt_project/analyses/
```

---

# 📚 dbt Documentation

## Generate Docs

```bash
dbt docs generate
```

---

## Serve Docs

```bash
dbt docs serve
```

Open:

```text
http://localhost:8080
```

---

## 🔥 Features

* Model lineage graph
* Column-level documentation
* Data flow visualization

---

# ✅ Features Implemented

* ✔ CSV-based ingestion (dbt seeds)
* ✔ Medallion architecture
* ✔ Star schema modeling
* ✔ Incremental models (MERGE)
* ✔ Backfill strategy
* ✔ Data freshness checks
* ✔ Data quality tests
* ✔ Reusable macros
* ✔ Analytical queries
* ✔ dbt documentation

---

# 🧠 Execution Flow (Recommended)

```bash
dbt seed
dbt source freshness
dbt run
dbt test
dbt docs generate
dbt docs serve
```

---

# 👩‍💻 Author

**Manisha Jangra**