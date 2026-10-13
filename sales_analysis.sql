– ============================================================
– PROJECT: SALES DATA ANALYSIS USING SQL
– Database: sql_project_p1
– Table: retail_sales
– Tool: MySQL Workbench

– OBJECTIVE:
– Analyze sales performance, product categories, monthly
– revenue, customer purchasing behavior, and data quality.
– ============================================================

USE sql_project_p1;

– ============================================================
– 1. VIEW SAMPLE RECORDS
– Business question: What does the sales dataset contain?
– ============================================================

SELECT *
FROM sql_project_p1.retail_sales
LIMIT 5;

– ============================================================
– 2. COUNT TOTAL RECORDS
– Business question: How many records are in the dataset?
– ============================================================

SELECT
COUNT(*) AS total_records
FROM sql_project_p1.retail_sales;

– ============================================================
– 3. OVERALL SALES PERFORMANCE
– Business question: What are the overall sales metrics?
– ============================================================

SELECT
COUNT(*) AS total_transactions,
SUM(total_sale) AS total_revenue,
SUM(quantity) AS total_units_sold,
ROUND(AVG(total_sale), 2) AS average_transaction_value,
MIN(total_sale) AS smallest_sale,
MAX(total_sale) AS largest_sale
FROM sql_project_p1.retail_sales;

– ============================================================
– 4. CATEGORY-WISE SALES ANALYSIS
– Business question: Which categories generate the most revenue?
– ============================================================

SELECT
category,
COUNT(*) AS total_transactions,
SUM(quantity) AS total_units_sold,
SUM(total_sale) AS total_revenue,
ROUND(AVG(total_sale), 2) AS average_sale
FROM sql_project_p1.retail_sales
GROUP BY category
ORDER BY total_revenue DESC;

– ============================================================
– 5. MONTHLY REVENUE ANALYSIS
– Business question: How does revenue change by month?
– ============================================================

SELECT
DATE_FORMAT(sale_date, ‘%Y-%m’) AS sales_month,
COUNT(*) AS total_transactions,
SUM(quantity) AS total_units_sold,
SUM(total_sale) AS monthly_revenue
FROM sql_project_p1.retail_sales
GROUP BY DATE_FORMAT(sale_date, ‘%Y-%m’)
ORDER BY sales_month;

– ============================================================
– 6. HIGHEST-REVENUE MONTH
– Business question: Which month generated the most revenue?
– ============================================================

SELECT
DATE_FORMAT(sale_date, ‘%Y-%m’) AS sales_month,
COUNT(*) AS total_transactions,
SUM(total_sale) AS monthly_revenue
FROM sql_project_p1.retail_sales
GROUP BY DATE_FORMAT(sale_date, ‘%Y-%m’)
ORDER BY monthly_revenue DESC
LIMIT 1;

– ============================================================
– 7. TOP 10 CUSTOMERS BY REVENUE
– Business question: Which customers generate the most revenue?
– ============================================================

SELECT
customer_id,
COUNT(*) AS total_transactions,
SUM(quantity) AS total_units_purchased,
SUM(total_sale) AS total_revenue
FROM sql_project_p1.retail_sales
GROUP BY customer_id
ORDER BY total_revenue DESC
LIMIT 10;

– ============================================================
– 8. FILTER HIGH-VALUE TRANSACTIONS
– Business question: Which transactions exceeded 1,000?
– ============================================================

SELECT
transactions_id,
sale_date,
category,
quantity,
total_sale
FROM sql_project_p1.retail_sales
WHERE total_sale > 1000
ORDER BY total_sale DESC;

– ============================================================
– 9. CATEGORIES WITH REVENUE ABOVE 300,000
– Business question: Which categories exceed the threshold?
– ============================================================

SELECT
category,
SUM(total_sale) AS total_revenue,
COUNT(*) AS total_transactions
FROM sql_project_p1.retail_sales
GROUP BY category
HAVING SUM(total_sale) > 300000
ORDER BY total_revenue DESC;

– ============================================================
– 10. DATA QUALITY: CHECK MISSING VALUES
– Business question: Are key fields missing values?
– ============================================================

SELECT
COUNT(*) AS total_records,
SUM(CASE WHEN transactions_id IS NULL THEN 1 ELSE 0 END)
AS missing_transaction_ids,
SUM(CASE WHEN sale_date IS NULL THEN 1 ELSE 0 END)
AS missing_dates,
SUM(CASE WHEN category IS NULL THEN 1 ELSE 0 END)
AS missing_categories,
SUM(CASE WHEN quantity IS NULL THEN 1 ELSE 0 END)
AS missing_quantities,
SUM(CASE WHEN total_sale IS NULL THEN 1 ELSE 0 END)
AS missing_sales
FROM sql_project_p1.retail_sales;

– ============================================================
– 11. DUPLICATE TRANSACTION ID CHECK
– Business question: Are any transaction IDs repeated?
– ============================================================

SELECT
transactions_id,
COUNT() AS occurrence_count
FROM sql_project_p1.retail_sales
GROUP BY transactions_id
HAVING COUNT() > 1
ORDER BY occurrence_count DESC;

– ============================================================
– 12. CHECK INVALID OR NON-POSITIVE SALES VALUES
– Business question: Are quantities or sales amounts zero
– or negative?
– ============================================================

SELECT *
FROM sql_project_p1.retail_sales
WHERE quantity <= 0
OR total_sale <= 0
ORDER BY transactions_id;

– ============================================================
– 13. REVENUE BY GENDER
– Business question: How does recorded revenue vary by gender?
– ============================================================

SELECT
gender,
COUNT(*) AS total_transactions,
SUM(quantity) AS total_units_sold,
SUM(total_sale) AS total_revenue
FROM sql_project_p1.retail_sales
GROUP BY gender
ORDER BY total_revenue DESC;

– ============================================================
– 14. YEARLY SALES ANALYSIS
– Business question: How much revenue was generated each year?
– ============================================================

SELECT
YEAR(sale_date) AS sales_year,
COUNT(*) AS total_transactions,
SUM(quantity) AS total_units_sold,
SUM(total_sale) AS yearly_revenue
FROM sql_project_p1.retail_sales
GROUP BY YEAR(sale_date)
ORDER BY sales_year;

– ============================================================
– 15. SALES VALUE CLASSIFICATION USING CASE
– Business question: How many transactions fall into each
– sales-value category?
– ============================================================

SELECT
CASE
WHEN total_sale >= 1000 THEN ‘High Value’
WHEN total_sale >= 500 THEN ‘Medium Value’
ELSE ‘Low Value’
END AS sales_category,
COUNT(*) AS total_transactions,
SUM(total_sale) AS total_revenue
FROM sql_project_p1.retail_sales
GROUP BY
CASE
WHEN total_sale >= 1000 THEN ‘High Value’
WHEN total_sale >= 500 THEN ‘Medium Value’
ELSE ‘Low Value’
END
ORDER BY total_revenue DESC;