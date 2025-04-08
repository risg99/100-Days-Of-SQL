-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Expedia, Airbnb (Basic Level) #SQL Interview Question — Solution
-- Find the number of rows for each review score earned by 'Hotel Arena'. 
-- Output the hotel name (which should be 'Hotel Arena'), review score along 
-- with the corresponding number of rows with that score for the specified hotel.

-- Database setup:
CREATE TABLE HOTEL_REVIEWS (
	HOTEL_ADDRESS VARCHAR(255),
	ADDITIONAL_NUMBER_OF_SCORING INT,
	REVIEW_DATE TIMESTAMP,
	AVERAGE_SCORE FLOAT,
	HOTEL_NAME VARCHAR(100),
	REVIEWER_NATIONALITY VARCHAR(100),
	NEGATIVE_REVIEW TEXT,
	REVIEW_TOTAL_NEGATIVE_WORD_COUNTS INT,
	TOTAL_NUMBER_OF_REVIEWS INT,
	POSITIVE_REVIEW TEXT,
	REVIEW_TOTAL_POSITIVE_WORD_COUNTS INT,
	TOTAL_NUMBER_OF_REVIEWS_REVIEWER_HAS_GIVEN INT,
	REVIEWER_SCORE FLOAT,
	TAGS VARCHAR(255),
	DAYS_SINCE_REVIEW VARCHAR(50),
	LAT FLOAT,
	LNG FLOAT
);

INSERT INTO
	HOTEL_REVIEWS (
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
		'123 Main St',
		5,
		'2024-01-01',
		8.5,
		'Hotel Arena',
		'American',
		'Noisy room',
		3,
		200,
		'Great staff',
		5,
		10,
		8.0,
		'Family stay',
		'100 days',
		40.7128,
		-74.0060
	),
	(
		'123 Main St',
		2,
		'2024-01-02',
		8.5,
		'Hotel Arena',
		'British',
		'Small bathroom',
		2,
		200,
		'Clean room',
		6,
		5,
		9.0,
		'Solo traveler',
		'95 days',
		40.7128,
		-74.0060
	),
	(
		'123 Main St',
		3,
		'2024-01-03',
		8.5,
		'Hotel Arena',
		'Canadian',
		'Slow service',
		4,
		200,
		'Nice view',
		7,
		3,
		6.0,
		'Couple stay',
		'90 days',
		40.7128,
		-74.0060
	);

-- Query:
SELECT
	HOTEL_NAME,
	REVIEWER_SCORE,
	COUNT(*) AS SCORE_COUNT
FROM
	HOTEL_REVIEWS
WHERE
	HOTEL_NAME = 'Hotel Arena'
GROUP BY
	HOTEL_NAME,
	REVIEWER_SCORE
ORDER BY
	REVIEWER_SCORE ASC;

-- Reset Database:
DROP TABLE HOTEL_REVIEWS;