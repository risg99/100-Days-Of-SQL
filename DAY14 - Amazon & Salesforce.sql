-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon, Salesforce (Basic Level) #SQL Interview Question — Solution
-- What is the total sales revenue of Samantha and Lisa?

-- Database setup:
CREATE TABLE SALES_PERFORMANCE (
	SALESPERSON VARCHAR(50),
	WIDGET_SALES INT,
	SALES_REVENUE INT,
	ID INT PRIMARY KEY
);

INSERT INTO
	SALES_PERFORMANCE (SALESPERSON, WIDGET_SALES, SALES_REVENUE, ID)
VALUES
	('Jim', 810, 40500, 1),
	('Bobby', 661, 33050, 2),
	('Samantha', 1006, 50300, 3),
	('Taylor', 984, 49200, 4),
	('Tom', 403, 20150, 5),
	('Pat', 715, 35750, 6),
	('Lisa', 1247, 62350, 7);

-- Query:
SELECT
	SUM(SALES_REVENUE) AS TOTAL_SALES_REVENUE
FROM
	SALES_PERFORMANCE
WHERE
	SALESPERSON IN ('Samantha', 'Lisa');

-- Reset Database:
DROP TABLE SALES_PERFORMANCE;