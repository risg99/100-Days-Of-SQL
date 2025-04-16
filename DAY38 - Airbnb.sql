-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Airbnb (Hard Level) #SQL Interview Question — Solution
-- Estimate the growth of Airbnb each year using the number of hosts registered as the 
-- growth metric. The rate of growth is calculated by taking ((number of hosts registered 
-- in the current year - number of hosts registered in the previous year) / the number of 
-- hosts registered in the previous year) * 100. Output the year, number of hosts in the 
-- current year, number of hosts in the previous year, and the rate of growth. Round the 
-- rate of growth to the nearest percent and order the result in the ascending order based on the year. 
-- Assume that the dataset consists only of unique hosts, meaning there are no duplicate hosts listed.

-- Database setup:
CREATE TABLE AIRBNB_SEARCH_DETAILS (
	ID INT PRIMARY KEY,
	PRICE FLOAT,
	PROPERTY_TYPE VARCHAR(100),
	ROOM_TYPE VARCHAR(100),
	AMENITIES VARCHAR(500),
	ACCOMMODATES INT,
	BATHROOMS INT,
	BED_TYPE VARCHAR(50),
	CANCELLATION_POLICY VARCHAR(50),
	CLEANING_FEE INT,
	CITY VARCHAR(100),
	HOST_IDENTITY_VERIFIED VARCHAR(10),
	HOST_RESPONSE_RATE VARCHAR(10),
	HOST_SINCE DATE,
	NEIGHBOURHOOD VARCHAR(100),
	NUMBER_OF_REVIEWS INT,
	REVIEW_SCORES_RATING FLOAT,
	ZIPCODE INT,
	BEDROOMS INT,
	BEDS INT
);

INSERT INTO
	AIRBNB_SEARCH_DETAILS (
		ID,
		PRICE,
		PROPERTY_TYPE,
		ROOM_TYPE,
		AMENITIES,
		ACCOMMODATES,
		BATHROOMS,
		BED_TYPE,
		CANCELLATION_POLICY,
		CLEANING_FEE,
		CITY,
		HOST_IDENTITY_VERIFIED,
		HOST_RESPONSE_RATE,
		HOST_SINCE,
		NEIGHBOURHOOD,
		NUMBER_OF_REVIEWS,
		REVIEW_SCORES_RATING,
		ZIPCODE,
		BEDROOMS,
		BEDS
	)
VALUES
	(
		1,
		100,
		'Apartment',
		'Entire home/apt',
		'WiFi, Kitchen',
		2,
		1,
		'Real Bed',
		'Flexible',
		1,
		'New York',
		'Yes',
		'90%',
		'2019-01-15',
		'Manhattan',
		120,
		4.8,
		10001,
		1,
		1
	),
	(
		2,
		75,
		'House',
		'Private room',
		'WiFi, Parking',
		3,
		1,
		'Queen Bed',
		'Moderate',
		0,
		'Los Angeles',
		'Yes',
		'80%',
		'2018-06-22',
		'Hollywood',
		80,
		4.5,
		90001,
		2,
		1
	),
	(
		3,
		50,
		'Shared Room',
		'Shared room',
		'WiFi',
		1,
		1,
		'Single Bed',
		'Strict',
		0,
		'Chicago',
		'No',
		'70%',
		'2019-03-10',
		'Lincoln Park',
		40,
		3.8,
		60614,
		1,
		1
	),
	(
		4,
		200,
		'Villa',
		'Entire home/apt',
		'Pool, WiFi',
		6,
		3,
		'King Bed',
		'Flexible',
		1,
		'Miami',
		'Yes',
		'95%',
		'2020-07-05',
		'Miami Beach',
		300,
		4.9,
		33139,
		3,
		4
	),
	(
		5,
		120,
		'Apartment',
		'Entire home/apt',
		'WiFi, Kitchen, Parking',
		4,
		2,
		'Double Bed',
		'Moderate',
		1,
		'San Francisco',
		'Yes',
		'85%',
		'2021-09-18',
		'Downtown',
		150,
		4.7,
		94102,
		2,
		2
	),
	(
		6,
		80,
		'Apartment',
		'Private room',
		'WiFi',
		2,
		1,
		'Queen Bed',
		'Strict',
		0,
		'Austin',
		'No',
		'75%',
		'2020-11-22',
		'Downtown',
		100,
		4.4,
		78701,
		1,
		1
	),
	(
		7,
		150,
		'House',
		'Entire home/apt',
		'WiFi, Kitchen',
		5,
		2,
		'Queen Bed',
		'Flexible',
		1,
		'Seattle',
		'Yes',
		'90%',
		'2019-05-30',
		'Capitol Hill',
		200,
		4.6,
		98102,
		2,
		3
	),
	(
		8,
		60,
		'Apartment',
		'Shared room',
		'WiFi',
		1,
		1,
		'Single Bed',
		'Moderate',
		0,
		'Boston',
		'Yes',
		'80%',
		'2018-04-18',
		'Beacon Hill',
		50,
		4.2,
		02108,
		1,
		1
	),
	(
		9,
		90,
		'House',
		'Private room',
		'WiFi, Parking',
		3,
		2,
		'King Bed',
		'Strict',
		1,
		'Denver',
		'No',
		'85%',
		'2021-02-10',
		'Downtown',
		75,
		4.0,
		80202,
		1,
		2
	),
	(
		10,
		250,
		'Villa',
		'Entire home/apt',
		'Pool, WiFi, Kitchen',
		8,
		4,
		'King Bed',
		'Flexible',
		1,
		'Las Vegas',
		'Yes',
		'95%',
		'2022-06-15',
		'The Strip',
		400,
		4.9,
		89109,
		4,
		5
	);

-- Query:
WITH
	ALL_YEARS_HOSTS AS (
		SELECT
			EXTRACT(
				YEAR
				FROM
					HOST_SINCE
			) AS YEAR,
			COUNT(*) AS HOSTS
		FROM
			AIRBNB_SEARCH_DETAILS
		GROUP BY
			YEAR
	),
	GROWTH_CALC AS (
		SELECT
			YEAR AS CURR_YEAR,
			LAG(HOSTS) OVER (
				ORDER BY
					YEAR
			) AS PAST_HOSTS,
			HOSTS AS CURR_HOSTS
		FROM
			ALL_YEARS_HOSTS
	)
SELECT
	CURR_YEAR,
	CURR_HOSTS AS NUM_HOSTS_CURRENT_YEAR,
	PAST_HOSTS AS NUM_HOSTS_PREVIOUS_YEAR,
	ROUND(
		((CURR_HOSTS - PAST_HOSTS) * 100.0 / (PAST_HOSTS))
	) AS RATE_OF_GROWTH
FROM
	GROWTH_CALC
WHERE
	PAST_HOSTS IS NOT NULL
ORDER BY
	CURR_YEAR;

-- Reset Database:
DROP TABLE AIRBNB_SEARCH_DETAILS;