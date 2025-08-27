-- WHERE Clause test with first_name column

SELECT *
FROM employee_salary
WHERE first_name = "Leslie"
;

-- See who has a salary of 50000 or more

SELECT *
FROM employee_salary
WHERE salary >= 50000
;


-- See who has a salary of 50000 or less

SELECT *
FROM employee_salary
WHERE salary <= 50000
;


-- See how many females there are from the employee list

SELECT *
FROM employee_demographics
WHERE gender = "female"
;

-- See how many men there are using the not equal to (!=)

SELECT *
FROM employee_demographics
WHERE gender != "female"
;

-- We can also check whether someone is born after a specific date or not

SELECT *
FROM employee_demographics
WHERE birth_date > "1987-01-01" 
;


-- We can also use the AND operator to spice things up a bit


SELECT *
FROM employee_demographics
WHERE birth_date > "1987-01-01" 
AND gender = "male"
;

-- We use the OR operator to pick out employees that are born after a specific date or are a specific gender

SELECT *
FROM employee_demographics
WHERE birth_date > "1987-01-01" 
OR gender = "male"
;


-- we can likewise use the OR NOT operator which is basically the same thing as != 

SELECT *
FROM employee_demographics
WHERE birth_date > "1985-01-01"
OR gender != "male"
;



SELECT *
FROM employee_demographics
WHERE birth_date > "1965-01-01" AND age = 44
;


-- The operators also follow the PEMDAS rules

SELECT *
FROM employee_demographics
WHERE (gender = "male" AND age > 40) OR last_name = "Knope"
;




-- Like statement 
-- % and _

SELECT *
FROM employee_demographics
WHERE first_name LIKE "a%"
;

SELECT *
FROM employee_demographics
WHERE first_name LIKE "a__"
;



