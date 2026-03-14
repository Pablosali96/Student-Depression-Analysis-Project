--Total number of rows
SELECT
    COUNT(*)
FROM student_depression;

SELECT
    *
FROM student_depression
LIMIT 5;

--Checking for duplicate student id values
SELECT student_id, COUNT(*)
FROM student_depression
GROUP BY student_id
HAVING COUNT(*) > 1;

--Counting null values throughout the columns
SELECT
    COUNT(*) - COUNT(student_id) as count_id,
    COUNT(*) - COUNT(gender) as count_gender,
    COUNT(*) - COUNT(age) as count_age,
    COUNT(*) - COUNT(city) as count_city,
    COUNT(*) - COUNT(profession) as count_profession,
    COUNT(*) - COUNT(academic_pressure) as count_academic_pressure,
    COUNT(*) - COUNT(work_pressure) as count_work_pressure,
    COUNT(*) - COUNT(cgpa) as count_cgpa,
    COUNT(*) - COUNT(student_satisfaction) as count_student_satisfaction,
    COUNT(*) - COUNT(job_satisfaction) as count_job_satisfaction,
    COUNT(*) - COUNT(sleep_duration) as count_sleep_duration,
    COUNT(*) - COUNT(dietary_habits) as count_dietary_habits,
    COUNT(*) - COUNT(student_degree) as count_student_degree,
    COUNT(*) - COUNT(suicidal_thoughts) as count_suicidal_thoughts,
    COUNT(*) - COUNT(financial_stress) as count_financial_stress,
    COUNT(*) - COUNT(family_mental_history) as count_family_history,
    COUNT(*) - COUNT(depression) as count_depression
FROM student_depression;

--Checking categorical values for inconsistencies
SELECT DISTINCT
    gender
FROM student_depression;

SELECT DISTINCT
    city,
    COUNT(*)
FROM student_depression
GROUP BY 1;
--a lot of inconsistent values in the city field

SELECT DISTINCT
    profession
FROM student_depression;
--Some professions have extra '' at the beginning and end

SELECT DISTINCT
    sleep_duration
FROM student_depression;
--No inconsistencies

SELECT DISTINCT
    dietary_habits
FROM student_depression;
--No inconsistencies

SELECT DISTINCT
    student_degree
FROM student_depression;
/*Need to check the meaning of all the acronyms
If possible, change them*/

SELECT DISTINCT
    suicidal_thoughts
FROM student_depression;
--No inconsistencies

SELECT DISTINCT
    family_mental_history
FROM student_depression;
--No inconsistencies

SELECT DISTINCT
    profession,
    COUNT(*) as count_cgpa,
    (COUNT(*) *100 / SUM(COUNT(*)) OVER()) as percentage_total
FROM student_depression
GROUP BY 1;
--Almost all of the data in this field comes from 'student'

SELECT
    MIN(cgpa),
    MAX(cgpa)
FROM student_depression


SELECT 
    profession,
    COUNT(*) as count_professions,
    AVG(age) as avg_age,
    AVG(academic_pressure) as avg_academic_pressure,
    AVG(work_pressure) as avg_work_pressure,
    AVG(cgpa) as avg_cgpa,
    AVG(student_satisfaction) as avg_satisfaction,
    AVG( study_work_hours) as avg_study_hours
FROM student_depression
WHERE profession != 'Student'
GROUP BY profession;

/*Dropping cities as there is a lot on inconsistencies, 
profession also dropped as we are focussing on students,
work related fields dropped as we will focus on students*/
CREATE TABLE student_survey_clean AS
SELECT
    student_id,
    gender,
    age,
    academic_pressure,
    cgpa,
    student_satisfaction,
    sleep_duration,
    dietary_habits,
    student_degree,
    suicidal_thoughts,
    study_work_hours as study_hours,
    financial_stress,
    family_mental_history,
    depression
FROM student_depression
WHERE profession = 'Student';

ALTER TABLE student_survey_clean
ADD column cgpa_range TEXT;

UPDATE student_survey_clean
SET cgpa_range =
CASE 
    WHEN cgpa <1 THEN 'Below 1'
    WHEN cgpa BETWEEN 1 AND 2 THEN '1-2'
    WHEN cgpa BETWEEN 2 AND 3 THEN '2-3'
    WHEN cgpa BETWEEN 3 AND 4 THEN '3-4'
    WHEN cgpa BETWEEN 4 AND 5 THEN '4-5'
    WHEN cgpa BETWEEN 5 AND 6 THEN '5-6'
    WHEN cgpa BETWEEN 6 AND 7 THEN '6-7'
    WHEN cgpa BETWEEN 7 AND 8 THEN '7-8'
    WHEN cgpa BETWEEN 8 AND 9 THEN '8-9'
    ELSE '9-10'
END;

SELECT DISTINCT
    academic_pressure
FROM student_survey_clean;