-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Amazon (Hard Level) #SQL Interview Question — Solution
-- You are given the table with titles of recipes from a cookbook and their page numbers. 
-- You are asked to represent how the recipes will be distributed in the book.
-- Produce a table consisting of three columns: left_page_number, left_title and right_title. 
-- The k-th row (counting from 0), should contain the number and the title of the page with the 
-- number 2×k in the first and second columns respectively, and the title of the page with the 
-- number 2×k+1 in the third column. Each page contains at most 1 recipe. If the page does not 
-- contain a recipe, the appropriate cell should remain empty (NULL value). Page 0 (the internal 
-- side of the front cover) is guaranteed to be empty.

-- Database setup:
CREATE TABLE COOKBOOK_TITLES (PAGE_NUMBER INT PRIMARY KEY, TITLE VARCHAR(255));

INSERT INTO
	COOKBOOK_TITLES (PAGE_NUMBER, TITLE)
VALUES
	(1, 'Scrambled eggs'),
	(2, 'Fondue'),
	(3, 'Sandwich'),
	(4, 'Tomato soup'),
	(6, 'Liver'),
	(11, 'Fried duck'),
	(12, 'Boiled duck'),
	(15, 'Baked chicken');

-- Query:
WITH
	LEFT_PAGES AS (
		SELECT
			PAGE_NUMBER,
			TITLE
		FROM
			COOKBOOK_TITLES
		WHERE
			PAGE_NUMBER % 2 = 0
	),
	RIGHT_PAGES AS (
		SELECT
			PAGE_NUMBER,
			TITLE
		FROM
			COOKBOOK_TITLES
		WHERE
			PAGE_NUMBER % 2 = 1
	)
SELECT
	L.PAGE_NUMBER AS LEFT_PAGE_NUMBER,
	L.TITLE AS LEFT_TITLE,
	R.TITLE AS RIGHT_TITLE
FROM
	LEFT_PAGES L
	LEFT JOIN RIGHT_PAGES R ON L.PAGE_NUMBER + 1 = R.PAGE_NUMBER
ORDER BY
	L.PAGE_NUMBER;

-- Reset Database:
DROP TABLE COOKBOOK_TITLES;