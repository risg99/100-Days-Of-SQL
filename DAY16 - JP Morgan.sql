-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: JP Morgan, Chase, Bloomberg (Medium Level) #SQL Interview Question — Solution
-- Bank of Ireland has requested that you detect invalid transactions in December 2022. 
-- An invalid transaction is one that occurs outside of the bank's normal business hours. 
-- The following are the hours of operation for all branches:
-- Monday - Friday 09:00 - 16:00
-- Saturday & Sunday Closed
-- Irish Public Holidays 25th and 26th December
-- Determine the transaction ids of all invalid transactions.

-- Database setup:
CREATE TABLE BOI_TRANSACTIONS (
	TRANSACTION_ID INT PRIMARY KEY,
	TIME_STAMP TIMESTAMP NOT NULL
);

INSERT INTO
	BOI_TRANSACTIONS (TRANSACTION_ID, TIME_STAMP)
VALUES
	(1051, '2022-12-03 10:15'),
	(1052, '2022-12-03 17:00'),
	(1053, '2022-12-04 10:00'),
	(1054, '2022-12-04 14:00'),
	(1055, '2022-12-05 08:59'),
	(1056, '2022-12-05 16:01'),
	(1057, '2022-12-06 09:00'),
	(1058, '2022-12-06 15:59'),
	(1059, '2022-12-07 12:00'),
	(1060, '2022-12-08 09:00'),
	(1061, '2022-12-09 10:00'),
	(1062, '2022-12-10 11:00'),
	(1063, '2022-12-10 17:30'),
	(1064, '2022-12-11 12:00'),
	(1065, '2022-12-12 08:59'),
	(1066, '2022-12-12 16:01'),
	(1067, '2022-12-25 10:00'),
	(1068, '2022-12-25 15:00'),
	(1069, '2022-12-26 09:00'),
	(1070, '2022-12-26 14:00'),
	(1071, '2022-12-26 16:30'),
	(1072, '2022-12-27 09:00'),
	(1073, '2022-12-28 08:30'),
	(1074, '2022-12-29 16:15'),
	(1075, '2022-12-30 14:00'),
	(1076, '2022-12-31 10:00');

-- Query:
WITH
	ALL_TRANSACTIONS AS (
		SELECT
			TRANSACTION_ID,
			TIME_STAMP,
			EXTRACT(
				HOUR
				FROM
					TIME_STAMP
			) AS HOUR,
			EXTRACT(
				MINUTES
				FROM
					TIME_STAMP
			) AS MINUTES,
			EXTRACT(
				DAY
				FROM
					TIME_STAMP
			) AS DAY,
			EXTRACT(
				ISODOW
				FROM
					TIME_STAMP
			) AS DAY_OF_WEEK,
			EXTRACT(
				MONTH
				FROM
					TIME_STAMP
			) AS MONTH,
			EXTRACT(
				YEAR
				FROM
					TIME_STAMP
			) AS YEAR
		FROM
			BOI_TRANSACTIONS
	)
SELECT
	TRANSACTION_ID
FROM
	ALL_TRANSACTIONS
WHERE
	YEAR = 2022
	AND MONTH = 12
	AND (
		DAY_OF_WEEK IN (6, 7)
		OR DAY IN (25, 26)
		OR (
			DAY_OF_WEEK IN (1, 2, 3, 4, 5)
			AND (
				(
					HOUR < 9
					AND MINUTES <> 0
				)
				OR (
					HOUR >= 16
					AND MINUTES <> 0
				)
			)
		)
	);

-- Reset Database:
DROP TABLE BOI_TRANSACTIONS;