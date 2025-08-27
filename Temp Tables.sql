-- Temporary Tables

CREATE TEMPORARY TABLE temp_table27
(
first_name varchar(50),
last_name varchar (50),
favorite_movie varchar(100)
)
;	

SELECT *
FROM temp_table27
;

INSERT INTO temp_table27
VALUES("Ahmed", "Mustafa","Al-Risala");

-- Smart way to utilize temp tables


CREATE TEMPORARY TABLE salary_over_61k
SELECT *
FROM employee_salary
WHERE salary > 60000;

SELECT *
FROM salary_over_61k
