-- Joins (Intermediate level)

SELECT *
FROM employee_demographics
;

-- id, first- and second name, age, gender & birthdate

SELECT *
FROM employee_salary
;

-- id, first- and second name, occupation, salary & dept_id

SELECT dem.employee_id, dem.first_name, gender
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- we can show columns from two tables if we do inner join, same name columns needs to be defined before quereing

-- Outer Join

SELECT *
FROM employee_demographics AS dem
LEFT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

SELECT *
FROM employee_demographics AS dem
RIGHT JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
;

-- We can also join multiple tables together as shown below

SELECT *
FROM employee_demographics AS dem
INNER JOIN employee_salary AS sal
	ON dem.employee_id = sal.employee_id
INNER JOIN parks_departments AS pd
	ON pd.department_id = sal.dept_id
;


