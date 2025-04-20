-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- You are given a table of tennis players and their matches that they could 
-- either win (W) or lose (L). Find the longest streak of wins. A streak is a 
-- set of consecutive won matches of one player. The streak ends once a player
-- loses their next match. Output the ID of the player or players and the length 
-- of the streak.

-- Database setup:
CREATE TABLE PLAYERS_RESULTS (
	MATCH_DATE DATE,
	MATCH_RESULT VARCHAR(1),
	PLAYER_ID BIGINT
);

INSERT INTO
	PLAYERS_RESULTS (MATCH_DATE, MATCH_RESULT, PLAYER_ID)
VALUES
	('2023-01-01', 'W', 1),
	('2023-01-02', 'W', 1),
	('2023-01-03', 'L', 1),
	('2023-01-04', 'W', 1),
	('2023-01-01', 'L', 2),
	('2023-01-02', 'W', 2),
	('2023-01-03', 'W', 2),
	('2023-01-04', 'W', 2),
	('2023-01-05', 'L', 2),
	('2023-01-01', 'W', 3),
	('2023-01-02', 'W', 3),
	('2023-01-03', 'W', 3),
	('2023-01-04', 'W', 3),
	('2023-01-05', 'L', 3);

-- Query:
WITH
	ALL_STREAKS AS (
		SELECT
			PLAYER_ID,
			MATCH_RESULT,
			RANK() OVER (
				PARTITION BY
					PLAYER_ID,
					MATCH_RESULT
				ORDER BY
					MATCH_DATE
			) AS RNK
		FROM
			PLAYERS_RESULTS
	),
	LONGEST_STREAK AS (
		SELECT
			PLAYER_ID,
			MAX(RNK) AS STREAK_LENGTH
		FROM
			ALL_STREAKS
		WHERE
			MATCH_RESULT = 'W'
		GROUP BY
			PLAYER_ID
	)
SELECT
	PLAYER_ID,
	STREAK_LENGTH
FROM
	LONGEST_STREAK
WHERE
	STREAK_LENGTH = (
		SELECT
			MAX(STREAK_LENGTH)
		FROM
			LONGEST_STREAK
	);

-- Reset Database:
DROP TABLE PLAYERS_RESULTS;