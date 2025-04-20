-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: IBM (Medium Level) #SQL Interview Question — Solution
-- Calculate the total number of interactions and the total number of contents created 
-- for each customer. Include all interaction types and content types in your calculations.
-- Your output should include the customer's ID, the total number of interactions, and the 
-- total number of content items.

-- Database setup:
CREATE TABLE CUSTOMER_INTERACTIONS (
	CUSTOMER_ID BIGINT,
	INTERACTION_DATE TIMESTAMP,
	INTERACTION_ID BIGINT,
	INTERACTION_TYPE VARCHAR(50)
);

INSERT INTO
	CUSTOMER_INTERACTIONS (
		CUSTOMER_ID,
		INTERACTION_DATE,
		INTERACTION_ID,
		INTERACTION_TYPE
	)
VALUES
	(1, '2023-01-15 10:30:00', 101, 'Click'),
	(1, '2023-01-16 11:00:00', 102, 'Purchase'),
	(2, '2023-01-17 14:45:00', 103, 'View'),
	(3, '2023-01-18 09:20:00', 104, 'Share'),
	(3, '2023-01-18 09:25:00', 105, 'Like'),
	(4, '2023-01-19 12:10:00', 106, 'Comment');

CREATE TABLE USER_CONTENTS (
	CONTENT_ID BIGINT,
	CONTENT_TEXT VARCHAR(255),
	CONTENT_TYPE VARCHAR(50),
	CUSTOMER_ID BIGINT
);

INSERT INTO
	USER_CONTENTS (
		CONTENT_ID,
		CONTENT_TEXT,
		CONTENT_TYPE,
		CUSTOMER_ID
	)
VALUES
	(201, 'Welcome Post', 'Blog', 1),
	(202, 'Product Review', 'Review', 2),
	(203, 'Event Photos', 'Photo', 3),
	(204, 'Tutorial Video', 'Video', 3),
	(205, 'Survey Response', 'Survey', 4);

-- Query:
WITH
	ALL_INTERACTIONS AS (
		SELECT
			CUSTOMER_ID,
			COUNT(*) AS TOTAL_INTERACTIONS
		FROM
			CUSTOMER_INTERACTIONS
		GROUP BY
			CUSTOMER_ID
	),
	ALL_CONTENTS AS (
		SELECT
			CUSTOMER_ID,
			COUNT(*) AS TOTAL_CONTENTS
		FROM
			USER_CONTENTS
		GROUP BY
			CUSTOMER_ID
	)
SELECT
	I.CUSTOMER_ID,
	TOTAL_INTERACTIONS,
	TOTAL_CONTENTS
FROM
	ALL_INTERACTIONS I
	JOIN ALL_CONTENTS C ON I.CUSTOMER_ID = C.CUSTOMER_ID
ORDER BY
	I.CUSTOMER_ID;

-- Reset Database:
DROP TABLE CUSTOMER_INTERACTIONS;
DROP TABLE USER_CONTENTS;