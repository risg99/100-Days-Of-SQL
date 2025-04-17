-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Meta (Hard Level) #SQL Interview Question — Solution
-- Market penetration is an important metric for Spotify's growth in different regions. 
-- As part of the analytics team, calculate the active user penetration rate in specific countries. 
-- Active Users must meet these criteria:
-- 1. Interacted with Spotify within the last 30 days (last_active_date >= 2024-01-01). 
-- 2. At least 5 sessions.
-- 3. At least 10 listening hours.
-- Formula: Active User Penetration Rate = (Number of Active Spotify Users in the Country / 
-- Total Users in the Country) Output: country, active_user_penetration_rate (rounded to 2 decimals).

-- Database setup:
CREATE TABLE PENETRATION_ANALYSIS (
	COUNTRY VARCHAR(20),
	LAST_ACTIVE_DATE DATE,
	LISTENING_HOURS BIGINT,
	SESSIONS BIGINT,
	USER_ID BIGINT
);

INSERT INTO
	PENETRATION_ANALYSIS (
		COUNTRY,
		LAST_ACTIVE_DATE,
		LISTENING_HOURS,
		SESSIONS,
		USER_ID
	)
VALUES
	('USA', '2024-01-25', 15, 7, 101),
	('USA', '2023-12-20', 5, 3, 102),
	('USA', '2024-01-20', 25, 10, 103),
	('India', '2024-01-28', 12, 6, 201),
	('India', '2023-12-15', 8, 4, 202),
	('India', '2024-01-15', 20, 7, 203),
	('UK', '2024-01-29', 18, 9, 301),
	('UK', '2023-12-30', 9, 4, 302),
	('UK', '2024-01-22', 30, 12, 303),
	('Canada', '2024-01-01', 11, 6, 401),
	('Canada', '2023-11-15', 3, 2, 402),
	('Canada', '2024-01-15', 22, 8, 403),
	('Germany', '2024-01-10', 14, 7, 501),
	('Germany', '2024-01-30', 10, 5, 502),
	('Germany', '2024-01-01', 5, 3, 503);

-- Query:
WITH
	ALL_USERS_CTE AS (
		SELECT
			COUNTRY,
			COUNT(USER_ID) AS ALL_USERS
		FROM
			PENETRATION_ANALYSIS
		GROUP BY
			COUNTRY
	),
	ACTIVE_USERS_CTE AS (
		SELECT
			COUNTRY,
			COUNT(USER_ID) AS ACTIVE_USERS
		FROM
			PENETRATION_ANALYSIS
		WHERE
			LAST_ACTIVE_DATE >= '2024-01-01'
			AND SESSIONS >= 5
			AND LISTENING_HOURS >= 10
		GROUP BY
			COUNTRY
	)
SELECT
	A.COUNTRY,
	ROUND(100.0 * ACTIVE_USERS / ALL_USERS, 2) AS ACTIVE_USER_PENETRATION_RATE
FROM
	ALL_USERS_CTE A
	JOIN ACTIVE_USERS_CTE B ON A.COUNTRY = B.COUNTRY
ORDER BY
	A.COUNTRY;

-- Reset Database:
DROP TABLE PENETRATION_ANALYSIS;