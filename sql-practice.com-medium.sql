-- Source:https://www.sql-practice.com/

-- Q.1 Show unique birth years from patients and order them by ascending.

SELECT DISTINCT(YEAR(birth_date)) AS birth_year
FROM patients
ORDER BY birth_year;

-- Q.2 Show unique first names from the patients table which only occurs once in the list.
-- For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.

SELECT first_name
FROM patients
GROUP BYfirst_name
HAVING COUNT(first_name) = 1;

-- Alternative solution

SELECT first_name
FROM (
    SELECT
      first_name,
      count(first_name) AS occurrencies
    FROM patients
    GROUP BY first_name
  )
WHERE occurrencies = 1

-- Q.3 Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.

SELECT patient_id,first_name 
FROM patients
WHERE first_name like 'S____%S';

-- Q.4 Show patient_id, first_name, last_name from patients whos primary_diagnosis is 'Dementia'.

Primary diagnosis is stored in the admissions table.

SELECT patients.patient_id,first_name,last_name
FROM patients 
JOIN admissions 
ON patients.patient_id = admissions.patient_id
WHERE primary_diagnosis = 'Dementia';

-- Q.5 Display every patient's first_name. Order the list by the length of each name and then by alphabetically

SELECT first_name
FROM patients
ORDER BY LEN(first_name),first_name;

-- Q.6 how the total amount of male patients and the total amount of female patients in the patients table. Display the two results in the same row.

SELECT
(select COUNT(*) FROM patients WHERE gender = 'F') female_count, 
(select COUNT(*) FROM patients WHERE gender = 'M') male_count;

-- Alternative solution

SELECT 
  SUM(Gender = 'M') as male_count, 
  SUM(Gender = 'F') AS female_count
FROM patients


SELECT 
  SUM(case WHEN gender = 'M' THEN 1 END) as male_count,
  SUM(case WHEN gender = 'F' THEN 1 END) as female_count 
FROM patients;


-- Q.7  Show first and last name, allergies from patients who have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.

SELECT first_name,last_name,allergies
FROM patients
WHERE allergies IN ('Penicillin','Morphine')
ORDER BY allergies , first_name,last_name;


--  Q.8 Show patient_id, primary_diagnosis from admissions. Find patients admitted multiple times for the same primary_diagnosis.

SELECT patient_id,primary_diagnosis 
FROM admissions
GROUP BY patient_id,primary_diagnosis
HAVING COUNT(primary_diagnosis) > 1;

-- Q.9  Show the city and the total number of patients in the city in the order from most to least patients.

SELECT city,COUNT(patient_id) total_patients
FROM patients
GROUP BY city
ORDER BY total_patients DESC;

-- Q.10  Show first name, last name and role of every person that is either patient or physician. The roles are either "Patient" or "Physician"

SELECT first_name,last_name,'patient' AS role  
FROM patients
UNION 
SELECT first_name,last_name,'physician' AS role 
FROM physicians;


-- Q.11 Show all allergies ordered by popularity. Remove 'NKA' and NULL values from query. 


SELECT allergies,count(allergies) total_allergies
FROM patients
WHERE allergies IS NOT NULL
AND allergies is NOT 'NKA'
GROUP BY allergies
order by total_allergies desc;

-- Alternative solutions

SELECT
  allergies,
  count(*)
FROM patients
WHERE allergies NOT IN ('NKA', 'NULL')
GROUP BY allergies
ORDER BY count(*) DESC;


SELECT
  allergies,
  COUNT(*) AS total_diagnosis
FROM patients
WHERE
  NOT allergies = 'NKA'
  AND allergies NOT NULL
GROUP BY allergies
ORDER BY total_diagnosis DESC


SELECT
  allergies,
  count(allergies) AS total_diagnosis
FROM patients
GROUP BY allergies
HAVING
  allergies IS NOT NULL
  AND allergies IS NOT 'NKA'
ORDER BY total_diagnosis DESC


-- Q.12 Show all patient's first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.

SELECT first_name,last_name,birth_date
FROM patients
WHERE YEAR(birth_date) BETWEEN 1970 AND 1979
ORDER BY birth_date;

-- Alternative solutions

SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE
  birth_date >= '1970-01-01'
  AND birth_date < '1980-01-01'
ORDER BY birth_date ASC


SELECT
  first_name,
  last_name,
  birth_date
FROM patients
WHERE year(birth_date) LIKE '197%'
ORDER BY birth_date ASC


-- Q.13 We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
EX: SMITH,jane

SELECT CONCAT(UPPER(last_name),',',LOWER(first_name)) full_names
FROM patients
ORDER BY first_name desc;

--Alternate solutions

SELECT
  UPPER(last_name) || ',' || LOWER(first_name) AS new_name_format
FROM patients
ORDER BY first_name DESC;

-- Q.14  Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.

SELECT province_id,SUM(height)
FROM patients
group by province_id
HAVING sum(height) >= 7000;

SELECT
  province_id,
  SUM(height) AS sum_height
FROM patients
GROUP BY province_id
HAVING sum_height >= 7000

-- Q.15  Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'

SELECT (MAX(weight)-MIN(weight))AS weight_diff
from patients
where last_name = 'Maroni';

-- Q.16 Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.

SELECT DAY(admission_date) day_ ,COUNT(DAY(admission_date)) admission_count
from admissions
group by day_
ORDER BY admission_count  desc;

--Alternate solution

SELECT
  DAY(admission_date) AS day_number,
  COUNT(*) AS number_of_admissions
FROM admissions
GROUP BY day_number
ORDER BY number_of_admissions DESC


-- Q.17 Show the patient_id, nursing_unit_id, room, and bed for patient_id 542's most recent admission_date.


SELECT patient_id, nursing_unit_id, room, bed 
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING MAX(admission_date);

-- Alternate solution


SELECT
  patient_id,
  nursing_unit_id,
  room,
  bed
FROM admissions
WHERE patient_id = 542
GROUP BY patient_id
HAVING
  admission_date = MAX(admission_date);

SELECT
  patient_id,
  nursing_unit_id,
  room,
  bed
FROM admissions
WHERE
  patient_id = '542'
  AND admission_date = (
    SELECT MAX(admission_date)
    FROM admissions
    WHERE patient_id = '542'
  )

SELECT
  patient_id,
  nursing_unit_id,
  room,
  bed
FROM admissions
WHERE patient_id = 542
ORDER BY admission_date DESC
LIMIT 1

SELECT
  patient_id,
  nursing_unit_id,
  room,
  bed
FROM admissions
GROUP BY patient_id
HAVING
  patient_id = 542
  AND max(admission_date)


-- Q.18 Show the nursing_unit_id and count of admissions for each nursing_unit_id. Exclude the following nursing_unit_ids: 'CCU', 'OR', 'ICU', 'ER'.

SELECT nursing_unit_id,count(*) AS admissions_count
FROM admissions
WHERE nursing_unit_id NOT IN('CCU', 'OR', 'ICU', 'ER')
group by nursing_unit_id;

-- Alternate solution

SELECT
  nursing_unit_id,
  count(*) count_of_admissions
FROM admissions
GROUP BY nursing_unit_id
HAVING
  nursing_unit_id NOT IN ('CCU', 'OR', 'ICU', 'ER');


-- Q.19 Show patient_id, attending_physician_id, and primary_diagnosis for admissions that match one of the two criteria:
1. patient_id is an odd number and attending_physician_id is either 1, 5, or 19.
2. attending_physician_id contains a 2 and the length of patient_id is 3 characters.













