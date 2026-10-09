
-- Bright Coffee Shop Sales Analysis  |  Case Study 1
-- BrightLearn Data Analytics  |  Candidate: DT Mbenga
-- Platform: Databricks (SQL)
-- TECHNICAL INSPECTION
-- Look at the data before processing it. Nothing is changed here.
-- ---------------------------------------------------------------------

-- This is how to check what my data looks like before I start processing it
-- SELECT * shows all columns; LIMIT 100 shows only the first 100 rows
-- Why: see the data before changing it; LIMIT keeps the query fast

SELECT *
FROM bright_coffee.sales.coffee_sales_clean
LIMIT 100;

-- This is how to check my column names and data types
-- DESCRIBE lists every column and its type (string = text, int = whole number)
-- Why: wrong types break calculations (e.g. a price stored as text)

DESCRIBE bright_coffee.sales.coffee_sales_clean;

-- This is how to check the overview: rows, stores, products, dates and opening hours
-- COUNT(*) counts rows; COUNT(DISTINCT) counts unique values; MIN/MAX find first and last
-- Why: defines the scope - 3 stores, 80 products, Jan-Jun 2023

SELECT COUNT(*)                         AS total_rows,
       COUNT(DISTINCT transaction_id)   AS unique_transactions,
       COUNT(DISTINCT store_location)   AS stores,
       COUNT(DISTINCT product_category) AS categories,
       COUNT(DISTINCT product_detail)   AS products,
       MIN(transaction_date)            AS start_date,
       MAX(transaction_date)            AS end_date,
       MIN(transaction_time)            AS opening_time,
       MAX(transaction_time)            AS closing_time

FROM bright_coffee.sales.coffee_sales_clean;

-- This is how to check each store, its ID and its opening hours
-- GROUP BY splits the data per store, then COUNT/MIN/MAX run for each store
-- Why: store hours differ, so time-of-day results must be read per store

SELECT store_id, store_location,
       COUNT(*)              AS records,
       MIN(transaction_time) AS opening_time,
       MAX(transaction_time) AS closing_time
FROM bright_coffee.sales.coffee_sales_clean
GROUP BY store_id, store_location
ORDER BY store_id;

-- This is how to check for missing (empty) values
-- COUNT(column) skips empty values, so COUNT(*) minus COUNT(column) = number missing
-- Why: empty values give wrong totals; result 0, so no cleaning needed

SELECT COUNT(*) - COUNT(transaction_date)  AS null_date,
       COUNT(*) - COUNT(transaction_time)  AS null_time,
       COUNT(*) - COUNT(transaction_qty)   AS null_qty,
       COUNT(*) - COUNT(unit_price)        AS null_price,
       COUNT(*) - COUNT(store_location)    AS null_store,
       COUNT(*) - COUNT(product_detail)    AS null_product
FROM bright_coffee.sales.coffee_sales_clean;

-- This is how to check if the price was read correctly when the file was loaded
-- MIN/MAX show the price range; product 57 should cost 3.1 (was '3,1' in the file)
-- Why: the file used comma decimals; proves prices are numbers, so revenue is correct

SELECT MIN(unit_price)                 AS lowest_price,
       MAX(unit_price)                 AS highest_price,
       COUNT(*) - COUNT(unit_price)    AS missing_prices,
       MAX(CASE WHEN product_id = 57 THEN unit_price END) AS product_57_price
FROM bright_coffee.sales.coffee_sales_clean;

-- This is how to check what the date and time columns really contain
-- Shows both columns side by side for the first 5 rows
-- Why: found a hidden midnight time and a dummy 1899 date; decides how to clean them

SELECT transaction_date, transaction_time
FROM bright_coffee.sales.coffee_sales_clean
LIMIT 5;

-- This is how to check the quantity values
-- GROUP BY lists each quantity once; COUNT(*) shows how often it appears
-- Why: no zero or negative quantities, so units and revenue can be trusted

SELECT transaction_qty, COUNT(*) AS records
FROM bright_coffee.sales.coffee_sales_clean
GROUP BY transaction_qty
ORDER BY transaction_qty;

