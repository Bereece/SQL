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







