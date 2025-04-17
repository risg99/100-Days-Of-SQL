-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Apple (Hard Level) #SQL Interview Question — Solution
-- Find the number of Apple product users and the number of total users with a device and group
-- the counts by language. Assume Apple products are only MacBook-Pro, iPhone 5s, and iPad-air. 
-- Output the language along with the total number of Apple users and users with any device. 
-- Order your results based on the number of total users in descending order.

-- Database setup:
CREATE TABLE PLAYBOOK_USERS (
	USER_ID INT PRIMARY KEY,
	CREATED_AT TIMESTAMP,
	COMPANY_ID INT,
	LANGUAGE VARCHAR(50),
	ACTIVATED_AT TIMESTAMP,
	STATE VARCHAR(50)
);

INSERT INTO
	PLAYBOOK_USERS (
		USER_ID,
		CREATED_AT,
		COMPANY_ID,
		LANGUAGE,
		ACTIVATED_AT,
		STATE
	)
VALUES
	(
		1,
		'2024-01-01 08:00:00',
		101,
		'English',
		'2024-01-05 10:00:00',
		'Active'
	),
	(
		2,
		'2024-01-02 09:00:00',
		102,
		'Spanish',
		'2024-01-06 11:00:00',
		'Inactive'
	),
	(
		3,
		'2024-01-03 10:00:00',
		103,
		'French',
		'2024-01-07 12:00:00',
		'Active'
	),
	(
		4,
		'2024-01-04 11:00:00',
		104,
		'English',
		'2024-01-08 13:00:00',
		'Active'
	),
	(
		5,
		'2024-01-05 12:00:00',
		105,
		'Spanish',
		'2024-01-09 14:00:00',
		'Inactive'
	);

CREATE TABLE PLAYBOOK_EVENTS (
	USER_ID INT,
	OCCURRED_AT TIMESTAMP,
	EVENT_TYPE VARCHAR(50),
	EVENT_NAME VARCHAR(50),
	LOCATION VARCHAR(100),
	DEVICE VARCHAR(50)
);

INSERT INTO
	PLAYBOOK_EVENTS (
		USER_ID,
		OCCURRED_AT,
		EVENT_TYPE,
		EVENT_NAME,
		LOCATION,
		DEVICE
	)
VALUES
	(
		1,
		'2024-01-05 14:00:00',
		'Click',
		'Login',
		'USA',
		'MacBook-Pro'
	),
	(
		2,
		'2024-01-06 15:00:00',
		'View',
		'Dashboard',
		'Spain',
		'iPhone 5s'
	),
	(
		3,
		'2024-01-07 16:00:00',
		'Click',
		'Logout',
		'France',
		'iPad-air'
	),
	(
		4,
		'2024-01-08 17:00:00',
		'Purchase',
		'Subscription',
		'USA',
		'Windows-Laptop'
	),
	(
		5,
		'2024-01-09 18:00:00',
		'Click',
		'Login',
		'Spain',
		'Android-Phone'
	);

-- Query:
WITH
	APPLE_USERS AS (
		SELECT
			U.LANGUAGE,
			COUNT(*) AS APPLE_USERS_COUNT
		FROM
			PLAYBOOK_USERS U
			JOIN PLAYBOOK_EVENTS E ON U.USER_ID = E.USER_ID
		WHERE
			E.DEVICE IN ('MacBook-Pro', 'iPhone 5s', 'iPad-air')
		GROUP BY
			U.LANGUAGE
	),
	TOTAL_USERS AS (
		SELECT
			U.LANGUAGE,
			COUNT(*) AS ALL_DEVICES_USERS_COUNT
		FROM
			PLAYBOOK_USERS U
			JOIN PLAYBOOK_EVENTS E ON U.USER_ID = E.USER_ID
		GROUP BY
			U.LANGUAGE
	)
SELECT
	A.LANGUAGE,
	APPLE_USERS_COUNT,
	ALL_DEVICES_USERS_COUNT
FROM
	APPLE_USERS A
	JOIN TOTAL_USERS T ON A.LANGUAGE = T.LANGUAGE
ORDER BY
	ALL_DEVICES_USERS_COUNT DESC;

-- Reset Database:
DROP TABLE PLAYBOOK_USERS;
DROP TABLE PLAYBOOK_EVENTS;