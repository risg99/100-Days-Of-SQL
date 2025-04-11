-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Microsoft (Hard Level) #SQL Interview Question — Solution
-- Find the total number of downloads for paying and non-paying users by date. 
-- Include only records where non-paying customers have more downloads than paying customers. 
-- The output should be sorted by earliest date first and contain 3 columns date, non-paying
-- downloads, paying downloads. 

-- Database setup:
CREATE TABLE MS_USER_DIMENSION (USER_ID INT PRIMARY KEY, ACC_ID INT);

INSERT INTO
	MS_USER_DIMENSION (USER_ID, ACC_ID)
VALUES
	(1, 101),
	(2, 102),
	(3, 103),
	(4, 104),
	(5, 105);

CREATE TABLE MS_ACC_DIMENSION (
	ACC_ID INT PRIMARY KEY,
	PAYING_CUSTOMER VARCHAR(10)
);

INSERT INTO
	MS_ACC_DIMENSION (ACC_ID, PAYING_CUSTOMER)
VALUES
	(101, 'Yes'),
	(102, 'No'),
	(103, 'Yes'),
	(104, 'No'),
	(105, 'No');

CREATE TABLE MS_DOWNLOAD_FACTS (DATE TIMESTAMP, USER_ID INT, DOWNLOADS INT);

INSERT INTO
	MS_DOWNLOAD_FACTS (DATE, USER_ID, DOWNLOADS)
VALUES
	('2024-10-01', 1, 10),
	('2024-10-01', 2, 15),
	('2024-10-02', 1, 8),
	('2024-10-02', 3, 12),
	('2024-10-02', 4, 20),
	('2024-10-03', 2, 25),
	('2024-10-03', 5, 18);

-- Query:
WITH
	ALL_USERS AS (
		SELECT
			DATE (D.DATE),
			SUM(
				CASE
					WHEN A.PAYING_CUSTOMER = 'Yes' THEN D.DOWNLOADS
					ELSE 0
				END
			) AS PAY_YES,
			SUM(
				CASE
					WHEN A.PAYING_CUSTOMER = 'No' THEN D.DOWNLOADS
					ELSE 0
				END
			) AS PAY_NO
		FROM
			MS_USER_DIMENSION U,
			MS_ACC_DIMENSION A,
			MS_DOWNLOAD_FACTS D
		WHERE
			U.ACC_ID = A.ACC_ID
			AND U.USER_ID = D.USER_ID
		GROUP BY
			D.DATE
	)
SELECT
	DATE,
	PAY_NO AS NON_PAYING_DOWNLOADS,
	PAY_YES AS PAYING_DOWNLOADS
FROM
	ALL_USERS
WHERE
	PAY_NO > PAY_YES;

-- Reset Database:
DROP TABLE MS_USER_DIMENSION;
DROP TABLE MS_ACC_DIMENSION;
DROP TABLE MS_DOWNLOAD_FACTS;