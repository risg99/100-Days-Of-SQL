-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Microsoft (Hard Level) #SQL Interview Question — Solution
-- Find the number of employees who received the bonus and who didn't. Bonus values 
-- in employee table are corrupted so you should use values from the bonus table. 
-- Be aware of the fact that employee can receive more than one bonus. Output value
-- inside has_bonus column (1 if they had bonus, 0 if not) along with the corresponding
-- number of employees for each.

-- Database setup:
CREATE TABLE EMPLOYEE_DETAILS (
	ID BIGINT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	AGE BIGINT,
	SEX VARCHAR(10),
	EMAIL VARCHAR(100),
	ADDRESS VARCHAR(100),
	CITY VARCHAR(50),
	DEPARTMENT VARCHAR(50),
	EMPLOYEE_TITLE VARCHAR(50),
	MANAGER_ID BIGINT,
	SALARY BIGINT,
	TARGET BIGINT,
	BONUS BIGINT
);

INSERT INTO
	EMPLOYEE_DETAILS (
		ID,
		FIRST_NAME,
		LAST_NAME,
		AGE,
		SEX,
		EMAIL,
		ADDRESS,
		CITY,
		DEPARTMENT,
		EMPLOYEE_TITLE,
		MANAGER_ID,
		SALARY,
		TARGET,
		BONUS
	)
VALUES
	(
		1,
		'John',
		'Doe',
		30,
		'Male',
		'john.doe@example.com',
		'123 Elm St',
		'New York',
		'IT',
		'Engineer',
		101,
		70000,
		80000,
		5000
	),
	(
		2,
		'Jane',
		'Smith',
		28,
		'Female',
		'jane.smith@example.com',
		'456 Oak St',
		'Los Angeles',
		'HR',
		'Manager',
		102,
		75000,
		90000,
		NULL
	),
	(
		3,
		'Alice',
		'Johnson',
		35,
		'Female',
		'alice.johnson@example.com',
		'789 Pine St',
		'Chicago',
		'Finance',
		'Analyst',
		103,
		80000,
		95000,
		NULL
	),
	(
		4,
		'Bob',
		'Brown',
		40,
		'Male',
		'bob.brown@example.com',
		'321 Maple St',
		'Boston',
		'IT',
		'Director',
		104,
		120000,
		130000,
		NULL
	),
	(
		5,
		'Charlie',
		'Davis',
		25,
		'Male',
		'charlie.davis@example.com',
		'654 Cedar St',
		'Seattle',
		'Marketing',
		'Specialist',
		105,
		50000,
		60000,
		NULL
	);

CREATE TABLE BONUS (
	WORKER_REF_ID BIGINT,
	BONUS_AMOUNT BIGINT,
	BONUS_DATE DATE
);

INSERT INTO
	BONUS (WORKER_REF_ID, BONUS_AMOUNT, BONUS_DATE)
VALUES
	(1, 5000, '2024-01-15'),
	(1, 3000, '2024-02-20'),
	(3, 2000, '2024-03-10'),
	(5, 1000, '2024-04-05');

-- Query:
WITH
	ALL_EMPLOYEE_BONUS AS (
		SELECT
			ID,
			CASE
				WHEN BONUS_AMOUNT IS NULL THEN 0
				ELSE 1
			END AS HAS_BONUS
		FROM
			EMPLOYEE_DETAILS E
			LEFT JOIN BONUS B ON E.ID = B.WORKER_REF_ID
	)
SELECT
	HAS_BONUS,
	COUNT(*) AS EMPLOYEE_COUNT
FROM
	ALL_EMPLOYEE_BONUS
GROUP BY
	HAS_BONUS;

-- Reset Database:
DROP TABLE EMPLOYEE_DETAILS;
DROP TABLE BONUS;