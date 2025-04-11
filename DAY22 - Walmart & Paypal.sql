-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Walmart, Paypal (Medium Level) #SQL Interview Question — Solution
-- Find managers with at least 7 direct reporting employees. In situations where user is 
-- reporting to himself/herself, count that also. Output first names of managers.

-- Database setup:
CREATE TABLE EMPLOYEES (
	ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	AGE INT,
	SEX VARCHAR(10),
	EMPLOYEE_TITLE VARCHAR(50),
	DEPARTMENT VARCHAR(50),
	SALARY INT,
	TARGET INT,
	BONUS INT,
	EMAIL VARCHAR(100),
	CITY VARCHAR(50),
	ADDRESS VARCHAR(255),
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
		EMAIL,
		CITY,
		ADDRESS,
		MANAGER_ID
	)
VALUES
	(
		1,
		'Alice',
		'Smith',
		40,
		'F',
		'Manager',
		'Sales',
		90000,
		100000,
		15000,
		'alice.smith@example.com',
		'New York',
		'123 Main St',
		1
	),
	(
		2,
		'Bob',
		'Johnson',
		35,
		'M',
		'Team Lead',
		'Sales',
		80000,
		95000,
		12000,
		'bob.johnson@example.com',
		'Chicago',
		'456 Oak St',
		1
	),
	(
		3,
		'Carol',
		'Williams',
		30,
		'F',
		'Sales Executive',
		'Sales',
		70000,
		85000,
		10000,
		'carol.williams@example.com',
		'New York',
		'789 Pine St',
		1
	),
	(
		4,
		'David',
		'Brown',
		28,
		'M',
		'Sales Executive',
		'Sales',
		68000,
		80000,
		9000,
		'david.brown@example.com',
		'Chicago',
		'101 Maple St',
		1
	),
	(
		5,
		'Emma',
		'Jones',
		32,
		'F',
		'Sales Executive',
		'Sales',
		71000,
		86000,
		9500,
		'emma.jones@example.com',
		'New York',
		'202 Cedar St',
		1
	),
	(
		6,
		'Frank',
		'Miller',
		45,
		'M',
		'Manager',
		'Engineering',
		95000,
		105000,
		16000,
		'frank.miller@example.com',
		'San Francisco',
		'303 Spruce St',
		6
	),
	(
		7,
		'Grace',
		'Davis',
		29,
		'F',
		'Engineer',
		'Engineering',
		73000,
		87000,
		11000,
		'grace.davis@example.com',
		'San Francisco',
		'404 Willow St',
		6
	);

-- Query:
SELECT
	M.FIRST_NAME AS MANAGER_FIRST_NAME
FROM
	EMPLOYEES E,
	EMPLOYEES M
WHERE
	E.MANAGER_ID = M.ID
GROUP BY
	M.FIRST_NAME
HAVING
	COUNT(E.ID) >= 7;

-- Reset Database:
DROP TABLE EMPLOYEES;