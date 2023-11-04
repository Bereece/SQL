/*CREATED BY : Frida A
CREATE DATE :mm/dd/yy
Description : SQL Essential Training
Data: WSDA Music
*/

/*
FILTER NUMNERIC DATA
How many customers purchased two songs at 0.99$ each?
0.99 x 2 = 1.98
*/
SELECT
InvoiceDate,
BillingCountry,
total
FROM
Invoice
WHERE
total = 1.98
ORDER BY 
InvoiceDate

--How many invoices exist between $1.98 and $5.00?
SELECT
InvoiceDate,
BillingCountry,
total
FROM
Invoice
WHERE
total BETWEEN 1.98 AND 5.00

--How many invoices exist 


/*
FILTER TEXT DATABASE
BillingCity = Brussells
*/
SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice

--BillingCity in orlando,brusells or paris

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
BillingCity IN('Brussels','Orlando','Paris')

--BillingCity that starts with letter B

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
BillingCity LIKE 'B%'

-- BillingCity with letter B anywhere in it's name

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
BillingCity LIKE '%B%'

/* FILTER DATE DATA
How are dates stored, timestamps
*/
--How many invoices billed on 2010-05-22 00:00:00

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
InvoiceDate = '2010-05-22 00:00:00'

--DATE FUNCTION

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
DATE(InvoiceDate) = '2010-05-22'

--Invoices billed after 2010-05-22 and have a total less than <$3.00

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
DATE(InvoiceDate)>'2010-05-22' AND total < 3.00
ORDER BY 
InvoiceDate

--BillingCity that starts with P or starts with D

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
BillingCity LIKE 'P%' OR '%D'
ORDER BY 
InvoiceDate

/*
Use PEMDAS or BEDMAS when having multiple criteria.Affects the order of operation
Get invoices that are greater than $1.98 in any City that starts with P or starts with D
*/

SELECT
InvoiceDate,
BillingCity,
total
FROM
Invoice
WHERE
total> 1.98 AND (BillingCity LIKE 'P%' OR BillingCity LIKE '%D')
ORDER BY 
InvoiceDate

/* 
Create sales categories

Baseline Purchase - Between $0.99-$1.99
Low Purchase - Between $2.00-$6.99
Target Purchase - Between $7.00-$15.00
Top Purchase - Above $15.00

*/

SELECT
InvoiceDate,
BillingCity,
total,
CASE
WHEN total<2 THEN 'Baseline Purchase'
WHEN total BETWEEN 2.00 AND 6.99 THEN 'Low Purchase'
WHEN total BETWEEN 7.00 AND 15.00 THEN 'Target Purchase'
ELSE 'Top Purchase'
END AS PurchaseType
FROM
Invoice
ORDER BY 
BillingCity

--Which city account for Top performers

SELECT
InvoiceDate,
BillingCity,
total,
CASE
WHEN total<2 THEN 'Baseline Purchase'
WHEN total BETWEEN 2.00 AND 6.99 THEN 'Low Purchase'
WHEN total BETWEEN 7.00 AND 15.00 THEN 'Target Purchase'
ELSE 'Top Purchase'
END AS PurchaseType
FROM
Invoice
WHERE PurchaseType = 'Top Purchase'
ORDER BY 
BillingCity

