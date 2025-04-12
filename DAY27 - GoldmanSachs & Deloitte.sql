-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: GoldmanSachs, Deloitte(Hard Level) #SQL Interview Question — Solution
-- You are given a day worth of scheduled departure and arrival times of trains at one
-- train station. One platform can only accommodate one train from the beginning of the 
-- minute it's scheduled to arrive until the end of the minute it's scheduled to depart.
-- Find the minimum number of platforms necessary to accommodate the entire scheduled traffic.

-- Database setup:
CREATE TABLE TRAIN_ARRIVALS (TRAIN_ID INT, ARRIVAL_TIME TIMESTAMP);

INSERT INTO
	TRAIN_ARRIVALS (TRAIN_ID, ARRIVAL_TIME)
VALUES
	(1, '2024-11-17 08:00'),
	(2, '2024-11-17 08:05'),
	(3, '2024-11-17 08:05'),
	(4, '2024-11-17 08:10'),
	(5, '2024-11-17 08:10'),
	(6, '2024-11-17 12:15'),
	(7, '2024-11-17 12:20'),
	(8, '2024-11-17 12:25'),
	(9, '2024-11-17 15:00'),
	(10, '2024-11-17 15:00'),
	(11, '2024-11-17 15:00'),
	(12, '2024-11-17 15:06'),
	(13, '2024-11-17 20:00'),
	(14, '2024-11-17 20:10');

CREATE TABLE TRAIN_DEPARTURES (TRAIN_ID INT, DEPARTURE_TIME TIMESTAMP);

INSERT INTO
	TRAIN_DEPARTURES (TRAIN_ID, DEPARTURE_TIME)
VALUES
	(1, '2024-11-17 08:15'),
	(2, '2024-11-17 08:10'),
	(3, '2024-11-17 08:20'),
	(4, '2024-11-17 08:25'),
	(5, '2024-11-17 08:20'),
	(6, '2024-11-17 13:00'),
	(7, '2024-11-17 12:25'),
	(8, '2024-11-17 12:30'),
	(9, '2024-11-17 15:05'),
	(10, '2024-11-17 15:10'),
	(11, '2024-11-17 15:15'),
	(12, '2024-11-17 15:15'),
	(13, '2024-11-17 20:15'),
	(14, '2024-11-17 20:15');

-- Query:
WITH
	ALL_TRAIN_DETAILS AS (
		SELECT
			ARRIVAL_TIME AS EVENT_TIME,
			1 AS EVENT_TYPE
		FROM
			TRAIN_ARRIVALS
		UNION ALL
		SELECT
			DEPARTURE_TIME AS EVENT_TIME,
			-1 AS EVENT_TYPE
		FROM
			TRAIN_DEPARTURES
	),
	CALCULATE_PLATFORMS AS (
		SELECT
			EVENT_TIME,
			SUM(EVENT_TYPE) OVER (
				ORDER BY
					EVENT_TIME
			) AS PLATFORMS_NEEDED
		FROM
			ALL_TRAIN_DETAILS
	)
SELECT
	MAX(PLATFORMS_NEEDED) AS MIN_PLATFORMS_NEEDED
FROM
	CALCULATE_PLATFORMS;

-- Reset Database:
DROP TABLE TRAIN_ARRIVALS;
DROP TABLE TRAIN_DEPARTURES;