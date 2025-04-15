-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Twitter(Hard Level) #SQL Interview Question — Solution
-- Find the top three distinct salaries for each department. Output the
-- department name and the top 3 distinct salaries by each department. 
-- Order your results alphabetically by department and then by highest salary to lowest.

-- Database setup:
CREATE TABLE EMPLOYEES (
	ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	AGE INT,
	SEX VARCHAR(1),
	EMPLOYEE_TITLE VARCHAR(50),
	DEPARTMENT VARCHAR(50),
	SALARY INT,
	TARGET INT,
	BONUS INT,
	CITY VARCHAR(50),
	ADDRESS VARCHAR(50),
	MANAGER_ID INT
);

INSERT INTO
	EMPLOYEES (
		ID,
		FIRST_NAME,
		LAST_NAME,
		AGE,
		SEX,
		EMPLOYEE_TITLE,
		DEPARTMENT,
		SALARY,
		TARGET,
		BONUS,
		CITY,
		ADDRESS,
		MANAGER_ID
	)
VALUES
	(
		1,
		'Allen',
		'Wang',
		55,
		'F',
		'Manager',
		'Management',
		200000,
		0,
		300,
		'California',
		'23St',
		1
	),
	(
		13,
		'Katty',
		'Bond',
		56,
		'F',
		'Manager',
		'Management',
		150000,
		0,
		300,
		'Arizona',
		NULL,
		1
	),
	(
		19,
		'George',
		'Joe',
		50,
		'M',
		'Manager',
		'Management',
		100000,
		0,
		300,
		'Florida',
		'26St',
		1
	),
	(
		11,
		'Richerd',
		'Gear',
		57,
		'M',
		'Manager',
		'Management',
		250000,
		0,
		300,
		'Alabama',
		NULL,
		1
	),
	(
		10,
		'Jennifer',
		'Dion',
		34,
		'F',
		'Sales',
		'Sales',
		100000,
		200,
		150,
		'Alabama',
		NULL,
		13
	),
	(
		18,
		'Laila',
		'Mark',
		26,
		'F',
		'Sales',
		'Sales',
		100000,
		200,
		150,
		'Florida',
		'23St',
		11
	),
	(
		20,
		'Sarrah',
		'Bicky',
		31,
		'F',
		'Senior Sales',
		'Sales',
		200000,
		200,
		150,
		'Florida',
		'53St',
		19
	),
	(
		21,
		'Suzan',
		'Lee',
		34,
		'F',
		'Sales',
		'Sales',
		130000,
		200,
		150,
		'Florida',
		'56St',
		19
	),
	(
		22,
		'Mandy',
		'John',
		31,
		'F',
		'Sales',
		'Sales',
		130000,
		200,
		150,
		'Florida',
		'45St',
		19
	),
	(
		17,
		'Mick',
		'Berry',
		44,
		'M',
		'Senior Sales',
		'Sales',
		220000,
		200,
		150,
		'Florida',
		NULL,
		11
	),
	(
		12,
		'Shandler',
		'Bing',
		23,
		'M',
		'Auditor',
		'Audit',
		110000,
		200,
		150,
		'Arizona',
		NULL,
		11
	),
	(
		14,
		'Jason',
		'Tom',
		23,
		'M',
		'Auditor',
		'Audit',
		100000,
		200,
		150,
		'Arizona',
		NULL,
		11
	),
	(
		16,
		'Celine',
		'Anston',
		27,
		'F',
		'Auditor',
		'Audit',
		100000,
		200,
		150,
		'Colorado',
		NULL,
		11
	),
	(
		15,
		'Michale',
		'Jackson',
		44,
		'F',
		'Auditor',
		'Audit',
		70000,
		150,
		150,
		'Colorado',
		NULL,
		11
	),
	(
		6,
		'Molly',
		'Sam',
		28,
		'F',
		'Sales',
		'Sales',
		140000,
		100,
		150,
		'Arizona',
		'24St',
		13
	),
	(
		7,
		'Nicky',
		'Bat',
		33,
		'F',
		'Sales',
		'Sales',
		NULL,
		NULL,
		NULL,
		NULL,
		NULL,
		NULL
	);

-- Query:
WITH
	ALL_DEPTS_SAL AS (
		SELECT
			DEPARTMENT,
			SALARY,
			DENSE_RANK() OVER (
				PARTITION BY
					DEPARTMENT
				ORDER BY
					SALARY DESC
			) AS RANK
		FROM
			EMPLOYEES
		GROUP BY
			DEPARTMENT,
			SALARY
	)
SELECT
	DEPARTMENT,
	SALARY
FROM
	ALL_DEPTS_SAL
WHERE
	RANK <= 3
	AND SALARY IS NOT NULL
ORDER BY
	DEPARTMENT ASC,
	SALARY DESC;

-- Reset Database:
DROP TABLE EMPLOYEES;