-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Accenture(Medium Level) #SQL Interview Question — Solution
-- Following a recent advertising campaign, the marketing department wishes to classify
-- its efforts based on the total number of units sold for each product. You have been
-- tasked with calculating the total number of units sold for each product and 
-- categorizing ad performance based on the following criteria for items sold:

-- Outstanding: 30+
-- Satisfactory: 20 - 29
-- Unsatisfactory: 10 - 19
-- Poor: 1 - 9
-- Your output should contain the product ID, total units sold in descending order,
-- and its categorized ad performance.

-- Database setup:
CREATE TABLE MARKETING_CAMPAIGN (
	USER_ID INT,
	CREATED_AT DATE,
	PRODUCT_ID INT,
	QUANTITY INT,
	PRICE INT
);

INSERT INTO
	MARKETING_CAMPAIGN (USER_ID, CREATED_AT, PRODUCT_ID, QUANTITY, PRICE)
VALUES
	(1, '2020-01-01', 101, 25, 200),
	(2, '2020-01-01', 102, 5, 150),
	(3, '2020-01-02', 103, 15, 300),
	(4, '2020-01-03', 101, 10, 200),
	(5, '2020-01-04', 102, 22, 150),
	(6, '2020-01-05', 104, 8, 120),
	(7, '2020-01-06', 105, 18, 250),
	(8, '2020-01-07', 101, 30, 200),
	(9, '2020-01-08', 103, 20, 300),
	(10, '2020-01-09', 104, 9, 120);

-- Query:
SELECT
	PRODUCT_ID,
	SUM(QUANTITY) AS TOTAL_UNITS,
	CASE
		WHEN SUM(QUANTITY) >= 30 THEN 'Outstanding'
		WHEN SUM(QUANTITY) BETWEEN 20 AND 29  THEN 'Satisfactory'
		WHEN SUM(QUANTITY) BETWEEN 10 AND 19  THEN 'Unsatisfactory'
		WHEN SUM(QUANTITY) <= 9 THEN 'Poor'
		ELSE 'No Sales'
	END AS CATEGORISED_AD_PERFORMANCE
FROM
	MARKETING_CAMPAIGN
GROUP BY
	PRODUCT_ID
ORDER BY
	TOTAL_UNITS DESC;

-- Reset Database:
DROP TABLE MARKETING_CAMPAIGN;