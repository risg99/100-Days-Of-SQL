-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google, Airbnb, Expedia(Medium Level) #SQL Interview Question — Solution
-- Find the three ten hotels with the highest ratings. Output the hotel name 
-- along with the corresponding average score. Sort records based on the average score 
-- in descending order.

-- Database setup:
CREATE TABLE HOTEL_ADDRESS (
	HOTEL_ADDRESS VARCHAR(255),
	ADDITIONAL_NUMBER_OF_SCORING INT,
	REVIEW_DATE DATE,
	AVERAGE_SCORE FLOAT,
	HOTEL_NAME VARCHAR(255),
	REVIEWER_NATIONALITY VARCHAR(50),
	NEGATIVE_REVIEW VARCHAR(500),
	REVIEW_TOTAL_NEGATIVE_WORD_COUNTS INT,
	TOTAL_NUMBER_OF_REVIEWS INT,
	POSITIVE_REVIEW VARCHAR(500),
	REVIEW_TOTAL_POSITIVE_WORD_COUNTS INT,
	TOTAL_NUMBER_OF_REVIEWS_REVIEWER_HAS_GIVEN INT,
	REVIEWER_SCORE FLOAT,
	TAGS VARCHAR(255),
	DAYS_SINCE_REVIEW VARCHAR(50),
	LAT FLOAT,
	LNG FLOAT
);

INSERT INTO
	HOTEL_ADDRESS (
		HOTEL_ADDRESS,
		ADDITIONAL_NUMBER_OF_SCORING,
		REVIEW_DATE,
		AVERAGE_SCORE,
		HOTEL_NAME,
		REVIEWER_NATIONALITY,
		NEGATIVE_REVIEW,
		REVIEW_TOTAL_NEGATIVE_WORD_COUNTS,
		TOTAL_NUMBER_OF_REVIEWS,
		POSITIVE_REVIEW,
		REVIEW_TOTAL_POSITIVE_WORD_COUNTS,
		TOTAL_NUMBER_OF_REVIEWS_REVIEWER_HAS_GIVEN,
		REVIEWER_SCORE,
		TAGS,
		DAYS_SINCE_REVIEW,
		LAT,
		LNG
	)
VALUES
	(
		'123 Ocean Ave, Miami, FL',
		3,
		'2024-11-10',
		4.2,
		'Ocean View',
		'American',
		'Room small, but clean.',
		5,
		150,
		'Great location and friendly staff!',
		8,
		30,
		4.5,
		'beachfront, family-friendly',
		'5 days',
		25.7617,
		-80.1918
	),
	(
		'456 Mountain Rd, Boulder, CO',
		2,
		'2024-11-12',
		3.9,
		'Mountain Lodge',
		'Canadian',
		'wifi slow.',
		3,
		120,
		'nice rooms.',
		10,
		20,
		4.0,
		'scenic, nature',
		'3 days',
		40.015,
		-105.2705
	),
	(
		'789 Downtown St, New York, NY',
		5,
		'2024-11-15',
		4.7,
		'Central Park Hotel',
		'British',
		'Noisy, sleep.',
		7,
		200,
		'Perfect location near Central Park.',
		12,
		50,
		4.7,
		'luxury, city-center',
		'1 day',
		40.7831,
		-73.9712
	),
	(
		'101 Lakeside Blvd, Austin, TX',
		1,
		'2024-11-08',
		4.0,
		'Lakeside Inn',
		'Mexican',
		'food avg.',
		4,
		80,
		'Nice, friendly service.',
		6,
		15,
		3.8,
		'relaxing, family',
		'10 days',
		30.2672,
		-97.7431
	),
	(
		'202 River Ave, Nashville, TN',
		4,
		'2024-11-13',
		4.5,
		'Riverside',
		'German',
		'Limited parking',
		2,
		175,
		'Great rooms.',
		9,
		25,
		4.2,
		'riverfront, peaceful',
		'2 days',
		36.1627,
		-86.7816
	);

-- Query:
SELECT
	HOTEL_NAME,
	MAX(AVERAGE_SCORE) AS MAX_AVERAGE_SCORE
FROM
	HOTEL_ADDRESS
GROUP BY
	HOTEL_NAME
ORDER BY
	MAX_AVERAGE_SCORE DESC
LIMIT
	3;

-- Reset Database:
DROP TABLE HOTEL_ADDRESS;