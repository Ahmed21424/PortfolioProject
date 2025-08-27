-- Case Statements

SELECT first_name, last_name, age, 
CASE
	WHEN age <= 30 THEN "Young employee"
    WHEN age BETWEEN 31 AND 50 THEN "Middle aged"
    WHEN age BETWEEN 51 AND 70 THEN "Old"
    WHEN age BETWEEN 71 AND 100000500 THEN "Get out!"
END AS Age_Bracket
FROM employee_demographics
;

-- Some CASE statements done on the employees



SELECT first_name, last_name, salary, 
CASE
    WHEN salary = 50000 THEN "Making 50000 a year, pretty good"
    ELSE "not 50000"
END AS specific_salary
FROM employee_salary;





SELECT first_name, last_name, salary,
	CASE
		WHEN salary < 50000 THEN salary * 1.05
		WHEN salary > 50000 THEN salary * 1.07
        ELSE salary
END AS New_Salary,    
	CASE
		WHEN dept_id = 6 THEN salary * .10 -- important that its 10% and not 110%, its only bonus
END AS Bonus
FROM employee_salary;



SELECT * 
from employee_salary sal
INNer join parks_departments AS park
	ON sal.dept_id = park.department_id
;

-- doing inner join to figure out which department id matches department name with employee names shown as well

