# Analysis of Depression and Risk Factors in Students

## Executive Summary 

This project analyzes factors associated with depression among student using a dataset of over 27000 observations. The objective was to explore how variables such as academic pressure, lifestyle habits, financial stress and psychological factors relate to depression outcomes and to build a composite risk score that helps identify students with a high likelihood of depression.

The analysis combines tools such as Excel, SQL, python and Tableau for data cleaning, analysis and visualization. Results indicate strong relationships between depression and variables such as academic pressure, financial stress, sleep duration, dietary habits and other psychological factors. Students with high composite risk scores show more than double the presence of depression than those with low risk and the former are present in ~30% of the dataset population.

Relevant links:

- [Kaggle Dataset](https://www.kaggle.com/datasets/adilshamim8/student-depression-dataset/data)

- [SQL Queries](data_cleaning.sql)

- [Jupyter Notebook](data_analysis.ipynb)

- [Dashboard](https://public.tableau.com/app/profile/juan.pablo.alvarez5922/viz/StudentDepressionAnalysis_17733491205650/Overview)


## Analytical Questions

The project aims to answer the following questions:

1. How prevalent is depression among students in the dataset?
2. Does depression vary across demographic characteristics such as gender or age group?
3. What academic factors are associated with higher depression levels?
4. Do lifestyle habits correlate with depression outcomes?
5. What role do psychological indicators such as suicidal thoughts or family mental health history play?
6. Can a combined risk score be constructed to help us identify which students are at a higher risk of depression?

## Dataset overview
The dataset is composed of 27901 rows of data with 18 columns with the following structure:

| No | Field | Type | Description |
| -- | -- | -- | -- |
| 1 | student_id | Integer | Unique identifier assigned to each student |
| 2 | gender | String | Gender of the student (Male/Female) |
| 3 | age | Integer | Age of the student |
| 4 | city | String | City or region where the student resides |
| 5 | profession | String | Field of work or study of the student |
| 6 | academic_pressure | Integer | Measure indicating the level of pressure the student faces in academic settings |
| 7 | work_pressure | Integer | Measure of the pressure related to work or job responsibilities |
| 8 | cgpa | Float | Cumulative grade point average of the student |
| 9 | student_satisfaction | Integer | Indicator of how satisfied the students are with their studies |
| 10 | job_satisfaction | Integer | Measure of how satisfied the students are with their job or work environment |
| 11 | sleep_duration | String | Average number of hours the student sleeps per day |
| 12 | dietary_habits | String | Assessment of the student’s eating patterns and nutritional habits |
| 13 | student_degree | String | Academic degree or program that the student is pursuing |
| 14 | suicidal_thoughts | String | Binary indicator (Yes/No) that reflects whether the student has ever experienced suicidal ideation |
| 15 | study_work_hours | Integer | Average number of hours per day the student dedicates to work or study |
| 16 | financial_stress | Integer | Measure of the stress experienced due to financial concerns |
| 17 | family_mental_history| String | Indicates whether there is a family history of mental illness (Yes/No) |
| 18 | depression | Integer | Target variable that indicates whether the student is experiencing depression (Yes = 1/No = 0) |

## Limitations And Assupmtions
### Limitations
- The dataset is observational and does not imply causal relationships.
- Psychological variables such as suicidal thoughts may be self-reported and subject to bias.
- The variable suicidal thoughts does not specify whether the student experience these thoughts at a daily, weekly, monthly bases or just once in their life.
- There are not socioeconomic or institutional environment factors within the dataset.
- There are not variables within the dataset that express if the student has experience depression before in their life, to what frequency have they experience it or whether they sought help.
- Some variables contain categorical groupings (e.g. sleep_duration or dietary_habits) that limit precision.

### Assumptions
- Inconsistent values in numerical fields were replace with the mean of the whole field.
- The composite risk score assumes equal contribution from each included factor.
- Only students with the 'profession' value of 'student' were kept into consideration. These student represent 99% of the dataset.

## Tools Used

The analysis was conducted using the following tools:

- Excel - Initial data exploration and Null values handling
- PostgreSQL - Data storage
- Visual Studio Code - Main workspace for queries and coding
- SQL - secondary data exploration and cleaning
- Python - Data analysis and feature engineering
- Tableau - Interactive dashboard creation and visualization
- GitHub – Project version control and documentation

## Cleaning Process

This process took place with the use of SQL in Visual Studio Code.

Key steps:
- Converted values of '?' in the financial_stress column to the field mean of 3
- Checked for duplicates and null values within all fields, no duplicates nor null values were found
- Created a new table (student_survey_clean) with the following fields:

```sql
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
```
- The Field 'city' was not taken into consideration for the new table as it contained a good amount of inconsistent values.

![Inconsistent city values](assets/inconsistent%20city%20values.png)

- Fields related to 'work' (e.g., 'work_pressure', 'job_satisfaction') were not taken into consideration 

-Created a new field with ranges for the 'cgpa' field to simplify the analysis and visualization process

```sql
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
```

## Analysis
