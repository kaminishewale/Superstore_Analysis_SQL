CREATE DATABASE superstore_db;
USE superstore_db;

CREATE TABLE superstore (
  `ROW ID` INT,
  `Order ID` VARCHAR(50),
  `Order Date` VARCHAR(20),
  `Ship Date` VARCHAR(20),
  `Ship Mode` VARCHAR(50),
  `Customer ID` VARCHAR(50),
  `Customer Name` VARCHAR(100),
  `Segment` VARCHAR(50),
  `Country` VARCHAR(50),
  `City` VARCHAR(50),
  `State` VARCHAR(50),
  `Postal Code` VARCHAR(20),
  `Region` VARCHAR(50),
  `Product ID` VARCHAR(50),
  `Category` VARCHAR(50),
  `Sub-Category` VARCHAR(50),
  `Product Name` VARCHAR(200),
  `Sales` DECIMAL(10,2),
  `Quantity` INT,
  `Discount` DECIMAL(5,2),
  `Profit` DECIMAL(10,2)
);

SELECT COUNT(*) FROM superstore;
SELECT * FROM superstore LIMIT 10;

ALTER TABLE superstore
ADD COLUMN order_date_new DATE,
ADD COLUMN ship_date_new DATE;

UPDATE superstore
SET 
  order_date_new = STR_TO_DATE(TRIM(`Order Date`), '%m/%d/%Y'),
  ship_date_new = STR_TO_DATE(TRIM(`Ship Date`), '%d/%m/%Y');


DESCRIBE superstore;

SELECT `Order Date`
FROM superstore
WHERE `Order Date` IS NULL
   OR `Order Date` = ''
   OR `Order Date` NOT REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';

SELECT * FROM superstore
WHERE `Order Date` LIKE '1/%/2020';

SELECT *
FROM superstore
WHERE `Order Date` REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$'
  AND `Ship Date` REGEXP '^[0-9]{1,2}/[0-9]{1,2}/[0-9]{4}$';

UPDATE superstore
SET order_date_new = '2020-01-01'
WHERE order_date_new IS NULL;

UPDATE superstore
SET ship_date_new = '2020-01-02'
WHERE ship_date_new IS NULL;

SELECT COUNT(*) AS total_rows FROM superstore;

-- View first 10 rows
SELECT * FROM superstore LIMIT 10;

-- Check distinct categories
SELECT DISTINCT Category FROM superstore;

-- Check regions
SELECT DISTINCT Region FROM superstore;

-- Filter category = 'Technology'
SELECT *
FROM superstore
WHERE Category = 'Technology';

-- Top 10 sales items
SELECT `Product Name`, Sales
FROM superstore
ORDER BY Sales DESC
LIMIT 10;

-- Total sales by category
SELECT Category, SUM(Sales) AS total_sales, AVG(Profit) AS avg_profit, COUNT(*) AS total_orders
FROM superstore
GROUP BY Category;

-- Total sales by region
SELECT Region, SUM(Sales) AS total_sales, AVG(Profit) AS avg_profit
FROM superstore
GROUP BY Region;

-- Categories with Sales > 100000
SELECT Category, SUM(Sales) AS total_sales
FROM superstore
GROUP BY Category
HAVING SUM(Sales) > 100000;

-- Monthly sales report using BETWEEN (dates are VARCHAR)
SELECT *
FROM superstore
WHERE `Order Date` BETWEEN '1/1/2020' AND '1/31/2020';

-- Customer name pattern search using LIKE
SELECT *
FROM superstore
WHERE `Customer Name` LIKE 'A%';  -- customers starting with 'A'



