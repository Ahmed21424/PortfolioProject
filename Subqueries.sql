-- Subqueries

SELECT *
FROM employee_demographics
WHERE employee_id IN 
					(SELECT employee_id
						FROM employee_salary
						  WHERE dept_id = 1)
;


SELECT *
FROM employee_salary;