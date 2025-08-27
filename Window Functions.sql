-- Window Functions

SELECT gender, AVG(salary) AS avg_sal
FROM employee_demographics AS dem
JOIN employee_salary AS sal
ON dem.employee_id = sal.employee_id
GROUP BY gender 
;

SELECT gender, AVG(salary) OVER (PARTITION BY gender)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
ON dem.employee_id = sal.employee_id
;




SELECT dem.employee_id, dem.first_name, dem.last_name, gender, sal.salary, 
ROW_NUMBER() OVER (partition by gender)
FROM employee_demographics AS dem
JOIN employee_salary AS sal
ON dem.employee_id = sal.employee_id
;





