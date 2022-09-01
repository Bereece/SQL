-- Source : https://www.sql-practice.com/

-- Q.1 Show first name, last name, and gender of patients who's gender is 'M'

SELECT first_name,last_name,gender 
FROM patients
where gender = 'M';

--Q.2 Show first name and last name of patients who does not have allergies (null).
SELECT first_name,last_name 
FROM patients
where allergies IS null;

-- Q.3  Show first name of patients that start with the letter 'C'
SELECT first_name 
FROM patients
where first_name like 'C%';

-- Q.4  Show first name and last name of patients that weight within the range of 100 to 120 (inclusive)
SELECT first_name, last_name 
FROM patients
where weight between 100 AND 120;

-- Q.5  Update the patients table for the allergies column. If the patient's allergies is null then replace it with 'NKA'

UPDATE patients
SET allergies = 'NKA'
WHERE allergies IS NULL;

-- Q.6  Show first name and last name concatinated into one column to show their full name.

SELECT 
CONCAT(first_name,' ',last_name) AS full_name
FROM patients;

-- Q.7 Show first name, last name, and the full province name of each patient.

Example: 'Ontario' instead of 'ON'

SELECT first_name,last_name,province_name
FROM patients
JOIN provinces 
ON patients.province_id = provinces.province_id;


-- Q.8 Show how many patients have a birth_date with 2010 as the birth year.

SELECT COUNT(*)
FROM patients
WHERE YEAR(birth_date) = 2010;

--Alternative solution

SELECT count(first_name) AS total_patients
FROM patients
WHERE
  birth_date >= '2010-01-01'
  AND birth_date <= '2010-12-31'

-- Q.9 Show the first_name, last_name, and height of the patient with the greatest height.

SELECT first_name,last_name,max(height)
FROM patients;

-- Alternate solution

SELECT
  first_name,
  last_name,
  height
FROM patients
WHERE height = (
    SELECT max(height)
    FROM patients
  )

-- Q.10 Show all columns for patients who have one of the following patient_ids:
1,45,534,879,1000

SELECT *
FROM patients
WHERE patient_id IN (1,45,534,879,1000);

-- Q.11 Show the total number of admissions

SELECT count(*) as total_admissions
FROM admissions;

-- Q.12 Show all the columns from admissions where the patient was admitted and discharged on the same day.

SELECT *
FROM admissions
WHERE admission_date = discharge_date;

--Q.13  Show the total number of admissions for patient_id 573.

SELECT patient_id, COUNT(admission_date) AS total_admissions
FROM admissions
WHERE patient_id = 573;

-- Q.14 Based on the cities that our patients live in, show unique cities that are in province_id 'NS'?

SELECT distinct(city) AS unique_cities
FROM patients
WHERE province_id = 'NS';

-- Q.14  Write a query to find the first_name, last name and birth date of patients who have height more than 160 and weight more than 70

SELECT first_name,last_name,birth_date
FROM patients
WHERE height > 160 AND weight > 70;

-- Q.15 Write a query to find list of patients first_name, last_name, and allergies from Hamilton where allergies are not nka or null

SELECT first_name,last_name,allergies
FROM patients
WHERE city = 'Hamilton'
AND allergies IS not NULL
AND allergies is not 'NKA';



