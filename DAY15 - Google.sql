-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google (Medium Level) #SQL Interview Question — Solution
-- Find all records from days when the number of distinct users receiving emails
-- was greater than the number of distinct users sending emails.

-- Database setup:
CREATE TABLE GOOGLE_GMAIL_EMAILS (
	ID INT PRIMARY KEY,
	FROM_USER VARCHAR(50),
	TO_USER VARCHAR(50),
	DAY INT
);

INSERT INTO
	GOOGLE_GMAIL_EMAILS (ID, FROM_USER, TO_USER, DAY)
VALUES
	(0, '6edf0be4b2267df1fa', '75d295377a46f83236', 10),
	(1, '6edf0be4b2267df1fa', '32ded68d89443e808', 6),
	(2, '6edf0be4b2267df1fa', '55e60cfcc9dc49c17e', 10),
	(3, '6edf0be4b2267df1fa', 'e0e0defbb9ec47f6f7', 6),
	(4, '6edf0be4b2267df1fa', '47be2887786891367e', 1),
	(5, '6edf0be4b2267df1fa', '2813e59cf6c1ff698e', 6),
	(6, '6edf0be4b2267df1fa', 'a84065b7933ad01019', 8),
	(7, '6edf0be4b2267df1fa', '850badf89ed8f06854', 1),
	(8, '6edf0be4b2267df1fa', '6b503743a13d778200', 1),
	(9, '6edf0be4b2267df1fa', 'd63386c884aeb9f71d', 3),
	(10, '6edf0be4b2267df1fa', '5b8754928306a18b68', 2),
	(11, '6edf0be4b2267df1fa', '6edf0be4b2267df1fa', 8),
	(12, '6edf0be4b2267df1fa', '406539987dd9b679c0', 9),
	(13, '6edf0be4b2267df1fa', '114bafadff2d882864', 5),
	(14, '6edf0be4b2267df1fa', '157e3e9278e32aba3e', 2),
	(15, '75d295377a46f83236', '75d295377a46f83236', 6),
	(16, '75d295377a46f83236', 'd63386c884aeb9f71d', 8),
	(17, '75d295377a46f83236', '55e60cfcc9dc49c17e', 3),
	(
		18,
		'75d295377a46f83236',
		'47be2887786891367e',
		10
	),
	(
		19,
		'75d295377a46f83236',
		'5b8754928306a18b68',
		10
	),
	(20, '75d295377a46f83236', '850badf89ed8f06854', 7);

-- Query:
WITH
	DISTINCT_COUNTS AS (
		SELECT
			DAY,
			COUNT(DISTINCT FROM_USER) AS DISTINCT_SENDERS,
			COUNT(DISTINCT TO_USER) AS DISTINCT_RECEIVERS
		FROM
			GOOGLE_GMAIL_EMAILS
		GROUP BY
			DAY
	)
SELECT
	G.ID,
	G.FROM_USER,
	G.TO_USER,
	G.DAY
FROM
	GOOGLE_GMAIL_EMAILS G
	JOIN DISTINCT_COUNTS D ON G.DAY = D.DAY
WHERE
	D.DISTINCT_RECEIVERS > D.DISTINCT_SENDERS
ORDER BY
	D.DAY;

-- Reset Database:
DROP TABLE GOOGLE_GMAIL_EMAILS;