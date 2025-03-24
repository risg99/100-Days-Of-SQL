-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Netflix (Hard Level) #SQL Interview Question — Solution
-- Find the genre of the person with the most number of oscar winnings.
-- If there are more than one person with the same number of oscar wins, return the first one 
-- in alphabetic order based on their name. Use the names as keys when joining the tables.

-- Database setup:
CREATE TABLE NOMINEE_INFORMATION (
	NAME VARCHAR(20),
	AMG_PERSON_ID VARCHAR(10),
	TOP_GENRE VARCHAR(10),
	BIRTHDAY TIMESTAMP,
	ID INT
);
INSERT INTO
	NOMINEE_INFORMATION
VALUES
	(
		'Jennifer Lawrence',
		'P562566',
		'Drama',
		'1990-08-15',
		755
	),
	(
		'Jonah Hill',
		'P418718',
		'Comedy',
		'1983-12-20',
		747
	),
	(
		'Anne Hathaway',
		'P292630',
		'Drama',
		'1982-11-12',
		744
	),
	(
		'Jennifer Hudson',
		'P454405',
		'Drama',
		'1981-09-12',
		742
	),
	(
		'Rinko Kikuchi',
		'P475244',
		'Drama',
		'1981-01-06',
		739
	);
CREATE TABLE OSCAR_NOMINEES (
	YEAR INT,
	CATEGORY VARCHAR(30),
	NOMINEE VARCHAR(20),
	MOVIE VARCHAR(30),
	WINNER INT,
	ID INT
);
INSERT INTO
	OSCAR_NOMINEES
VALUES
	(
		2008,
		'actress in a leading role',
		'Anne Hathaway',
		'Rachel Getting Married',
		0,
		77
	),
	(
		2012,
		'actress in a supporting role',
		'Anne HathawayLes',
		'Mis_rables',
		1,
		78
	),
	(
		2006,
		'actress in a supporting role',
		'Jennifer Hudson',
		'Dreamgirls',
		1,
		711
	),
	(
		2010,
		'actress in a leading role',
		'Jennifer Lawrence',
		'Winters Bone',
		1,
		717
	),
	(
		2012,
		'actress in a leading role',
		'Jennifer Lawrence',
		'Silver Linings Playbook',
		1,
		718
	),
	(
		2011,
		'actor in a supporting role',
		'Jonah Hill',
		'Moneyball',
		0,
		799
	),
	(
		2006,
		'actress in a supporting role',
		'Rinko Kikuchi',
		'Babel',
		0,
		1253
	);

-- Query:
WITH
	OSCAR_WINNERS AS (
		SELECT
			NOMINEE,
			COUNT(WINNER) AS TOTAL_WINS
		FROM
			OSCAR_NOMINEES
		WHERE
			WINNER = 1
		GROUP BY
			NOMINEE
	)
SELECT
	TOP_GENRE
FROM
	NOMINEE_INFORMATION I,
	OSCAR_WINNERS W
WHERE
	W.NOMINEE = I.NAME
ORDER BY
	W.TOTAL_WINS DESC,
	W.NOMINEE ASC
LIMIT
	1;

-- Reset Database:
DROP TABLE NOMINEE_INFORMATION;
DROP TABLE OSCAR_NOMINEES;