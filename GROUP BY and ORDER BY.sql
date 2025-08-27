-- ORDER BY and GROUP BY

SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender
;

-- Just playing around with the GROUP BY and ORDER BY clause

SELECT occupation, salary
FROM employee_salary
GROUP BY occupation, salary
;

SELECT *
FROM employee_demographics
ORDER BY first_name DESC
;


SELECT *
FROM employee_demographics
ORDER BY gender DESC, age DESC
;

-- Can not order by age first since it will not take into account the gender unless everyone is the same age!

SELECT *
FROM employee_demographics
ORDER BY 5 DESC, 4 DESC
;

-- we can also use the number corresponding to the column, it isnt best practice though