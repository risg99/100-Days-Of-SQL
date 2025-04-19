-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: ESPN (Hard Level) #SQL Interview Question — Solution
-- Find the quarterback who threw the longest throw in 2016. Output the quarterback name 
-- along with their corresponding longest throw.
-- The 'lg' column contains the longest completion by the quarterback.

-- Database setup:
CREATE TABLE QBSTATS (
	ATT BIGINT,
	CMP BIGINT,
	GAME_POINTS BIGINT,
	HOME_AWAY VARCHAR(10),
	"int" BIGINT,
	LG VARCHAR(10),
	LOSS BIGINT,
	QB VARCHAR(40),
	RATE FLOAT,
	SACK BIGINT,
	TD BIGINT,
	YDS BIGINT,
	YEAR BIGINT,
	YPA FLOAT
);

INSERT INTO
	QBSTATS (
		ATT,
		CMP,
		GAME_POINTS,
		HOME_AWAY,
		"int",
		LG,
		LOSS,
		QB,
		RATE,
		SACK,
		TD,
		YDS,
		YEAR,
		YPA
	)
VALUES
	(
		40,
		25,
		21,
		'home',
		1,
		'85',
		0,
		'Tom Brady',
		105.5,
		2,
		3,
		315,
		2016,
		7.8
	),
	(
		35,
		20,
		14,
		'away',
		2,
		'67',
		1,
		'Aaron Rodgers',
		98.2,
		3,
		2,
		280,
		2016,
		6.5
	),
	(
		50,
		30,
		27,
		'home',
		0,
		'75',
		0,
		'Drew Brees',
		112.3,
		1,
		4,
		350,
		2016,
		7.0
	),
	(
		28,
		18,
		17,
		'away',
		1,
		'60',
		1,
		'Russell Wilson',
		96.7,
		2,
		1,
		220,
		2016,
		6.8
	),
	(
		45,
		28,
		24,
		'home',
		2,
		'78',
		0,
		'Matt Ryan',
		101.5,
		1,
		3,
		300,
		2016,
		7.2
	),
	(
		38,
		22,
		20,
		'away',
		1,
		'90',
		0,
		'Ben Roethlisberger',
		110.0,
		0,
		2,
		340,
		2016,
		8.0
	),
	(
		30,
		18,
		16,
		'home',
		1,
		'63',
		1,
		'Philip Rivers',
		92.5,
		3,
		2,
		240,
		2016,
		7.1
	);

-- Query:
SELECT
	QB AS QUARTERBACK_NAME,
	LG AS LONGEST_THROW
FROM
	QBSTATS
ORDER BY
	LONGEST_THROW DESC
LIMIT
	1;

-- Reset Database:
DROP TABLE QBSTATS;