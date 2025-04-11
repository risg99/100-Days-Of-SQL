-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Oracle(Hard Level) #SQL Interview Question — Solution
-- Write a query that compares each employee's salary to their manager's and the average 
-- department salary (excluding the manager's salary). Display the department, employee ID,
-- employee's salary, manager's salary, and department average salary. Order by department, 
-- then by employee salary (highest to lowest).

-- Database setup:
CREATE TABLE EMPLOYEE_O (
	ID INT PRIMARY KEY,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	AGE INT,
	GENDER VARCHAR(10),
	EMPLOYEE_TITLE VARCHAR(50),
	DEPARTMENT VARCHAR(50),
	SALARY INT,
	MANAGER_ID INT
);

INSERT INTO
	EMPLOYEE_O (
		ID,
		FIRST_NAME,
		LAST_NAME,
		AGE,
		GENDER,
		EMPLOYEE_TITLE,
		DEPARTMENT,
		SALARY,
		MANAGER_ID
	)
VALUES
	(
		1,
		'Alice',
		'Smith',
		45,
		'F',
		'Manager',
		'HR',
		9000,
		1
	),
	(
		2,
		'Bob',
		'Johnson',
		34,
		'M',
		'Assistant',
		'HR',
		4500,
		1
	),
	(
		3,
		'Charlie',
		'Williams',
		28,
		'M',
		'Coordinator',
		'HR',
		4800,
		1
	),
	(
		4,
		'Diana',
		'Brown',
		32,
		'F',
		'Manager',
		'IT',
		12000,
		4
	),
	(
		5,
		'Eve',
		'Jones',
		27,
		'F',
		'Analyst',
		'IT',
		7000,
		4
	),
	(
		6,
		'Frank',
		'Garcia',
		29,
		'M',
		'Developer',
		'IT',
		7500,
		4
	),
	(
		7,
		'Grace',
		'Miller',
		30,
		'F',
		'Manager',
		'Finance',
		10000,
		7
	),
	(
		8,
		'Hank',
		'Davis',
		26,
		'M',
		'Analyst',
		'Finance',
		6200,
		7
	),
	(
		9,
		'Ivy',
		'Martinez',
		31,
		'F',
		'Clerk',
		'Finance',
		5900,
		7
	),
	(
		10,
		'John',
		'Lopez',
		36,
		'M',
		'Manager',
		'Marketing',
		11000,
		10
	),
	(
		11,
		'Kim',
		'Gonzales',
		29,
		'F',
		'Specialist',
		'Marketing',
		6800,
		10
	),
	(
		12,
		'Leo',
		'Wilson',
		27,
		'M',
		'Coordinator',
		'Marketing',
		6600,
		10
	);

-- Query:
WITH
	ALL_DEPTS_SALARY AS (
		SELECT
			DEPARTMENT,
			ROUND(AVG(SALARY)) AS AVERAGE_DEPARTMENT_SALARY
		FROM
			EMPLOYEE_O
		WHERE
			EMPLOYEE_TITLE <> 'Manager'
		GROUP BY
			DEPARTMENT
	),
	ALL_MANAGERS_EMPLOYEES AS (
		SELECT
			E.ID AS EMPLOYEE_ID,
			E.SALARY AS EMPLOYEE_SALARY,
			M.SALARY AS MANAGER_SALARY,
			E.DEPARTMENT
		FROM
			EMPLOYEE_O E
			LEFT JOIN EMPLOYEE_O M ON E.MANAGER_ID = M.ID
			AND E.ID <> M.MANAGER_ID
	)
SELECT
	S.DEPARTMENT,
	EMPLOYEE_ID,
	EMPLOYEE_SALARY,
	MANAGER_SALARY,
	AVERAGE_DEPARTMENT_SALARY
FROM
	ALL_MANAGERS_EMPLOYEES M
	JOIN ALL_DEPTS_SALARY S ON S.DEPARTMENT = M.DEPARTMENT
ORDER BY
	S.DEPARTMENT ASC,
	M.EMPLOYEE_SALARY DESC;

-- Reset Database:
DROP TABLE EMPLOYEE_O;