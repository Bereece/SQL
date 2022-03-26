-- Show only the top 5 rows from the trading.members table
SELECT * 
from trading.members
limit 5;

--Sort all the rows in the table by first_name in alphabetical order and show the top 3 rows
SELECT *
from trading.members
order by first_name
limit 3;

-- Which records from trading.members are from the United States region?
SELECT *
from trading.members
WHERE region = 'United States';

-- Select only the member_id and first_name columns for members who are not from Australia

select member_id, first_name
from trading.members
where region <> 'Australia';

--Return the unique region values from the trading.members table and sort the output by reverse alphabetical order
SELECT DISTINCT(region)
FROM trading.members
order by region desc;

--How many mentors are there from Australia or the United States?

SELECT count(*) as mentors
from trading.members
WHERE region in('Australia','United States');

--How many mentors are not from Australia or the United States?
SELECT count(*) as mentors
from trading.members
WHERE region not in ('Australia','United States');

--How many mentors are there per region? Sort the output by regions with the most mentors to the least
SELECT  region, count(*) mentors
from trading.members
group by region
ORDER by mentors desc;

--How many US mentors and non US mentors are there?
--To do after further reading
--?????
--How many mentors have a first name starting with a letter before 'E'?


