-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Twitch (Hard Level) #SQL Interview Question — Solution
-- From users who had their first session as a viewer, how many streamer sessions 
-- have they had? Return the user id and number of sessions in descending order. 
-- In case there are users with the same number of sessions, order them by ascending user id.

-- Database setup:
CREATE TABLE TWITCH_SESSIONS (
	USER_ID BIGINT,
	SESSION_START TIMESTAMP,
	SESSION_END TIMESTAMP,
	SESSION_ID BIGINT PRIMARY KEY,
	SESSION_TYPE VARCHAR(20) CHECK (SESSION_TYPE IN ('viewer', 'streamer'))
);

INSERT INTO
	TWITCH_SESSIONS (
		USER_ID,
		SESSION_START,
		SESSION_END,
		SESSION_ID,
		SESSION_TYPE
	)
VALUES
	(
		101,
		'2024-02-01 10:00:00',
		'2024-02-01 11:00:00',
		1,
		'viewer'
	),
	(
		101,
		'2024-02-02 14:00:00',
		'2024-02-02 15:30:00',
		2,
		'streamer'
	),
	(
		102,
		'2024-02-01 09:30:00',
		'2024-02-01 10:30:00',
		3,
		'viewer'
	),
	(
		102,
		'2024-02-03 16:00:00',
		'2024-02-03 17:00:00',
		4,
		'streamer'
	),
	(
		102,
		'2024-02-05 18:00:00',
		'2024-02-05 19:30:00',
		5,
		'streamer'
	),
	(
		103,
		'2024-02-02 11:00:00',
		'2024-02-02 12:00:00',
		6,
		'viewer'
	),
	(
		104,
		'2024-02-01 08:30:00',
		'2024-02-01 09:00:00',
		7,
		'viewer'
	),
	(
		104,
		'2024-02-04 20:00:00',
		'2024-02-04 21:00:00',
		8,
		'streamer'
	),
	(
		104,
		'2024-02-06 22:00:00',
		'2024-02-06 23:00:00',
		9,
		'streamer'
	),
	(
		104,
		'2024-02-07 15:00:00',
		'2024-02-07 16:30:00',
		10,
		'streamer'
	);

-- Query:
WITH
	FIRSTSESSION AS (
		SELECT
			USER_ID,
			MIN(SESSION_START) OVER (
				PARTITION BY
					USER_ID
			) AS FIRST_SESSION_TIME
		FROM
			TWITCH_SESSIONS
		WHERE
			SESSION_TYPE = 'viewer'
	)
SELECT DISTINCT
	TS.USER_ID,
	COUNT(*) OVER (
		PARTITION BY
			TS.USER_ID
	) AS STREAMER_SESSIONS_COUNT
FROM
	TWITCH_SESSIONS TS
	JOIN FIRSTSESSION FS ON TS.USER_ID = FS.USER_ID
WHERE
	TS.SESSION_TYPE = 'streamer'
ORDER BY
	STREAMER_SESSIONS_COUNT DESC,
	TS.USER_ID ASC;

-- Reset Database:
DROP TABLE TWITCH_SESSIONS;