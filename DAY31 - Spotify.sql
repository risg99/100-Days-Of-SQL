-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Spotify(Hard Level) #SQL Interview Question — Solution
-- Find the number of days a US track has stayed in the 1st position for both the US
-- and worldwide rankings on the same day. Output the track name and the number of days
-- in the 1st position. Order your output alphabetically by track name. If the region 
-- 'US' appears in dataset, it should be included in the worldwide ranking.

-- Database setup:
CREATE TABLE SPOTIFY_DAILY_RANKINGS_2017_US (
	POSITION INT,
	TRACKNAME VARCHAR(255),
	ARTIST VARCHAR(255),
	STREAMS INT,
	URL VARCHAR(255),
	DATE DATE
);

INSERT INTO
	SPOTIFY_DAILY_RANKINGS_2017_US (POSITION, TRACKNAME, ARTIST, STREAMS, URL, DATE)
VALUES
	(
		1,
		'Track A',
		'Artist 1',
		500000,
		'https://url1.com',
		'2017-01-01'
	),
	(
		2,
		'Track B',
		'Artist 2',
		400000,
		'https://url2.com',
		'2017-01-01'
	),
	(
		1,
		'Track A',
		'Artist 1',
		520000,
		'https://url1.com',
		'2017-01-02'
	),
	(
		3,
		'Track C',
		'Artist 3',
		300000,
		'https://url3.com',
		'2017-01-02'
	),
	(
		1,
		'Track D',
		'Artist 4',
		600000,
		'https://url4.com',
		'2017-01-03'
	);

CREATE TABLE SPOTIFY_WORLDWIDE_DAILY_SONG_RANKING (
	ID INT,
	POSITION INT,
	TRACKNAME VARCHAR(255),
	ARTIST VARCHAR(255),
	STREAMS INT,
	URL VARCHAR(255),
	DATE DATE,
	REGION VARCHAR(50)
);

INSERT INTO
	SPOTIFY_WORLDWIDE_DAILY_SONG_RANKING (
		ID,
		POSITION,
		TRACKNAME,
		ARTIST,
		STREAMS,
		URL,
		DATE,
		REGION
	)
VALUES
	(
		1,
		1,
		'Track A',
		'Artist 1',
		550000,
		'https://url1.com',
		'2017-01-01',
		'US'
	),
	(
		2,
		2,
		'Track B',
		'Artist 2',
		450000,
		'https://url2.com',
		'2017-01-01',
		'US'
	),
	(
		3,
		1,
		'Track A',
		'Artist 1',
		530000,
		'https://url1.com',
		'2017-01-02',
		'US'
	),
	(
		4,
		1,
		'Track D',
		'Artist 4',
		610000,
		'https://url4.com',
		'2017-01-03',
		'US'
	),
	(
		5,
		3,
		'Track C',
		'Artist 3',
		320000,
		'https://url3.com',
		'2017-01-03',
		'US'
	);

-- Query:
SELECT
	D.TRACKNAME,
	COUNT(*) AS DAYS_IN_FIRST_POSITION
FROM
	SPOTIFY_DAILY_RANKINGS_2017_US D
	JOIN SPOTIFY_WORLDWIDE_DAILY_SONG_RANKING W ON D.TRACKNAME = W.TRACKNAME
	AND D.DATE = W.DATE
WHERE
	D.POSITION = 1
	AND W.POSITION = 1
	AND W.REGION = 'US'
GROUP BY
	D.TRACKNAME
ORDER BY
	D.TRACKNAME;

-- Reset Database:
DROP TABLE SPOTIFY_DAILY_RANKINGS_2017_US;
DROP TABLE SPOTIFY_WORLDWIDE_DAILY_SONG_RANKING;