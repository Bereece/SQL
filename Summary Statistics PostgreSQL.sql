-- SUMMARY STATISTICS BY GROUPING ROWS

-- DATA (https://raw.githubusercontent.com/pthom/northwind_psql/master/northwind.sql)
-- View columns in products table

SELECT *
from products

-- Aggregations

SELECT products.category_id, COUNT(*) as Num_Products,
AVG(unit_price) as Average_Price,
MAX(unit_price) as Max_Price,
MIN(unit_price) AS Min_Price
from products
GROUP by products.category_id

-- Aggregation for booleans
SELECT products.discontinued, count(*)
from products
GROUP by  products.discontinued

-- Does each row show the same boolean status?
--bool_and -true if all input values are true, otherwise false
--bool_or - true if at least one input value is true, otherwise false

SELECT products.category_id,
COUNT(*), 
bool_and(CAST(discontinued as BOOL)),
bool_or(CAST(discontinued as BOOL))
from products
GROUP by products.category_id

--ROLLUP- extension for GROUP BY
-- Subtotals anfd grand totals

SELECT products.category_id, products.product_name,
COUNT(*) as Num_Products,
AVG(unit_price) as Average_Price,
MAX(unit_price) as Max_Price,
MIN(unit_price) AS Min_Price
from products
GROUP by ROLLUP(products.category_id, products.product_name)
ORDER BY products.category_id, products.product_name

--