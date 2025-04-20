-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Walmart (Medium Level) #SQL Interview Question — Solution
-- Find employees who are earning more than their managers. Output the employee's
-- first name along with the corresponding salary.

-- Database setup:
CREATE TABLE EMPLOYEE_DETAIL (
	ID BIGINT PRIMARY KEY,
	FIRST_NAME VARCHAR(100),
	LAST_NAME VARCHAR(100),
	ADDRESS VARCHAR(255),
	AGE BIGINT,
	BONUS BIGINT,
	CITY VARCHAR(100),
	DEPARTMENT VARCHAR(100),
	EMAIL VARCHAR(100),
	EMPLOYEE_TITLE VARCHAR(100),
	MANAGER_ID BIGINT,
	SALARY BIGINT,
	SEX VARCHAR(10),
	TARGET BIGINT
);

INSERT INTO
	EMPLOYEE_DETAIL (
		ID,
		FIRST_NAME,
		LAST_NAME,
		ADDRESS,
		AGE,
		BONUS,
		CITY,
		DEPARTMENT,
		EMAIL,
		EMPLOYEE_TITLE,
		MANAGER_ID,
		SALARY,
		SEX,
		TARGET
	)
VALUES
	(
		1,
		'John',
		'Doe',
		'123 Main St',
		45,
		5000,
		'New York',
		'IT',
		'john.doe@example.com',
		'Manager',
		NULL,
		90000,
		'M',
		50000
	),
	(
		2,
		'Jane',
		'Smith',
		'456 Elm St',
		38,
		3000,
		'Los Angeles',
		'IT',
		'jane.smith@example.com',
		'Senior Developer',
		1,
		95000,
		'F',
		60000
	),
	(
		3,
		'Alice',
		'Johnson',
		'789 Oak St',
		30,
		2000,
		'Chicago',
		'HR',
		'alice.johnson@example.com',
		'HR Specialist',
		1,
		80000,
		'F',
		40000
	),
	(
		4,
		'Bob',
		'Brown',
		'321 Pine St',
		40,
		4000,
		'Miami',
		'Finance',
		'bob.brown@example.com',
		'Finance Manager',
		NULL,
		85000,
		'M',
		45000
	),
	(
		5,
		'Charlie',
		'Davis',
		'654 Cedar St',
		28,
		1500,
		'Seattle',
		'Finance',
		'charlie.davis@example.com',
		'Analyst',
		4,
		88000,
		'M',
		55000
	),
	(
		6,
		'Eve',
		'Wilson',
		'987 Maple St',
		35,
		2500,
		'Boston',
		'Marketing',
		'eve.wilson@example.com',
		'Marketing Specialist',
		4,
		84000,
		'F',
		50000
	);

-- Query:
SELECT
	E.FIRST_NAME,
	E.SALARY
FROM
	EMPLOYEE_DETAIL E,
	EMPLOYEE_DETAIL M
WHERE
	E.MANAGER_ID = M.ID
	AND E.SALARY > M.SALARY;

-- Reset Database:
DROP TABLE EMPLOYEE_DETAIL;