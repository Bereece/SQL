-- sample superstore.csv
-- SQLiteSuperstore

-- WINDOW FUNCTIONS
--RANK()- assigns a rank to every row within a partition of a result test. Great for finding top or bottom N
--PARTITION()- split by column nameSuperstore
-- ORDER BY - rank descending or ascending.

SELECT * FROM Superstore;

-- Top 100
SELECT customer_name, sales,
RANK()
OVER(ORDER BY sales DESC )Sales_Rank
FROM Superstore LIMIT 100;

--Rank by sales. We have duplicate rank number and skipped rank number 38

--DENSE RANK() - like rank, assigns consecutive numbers
SELECT customer_name, sales,
DENSE_RANK()
OVER(ORDER BY sales DESC) Dense_Rank
from Superstore LIMIT 100;

--DENSE_RANK still has duplicates

--ROW_NUMBER() - assigns a unique number,no duplicates
SELECT customer_name,sales,
ROW_NUMBER()
OVER(ORDER BY sales DESC) Sales_rank
FROM Superstore LIMIT 100;

--What is the highest sales for each customer?
-- Rank all customers
SELECT customer_name, sales,
ROW_NUMBER()
OVER(PARTITION BY customer_name ORDER BY sales DESC) Sales_rank
from Superstore limit 100;

--Next
SELECT * 
from (SELECT customer_name, sales,
ROW_NUMBER()
OVER(PARTITION BY customer_name ORDER BY Sales DESC) Sales_rank
from Superstore) a
where Sales_rank = 1 
ORDER BY sales DESC;

--VIEWS - store complex queries in the database. Restrict access to some users(security)
CREATE VIEW top_sales
as
SELECT a.customer_name,a.sales 
from (SELECT customer_name, sales,
ROW_NUMBER()
OVER(PARTITION BY customer_name ORDER BY Sales DESC) Sales_rank
from Superstore) a
where Sales_rank = 1 
ORDER BY sales DESC;

-- Run our view
SELECT * from top_sales;

--What are the top five sub-categories based on sum of sales?
SELECT * FROM Superstore;

SELECT COUNT(DISTINCT `sub-category`) FROM Superstore;

SELECT `sub-category`,SUM(sales) Total_sales
FROM Superstore
GROUP BY `sub-category`
ORDER BY Total_sales DESC
LIMIT 5;

--Use window function
SELECT *,
ROW_NUMBER()
OVER(ORDER BY Total_sales DESC) Sales_rank
FROM
(SELECT `sub-category`,SUM(sales) Total_sales
FROM Superstore
GROUP BY `sub-category`) a

