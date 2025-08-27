-- Unions

SELECT first_name, last_name, "Old man" AS Label
FROM employee_demographics
WHERE age > 40 AND gender = "Male"
UNION
SELECT first_name, last_name, "Old woman" AS Label
FROM employee_demographics
WHERE age > 40 AND gender = "Female"
UNION
SELECT first_name, last_name, "Highly Paid Employee" AS label
FROM employee_salary
WHERE salary > 60000
ORDER BY first_name, last_name
;

-- a big example of how to use unions