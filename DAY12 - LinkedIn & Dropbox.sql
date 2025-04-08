-- 𝐇𝐚𝐩𝐩𝐲 𝐃𝐢𝐰𝐚𝐥𝐢🪔 𝐓𝐫𝐲 𝐋𝐚𝐭𝐞𝐫: LinkedIn, Dropbox (Basic Level) #SQL Interview Question — Solution
-- Write a query that calculates the difference between the highest salaries found
-- in the marketing and engineering departments. Output just the absolute difference 
-- in salaries.

-- Database setup:
CREATE TABLE DB_EMPLOYEE (
	ID INT,
	FIRST_NAME VARCHAR(50),
	LAST_NAME VARCHAR(50),
	SALARY INT,
	DEPARTMENT_ID INT
);

INSERT INTO
	DB_EMPLOYEE (ID, FIRST_NAME, LAST_NAME, SALARY, DEPARTMENT_ID)
VALUES
	(10306, 'Ashley', 'Li', 28516, 4),
	(10307, 'Joseph', 'Solomon', 19945, 1),
	(10311, 'Melissa', 'Holmes', 33575, 1),
	(10316, 'Beth', 'Torres', 34902, 1),
	(10317, 'Pamela', 'Rodriguez', 48187, 4),
	(10320, 'Gregory', 'Cook', 22681, 4),
	(10324, 'William', 'Brewer', 15947, 1),
	(10329, 'Christopher', 'Ramos', 37710, 4),
	(10333, 'Jennifer', 'Blankenship', 13433, 4),
	(10339, 'Robert', 'Mills', 13188, 1);

CREATE TABLE DB_DEPT (ID INT, DEPARTMENT VARCHAR(50));

INSERT INTO
	DB_DEPT (ID, DEPARTMENT)
VALUES
	(1, 'engineering'),
	(2, 'human resource'),
	(3, 'operation'),
	(4, 'marketing');

-- Query:
SELECT
	ABS(
		MAX(
			CASE
				WHEN D.DEPARTMENT = 'marketing' THEN E.SALARY
			END
		) - MAX(
			CASE
				WHEN D.DEPARTMENT = 'engineering' THEN E.SALARY
			END
		)
	) AS SALARY_DIFFERENCE
FROM
	DB_EMPLOYEE E,
	DB_DEPT D
WHERE
	E.DEPARTMENT_ID = D.ID;

-- Reset Database:
DROP TABLE DB_EMPLOYEE;
DROP TABLE DB_DEPT;