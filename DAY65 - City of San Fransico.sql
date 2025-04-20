-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: City of San Francisco (Hard Level) #SQL Interview Question — Solution
-- Find the number of words in each business name. Avoid counting special symbols as words 
-- (e.g. &). Output the business name and its count of words.

-- Database setup:
CREATE TABLE SF_RESTAURANT_HEALTH_VIOLATIONS (
	BUSINESS_ADDRESS VARCHAR(255),
	BUSINESS_CITY VARCHAR(100),
	BUSINESS_ID BIGINT,
	BUSINESS_LATITUDE FLOAT,
	BUSINESS_LOCATION VARCHAR(255),
	BUSINESS_LONGITUDE FLOAT,
	BUSINESS_NAME VARCHAR(255),
	BUSINESS_PHONE_NUMBER BIGINT,
	BUSINESS_POSTAL_CODE VARCHAR(20),
	BUSINESS_STATE VARCHAR(50),
	INSPECTION_DATE DATE,
	INSPECTION_ID VARCHAR(100),
	INSPECTION_SCORE FLOAT,
	INSPECTION_TYPE VARCHAR(100),
	RISK_CATEGORY VARCHAR(100),
	VIOLATION_DESCRIPTION VARCHAR(255),
	VIOLATION_ID VARCHAR(100)
);

INSERT INTO
	SF_RESTAURANT_HEALTH_VIOLATIONS (
		BUSINESS_ADDRESS,
		BUSINESS_CITY,
		BUSINESS_ID,
		BUSINESS_LATITUDE,
		BUSINESS_LOCATION,
		BUSINESS_LONGITUDE,
		BUSINESS_NAME,
		BUSINESS_PHONE_NUMBER,
		BUSINESS_POSTAL_CODE,
		BUSINESS_STATE,
		INSPECTION_DATE,
		INSPECTION_ID,
		INSPECTION_SCORE,
		INSPECTION_TYPE,
		RISK_CATEGORY,
		VIOLATION_DESCRIPTION,
		VIOLATION_ID
	)
VALUES
	(
		'123 Main St',
		'San Francisco',
		101,
		37.7749,
		'123 Main St, San Francisco, CA',
		-122.4194,
		'John''s Pizza & Grill',
		4151234567,
		'94103',
		'CA',
		'2024-12-20',
		'I101',
		85.5,
		'Routine Inspection',
		'Low Risk',
		'Cleanliness issue',
		'V101'
	),
	(
		'456 Market St',
		'San Francisco',
		102,
		37.7741,
		'456 Market St, San Francisco, CA',
		-122.4202,
		'Sushi-Hub',
		4159876543,
		'94104',
		'CA',
		'2024-12-15',
		'I102',
		90.0,
		'Routine Inspection',
		'Moderate Risk',
		'Improper food storage',
		'V102'
	),
	(
		'789 Mission St',
		'San Francisco',
		103,
		37.7753,
		'789 Mission St, San Francisco, CA',
		-122.4175,
		'The Good Eatery Cafe',
		4155551212,
		'94105',
		'CA',
		'2024-12-10',
		'I103',
		88.5,
		'Follow-Up Inspection',
		'High Risk',
		'Cross-contamination issue',
		'V103'
	),
	(
		'321 Broadway',
		'San Francisco',
		104,
		37.7764,
		'321 Broadway, San Francisco, CA',
		-122.4188,
		'Burger Palace & More',
		4152223333,
		'94106',
		'CA',
		'2024-12-05',
		'I104',
		80.0,
		'Routine Inspection',
		'Low Risk',
		'Expired food',
		'V104'
	),
	(
		'654 Polk St',
		'San Francisco',
		105,
		37.7775,
		'654 Polk St, San Francisco, CA',
		-122.4167,
		'Quick_&_Fresh',
		4154445555,
		'94107',
		'CA',
		'2024-12-01',
		'I105',
		75.0,
		'Routine Inspection',
		'Moderate Risk',
		'Improper sanitation',
		'V105'
	);

-- Query:
SELECT
	BUSINESS_NAME,
	LENGTH(
		REPLACE(
			REPLACE(REPLACE(BUSINESS_NAME, '&', ''), '-', ''),
			'_',
			''
		)
	) - LENGTH(
		REPLACE(
			REPLACE(
				REPLACE(REPLACE(BUSINESS_NAME, '&', ''), '-', ''),
				'_',
				''
			),
			' ',
			''
		)
	) + 1 AS WORD_COUNT
FROM
	SF_RESTAURANT_HEALTH_VIOLATIONS;

-- Reset Database:
DROP TABLE SF_RESTAURANT_HEALTH_VIOLATIONS;