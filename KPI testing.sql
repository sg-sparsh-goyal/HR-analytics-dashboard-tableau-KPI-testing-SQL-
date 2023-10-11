** KPI Testing **

-- Employee Count
SELECT SUM(employee_count) AS Employee_Count
FROM hrdata

-- Attrition Count
SELECT COUNT(attrition)
FROM hrdata
WHERE attrition = 'Yes'

-- Atrrition Rate
select ROUND(((select CAST(count(attrition) AS NUMERIC) from hrdata where attrition='Yes')/ 
SUM(employee_count))*100, 2) from hrdata

-- Active Employees
SELECT SUM(employee_count) - (SELECT COUNT(attrition) FROM hrdata WHERE attrition = 'Yes')
FROM hrdata   

-- Average Age
SELECT ROUND(AVG(age))
FROM hrdata

-- Attrition By Gender
select gender, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by gender
order by count(attrition) desc

-- Department Wise Attrition
select department, count(attrition), ROUND((cast (count(attrition) as numeric) / 
(select count(attrition) from hrdata where attrition= 'Yes')) * 100, 2) as perc_of_tot from hrdata
where attrition='Yes'
group by department 
order by count(attrition) desc

-- No of Employee by Age 
SELECT age, SUM(employee_count)
FROM hrdata
GROUP BY age
ORDER BY age

-- Education Field wise Attrition
select education_field, count(attrition) as attrition_count from hrdata
where attrition='Yes'
group by education_field
order by count(attrition) desc

-- Attrition Rate by Gender for different Age Group
select age_band, gender, count(attrition) as attrition, 
round((cast(count(attrition) as numeric) / (select count(attrition) from hrdata where attrition = 'Yes')) * 100,2) as perc_of_tot
from hrdata
where attrition = 'Yes'
group by age_band, gender
order by age_band, gender DESC

-- Job Satisfaction Rating
CREATE EXTENSION IF NOT EXISTS tablefunc;

SELECT *
FROM crosstab(
  ' SELECT job_role, job_satisfaction, sum(employee_count)
   FROM hrdata
   GROUP BY job_role, job_satisfaction
   ORDER BY job_role, job_satisfaction '
	) AS ct(job_role VARCHAR(50), one int8, two int8, three int8, four int8)
ORDER BY job_role







