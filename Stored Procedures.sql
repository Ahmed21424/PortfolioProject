-- Stored Procedures

SELECT *
FROM employee_salary
WHERE salary >= 50000;

CREATE PROCEDURE salaries_50k_or_more ()
SELECT *
FROM employee_salary
WHERE salary >= 50000;

CALL salaries_50k_or_more ();

DELIMITER $$
CREATE PROCEDURE large_salaries()
BEGIN
	SELECT *
	FROM employee_salary
	WHERE salary >= 50000;
	SELECT *
	FROM employee_salary
	WHERE salary >= 10000;
END $$
DELIMITER ;

CALL large_salaries();


DELIMITER $$
CREATE PROCEDURE parameter(p_employee_id int)
BEGIN
	SELECT salary
	FROM employee_salary
	WHERE employee_id = p_employee_id;
END $$
DELIMITER ;

CALL parameter(1);



