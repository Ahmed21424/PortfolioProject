-- Limit & Aliasing

SELECT * 
FROM employee_demographics
ORDER BY age DESC
LIMIT 3 -- top 3 oldest employees by combining the clauses
;

-- We can combine LIMIT with ORDER BY to get important insights



SELECT * 
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 1
;

-- we basically take the person UNDER (-1) the second row


SELECT gender, AVG(age) AS avg_age, MAX(age)
FROM employee_demographics
GROUP BY gender 
HAVING avg_age > 40
;

SELECT gender, AVG(age) avg_age, MAX(age)
FROM employee_demographics
GROUP BY gender 
HAVING avg_age > 40
;

-- Use of Aliasing, we dont need to write out AS though