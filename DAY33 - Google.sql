-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google(Hard Level) #SQL Interview Question — Solution
-- Calculate the average session distance traveled by Google Fit users using GPS 
-- data for two scenarios:
-- a. Considering Earth's curvature (Haversine formula).
-- b. Assuming a flat surface.
-- For each session, use the distance between the highest and lowest step IDs, and 
-- ignore sessions with only one step. Calculate and output the average distance for 
-- both scenarios and the difference between them.
-- Formulas:
-- 1. Curved Earth: d=6371×arccos(sin(ϕ1)×sin(ϕ2)+cos(ϕ1)×cos(ϕ2)×cos(λ2−λ1))
-- 2. Flat Surface: d=111×(lat2−lat1)2+(lon2−lon1)2

-- Database setup:
CREATE TABLE google_fit_location (user_id VARCHAR(50),session_id INT,step_id INT,day INT,latitude FLOAT,longitude FLOAT,altitude FLOAT);
INSERT INTO google_fit_location (user_id, session_id, step_id, day, latitude, longitude, altitude)VALUES('user_1', 101, 1, 1, 37.7749, -122.4194, 15.0),('user_1', 101, 2, 1, 37.7750, -122.4195, 15.5),('user_1', 101, 3, 1, 37.7751, -122.4196, 16.0),('user_1', 102, 1, 1, 34.0522, -118.2437, 20.0),('user_1', 102, 2, 1, 34.0523, -118.2438, 20.5),('user_2', 201, 1, 1, 40.7128, -74.0060, 5.0),('user_2', 201, 2, 1, 40.7129, -74.0061, 5.5),('user_2', 202, 1, 1, 51.5074, -0.1278, 10.0),('user_2', 202, 2, 1, 51.5075, -0.1279, 10.5),('user_3', 301, 1, 1, 48.8566, 2.3522, 25.0),('user_3', 301, 2, 1, 48.8567, 2.3523, 25.5);

-- Query:
WITH
	SESSION_STEPIDS AS (
		SELECT
			USER_ID,
			SESSION_ID,
			MIN(STEP_ID) AS MIN_STEP_ID,
			MAX(STEP_ID) AS MAX_STEP_ID
		FROM
			GOOGLE_FIT_LOCATION
		GROUP BY
			USER_ID,
			SESSION_ID,
			DAY
		HAVING
			MAX(STEP_ID) - MIN(STEP_ID) > 0
	),
	SESSION_MINMAX_STEPIDS AS (
		SELECT
			S.USER_ID,
			S.SESSION_ID,
			S.MAX_STEP_ID,
			S.MIN_STEP_ID,
			MIN(
				CASE
					WHEN S.MIN_STEP_ID = G.STEP_ID THEN G.LATITUDE
				END
			) AS START_LAT,
			MIN(
				CASE
					WHEN S.MIN_STEP_ID = G.STEP_ID THEN G.LONGITUDE
				END
			) AS START_LON,
			MAX(
				CASE
					WHEN S.MAX_STEP_ID = G.STEP_ID THEN G.LATITUDE
				END
			) AS END_LAT,
			MAX(
				CASE
					WHEN S.MAX_STEP_ID = G.STEP_ID THEN G.LONGITUDE
				END
			) AS END_LON
		FROM
			SESSION_STEPIDS S
			JOIN GOOGLE_FIT_LOCATION G ON S.USER_ID = G.USER_ID
			AND S.SESSION_ID = G.SESSION_ID
		GROUP BY
			S.USER_ID,
			S.SESSION_ID,
			S.MAX_STEP_ID,
			S.MIN_STEP_ID
	),
	DISTANCES_CTE AS (
		SELECT
			S.USER_ID,
			S.SESSION_ID,
			6371 * ACOS(
				(SIN(RADIANS(START_LAT)) * SIN(RADIANS(END_LAT))) + (
					COS(RADIANS(START_LAT)) * COS(RADIANS(END_LAT)) * COS(RADIANS(END_LON - START_LON))
				)
			) AS CURVED_DISTANCE,
			111 * SQRT(
				POWER(END_LAT - START_LAT, 2) + POWER(END_LON - START_LON, 2)
			) AS FLAT_DISTANCE
		FROM
			SESSION_MINMAX_STEPIDS S
	)
SELECT
	USER_ID,
	AVG(CURVED_DISTANCE) AS AVERAGE_CURVED_DISTANCE,
	AVG(FLAT_DISTANCE) AS AVERAGE_FLAT_DISTANCE,
	AVG(CURVED_DISTANCE) - AVG(FLAT_DISTANCE) AS DIFFERENCE_IN_DISTANCE
FROM
	DISTANCES_CTE
GROUP BY
	USER_ID;

-- Reset Database:
DROP TABLE google_fit_location;