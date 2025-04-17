-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Expedia, Airbnb, Tripadvisor (Medium Level) #SQL Interview Question — Solution
-- Find the top two hotels with the most negative reviews.
-- Output the hotel name along with the corresponding number of negative reviews. Negative reviews 
-- are all the reviews with text under negative review different than "No Negative". Sort records 
-- based on the number of negative reviews in descending order.

-- Database setup:
CREATE TABLE HOTEL_REVIEWS (
	ADDITIONAL_NUMBER_OF_SCORING BIGINT,
	AVERAGE_SCORE FLOAT,
	DAYS_SINCE_REVIEW VARCHAR(255),
	HOTEL_ADDRESS VARCHAR(255),
	HOTEL_NAME VARCHAR(255),
	LAT FLOAT,
	LNG FLOAT,
	NEGATIVE_REVIEW VARCHAR(500),
	POSITIVE_REVIEW VARCHAR(500),
	REVIEW_DATE DATE,
	REVIEW_TOTAL_NEGATIVE_WORD_COUNTS BIGINT,
	REVIEW_TOTAL_POSITIVE_WORD_COUNTS BIGINT,
	REVIEWER_NATIONALITY VARCHAR(255),
	REVIEWER_SCORE FLOAT,
	TAGS VARCHAR(500),
	TOTAL_NUMBER_OF_REVIEWS BIGINT,
	TOTAL_NUMBER_OF_REVIEWS_REVIEWER_HAS_GIVEN BIGINT
);

INSERT INTO
	HOTEL_REVIEWS
VALUES
	(
		25,
		8.7,
		'15 days ago',
		'123 Street, City A',
		'Hotel Alpha',
		12.3456,
		98.7654,
		'Too noisy at night',
		'Great staff and clean rooms',
		'2024-12-01',
		5,
		15,
		'USA',
		8.5,
		'["Couple"]',
		200,
		10
	),
	(
		30,
		9.1,
		'20 days ago',
		'456 Avenue, City B',
		'Hotel Beta',
		34.5678,
		76.5432,
		'Old furniture',
		'Excellent location',
		'2024-12-02',
		4,
		12,
		'UK',
		9.0,
		'["Solo traveler"]',
		150,
		8
	),
	(
		12,
		8.3,
		'10 days ago',
		'789 Boulevard, City C',
		'Hotel Gamma',
		23.4567,
		67.8901,
		'No Negative',
		'Friendly staff',
		'2024-12-03',
		0,
		10,
		'India',
		8.3,
		'["Family"]',
		100,
		5
	),
	(
		15,
		8.0,
		'5 days ago',
		'321 Lane, City D',
		'Hotel Delta',
		45.6789,
		54.3210,
		'Uncomfortable bed',
		'Affordable price',
		'2024-12-04',
		6,
		8,
		'Germany',
		7.8,
		'["Couple"]',
		120,
		7
	),
	(
		20,
		7.9,
		'8 days ago',
		'654 Road, City E',
		'Hotel Alpha',
		67.8901,
		12.3456,
		'Poor room service',
		'Good breakfast',
		'2024-12-05',
		7,
		9,
		'France',
		7.5,
		'["Solo traveler"]',
		180,
		6
	),
	(
		18,
		9.3,
		'18 days ago',
		'987 Highway, City F',
		'Hotel Beta',
		34.5678,
		76.5432,
		'No Negative',
		'Amazing facilities',
		'2024-12-06',
		0,
		20,
		'USA',
		9.2,
		'["Couple"]',
		250,
		15
	);

-- Query:
SELECT
	HOTEL_NAME,
	COUNT(NEGATIVE_REVIEW) AS NEGATIVE_REVIEW_COUNT
FROM
	HOTEL_REVIEWS
WHERE
	NEGATIVE_REVIEW <> 'No Negative'
GROUP BY
	HOTEL_NAME
ORDER BY
	NEGATIVE_REVIEW_COUNT DESC
LIMIT
	2;

-- Reset Database:
DROP TABLE HOTEL_REVIEWS;