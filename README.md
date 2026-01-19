# Superstore_Analysis_SQL

This repository contains the SQL workflow and analysis for the Superstore dataset. It includes table creation, data cleaning, handling of date columns, filtering, sorting, aggregations, HAVING queries, monthly reports, and pattern searches. All query results have been exported to CSV files for professional documentation.

---

## 1. Dataset and Database Setup

* Dataset: Superstore CSV
* Database: `superstore_db` (MySQL)
* Table: `superstore`
* Table columns created with appropriate data types

  * Dates (`Order Date` and `Ship Date`) initially imported as `VARCHAR` to avoid format errors
  * Added new DATE columns: `order_date_new` and `ship_date_new` for proper date analysis
* Total rows imported: matches CSV row count

---

## 2. Data Cleaning and Date Conversion

* Trimmed extra spaces from date columns using `TRIM()`
* Converted valid date strings to DATE format using `STR_TO_DATE`

  * `order_date_new = STR_TO_DATE(TRIM(`Order Date`), '%m/%d/%Y')`
  * `ship_date_new = STR_TO_DATE(TRIM(`Ship Date`), '%d/%m/%Y')`
* Invalid or missing dates were handled as NULL and then optionally filled with default dates:

  * `order_date_new = '2020-01-01'` for missing order dates
  * `ship_date_new = '2020-01-02'` for missing ship dates
* Verified table structure with `DESCRIBE superstore`

---

## 3. Basic Data Exploration

* Count total rows:

  ```sql
  SELECT COUNT(*) AS total_rows FROM superstore;
  ```
* View first 10 rows:

  ```sql
  SELECT * FROM superstore LIMIT 10;
  ```
* Check distinct categories:

  ```sql
  SELECT DISTINCT Category FROM superstore;
  ```
* Check distinct regions:

  ```sql
  SELECT DISTINCT Region FROM superstore;
  ```

---

## 4. Filtering and Sorting

* Filter orders in category **Technology**:

  ```sql
  SELECT *
  FROM superstore
  WHERE Category = 'Technology';
  ```
* Top 10 sales items:

  ```sql
  SELECT `Product Name`, Sales
  FROM superstore
  ORDER BY Sales DESC
  LIMIT 10;
  ```

---

## 5. Aggregations and Summary Reports

* Total sales, average profit, and order count by category:

  ```sql
  SELECT Category, SUM(Sales) AS total_sales, AVG(Profit) AS avg_profit, COUNT(*) AS total_orders
  FROM superstore
  GROUP BY Category;
  ```
* Total sales and average profit by region:

  ```sql
  SELECT Region, SUM(Sales) AS total_sales, AVG(Profit) AS avg_profit
  FROM superstore
  GROUP BY Region;
  ```
* Categories with total sales greater than 100,000:

  ```sql
  SELECT Category, SUM(Sales) AS total_sales
  FROM superstore
  GROUP BY Category
  HAVING SUM(Sales) > 100000;
  ```

---

## 6. Date and Pattern Queries

* Monthly sales report for January 2020:

  ```sql
  SELECT *
  FROM superstore
  WHERE `Order Date` BETWEEN '1/1/2020' AND '1/31/2020';
  ```
* Customers with names starting with 'A':

  ```sql
  SELECT *
  FROM superstore
  WHERE `Customer Name` LIKE 'A%';
  ```

---

## 7. Folder Structure

```
queries_task3.sql
 CSV_Exports/
│   ├─ category_sales.csv
│   ├─ region_sales.csv
│   ├─ top_sales_items.csv
│   ├─ jan_to_dec_2020_orders.csv
│   └─ customer_names_A.csv
│
└─ README.md
```

---

## 8. Notes

* All queries executed in **MySQL Workbench**
* Query results exported to **CSV** for documentation
* Dates imported as VARCHAR first to avoid errors; converted valid dates to DATE for analysis
* Invalid or missing dates handled safely without causing query errors
* All SQL queries saved in `queries_task3.sql` for submission

---

## 9. CSV Export Plan

| Query Description               | Exported CSV           |
| ------------------------------- | ---------------------- |
| Total sales by category         | `category_sales.csv`   |
| Total sales by region           | `region_sales.csv`     |
| Top 10 sales items              | `top_sales_items.csv`  |
| Monthly sales report (Jan 2020) | `jan_2020_orders.csv`  |
| Customers starting with 'A'     | `customer_names_A.csv` |