-- =====================================================================
-- DATA PROCESSING  (big code, built step by step)
-- Steps 1-3 test each part on 10 rows. Step 4 is the full big code.
-- =====================================================================

-- STEP 1: This is how to clean the date and add month and day labels
-- CAST removes the midnight time; MONTH/DAYOFWEEK give numbers so labels sort in calendar order
-- Why: clean dates and readable labels for the CEO, in the right order
SELECT
    CAST(transaction_date AS DATE)  AS transaction_date,
    MONTH(transaction_date)         AS month_number,
    MONTHNAME(transaction_date)     AS month_name,
    DAYOFWEEK(transaction_date)     AS day_number,
    DAYNAME(transaction_date)       AS day_name,
    CASE
        WHEN DAYNAME(transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END                             AS day_classification
FROM bright_coffee.sales.coffee_sales_clean
LIMIT 10;

-- STEP 2: This is how to group the time into hours, 30-minute slots and parts of the day
-- Minutes 0-29 go to ':00' and 30-59 to ':30'; CASE labels Morning, Afternoon and Evening
-- Why: shows when stores are busy, which is used for staffing decisions

SELECT
    transaction_time,
    HOUR(transaction_time)          AS hour_of_day,
    CONCAT(LPAD(HOUR(transaction_time), 2, '0'), ':',
           CASE WHEN MINUTE(transaction_time) < 30 THEN '00' ELSE '30' END) AS time_bucket,
    CASE
        WHEN HOUR(transaction_time) < 12 THEN '01. Morning'
        WHEN HOUR(transaction_time) < 18 THEN '02. Afternoon'
        ELSE '03. Evening'
    END                             AS time_classification
FROM bright_coffee.sales.coffee_sales_clean
LIMIT 10;

-- STEP 3: This is how to calculate revenue for each sale
-- revenue = unit_price (2 decimals) x quantity
-- Why: the data has no revenue column; revenue is the CEO's main measure

SELECT
    transaction_id,
    store_location,
    product_detail,
    transaction_qty,
    CAST(unit_price AS DECIMAL(10,2))                   AS unit_price,
    CAST(unit_price AS DECIMAL(10,2)) * transaction_qty AS revenue
FROM bright_coffee.sales.coffee_sales_clean
LIMIT 10;  

-- STEP 4: This is how to build the full processed data (big code)
-- Joins steps 1-3 in one query; GROUP BY adds up sales, units and revenue per combination
-- Why: one repeatable query; 149,116 rows become 130,537 with nothing lost

SELECT
    CAST(transaction_date AS DATE)  AS transaction_date,
    MONTH(transaction_date)         AS month_number,
    MONTHNAME(transaction_date)     AS month_name,
    DAYOFWEEK(transaction_date)     AS day_number,
    DAYNAME(transaction_date)       AS day_name,
    CASE
        WHEN DAYNAME(transaction_date) IN ('Sat', 'Sun') THEN 'Weekend'
        ELSE 'Weekday'
    END                             AS day_classification,
    HOUR(transaction_time)          AS hour_of_day,
    CONCAT(LPAD(HOUR(transaction_time), 2, '0'), ':',
           CASE WHEN MINUTE(transaction_time) < 30 THEN '00' ELSE '30' END) AS time_bucket,
    CASE
        WHEN HOUR(transaction_time) < 12 THEN '01. Morning'
        WHEN HOUR(transaction_time) < 18 THEN '02. Afternoon'
        ELSE '03. Evening'
    END                             AS time_classification,
    store_location,
    product_category,
    product_type,
    product_detail,
    COUNT(transaction_id)                                    AS number_of_sales,
    SUM(transaction_qty)                                     AS units_sold,
    SUM(CAST(unit_price AS DECIMAL(10,2)) * transaction_qty) AS revenue
FROM bright_coffee.sales.coffee_sales_clean
GROUP BY
    transaction_date, month_number, month_name, day_number, day_name, day_classification,
    hour_of_day, time_bucket, time_classification,
    store_location, product_category, product_type, product_detail;   




