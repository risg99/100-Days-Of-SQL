-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question
-- You have a table of in-app purchases by user. Users that make their first in-app purchase
-- are placed in a marketing campaign where they see call-to-actions for more in-app purchases.
-- Find the number of users that made additional in-app purchases due to the success of the 
-- marketing campaign. The marketing campaign doesn't start until one day after the initial
-- in-app purchase so users that only made one or multiple purchases on the first day do not
-- count, nor do we count users that over time purchase only the products they purchased on
-- the first day.

-- Database setup:
CREATE TABLE IN_APP_PURCHASES (
	CREATED_AT TIMESTAMP,
	PRICE BIGINT,
	PRODUCT_ID BIGINT,
	QUANTITY BIGINT,
	USER_ID BIGINT
);

INSERT INTO
	IN_APP_PURCHASES (CREATED_AT, PRICE, PRODUCT_ID, QUANTITY, USER_ID)
VALUES
	('2024-12-01 10:00:00', 500, 101, 1, 1),
	('2024-12-02 11:00:00', 700, 102, 1, 1),
	('2024-12-01 12:00:00', 300, 103, 1, 2),
	('2024-12-03 14:00:00', 400, 103, 1, 2),
	('2024-12-02 09:30:00', 200, 104, 1, 3),
	('2024-12-04 15:30:00', 600, 105, 2, 3),
	('2024-12-01 08:00:00', 800, 106, 1, 4),
	('2024-12-05 18:00:00', 500, 107, 1, 4),
	('2024-12-06 16:00:00', 700, 108, 1, 5);

-- Query:
WITH
	MARKETING_USERS AS (
		SELECT
			USER_ID,
			PRODUCT_ID AS ZERO_PRODUCT,
			CREATED_AT AS ZERO_PURCHASE,
			LEAD(PRODUCT_ID) OVER (
				PARTITION BY
					USER_ID
			) AS FIRST_PRODUCT,
			LEAD(CREATED_AT) OVER (
				PARTITION BY
					USER_ID
			) AS FIRST_PURCHASE
		FROM
			IN_APP_PURCHASES
	)
SELECT
	COUNT(USER_ID) AS SUCCESSFUL_USERS
FROM
	MARKETING_USERS
WHERE
	FIRST_PURCHASE IS NOT NULL
	AND ZERO_PRODUCT <> FIRST_PRODUCT
	AND DATE (ZERO_PURCHASE) + 1 <= DATE (FIRST_PURCHASE);

-- Reset Database:
DROP TABLE IN_APP_PURCHASES;