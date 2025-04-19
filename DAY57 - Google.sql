-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google (Hard Level) #SQL Interview Question — Solution
-- Find the top 3 most common letters across all the words from both the tables 
-- (ignore filename column). Output the letter along with the number of occurrences 
-- and order records in descending order based on the number of occurrences.

-- Database setup:
CREATE TABLE GOOGLE_FILE_STORE (CONTENTS VARCHAR(500), FILENAME VARCHAR(255));

INSERT INTO
	GOOGLE_FILE_STORE (CONTENTS, FILENAME)
VALUES
	(
		'This is a sample content with some words.',
		'file1.txt'
	),
	(
		'Another file with more words and letters.',
		'file2.txt'
	),
	(
		'Text for testing purposes with various characters.',
		'file3.txt'
	);

CREATE TABLE GOOGLE_WORD_LISTS (WORDS1 VARCHAR(500), WORDS2 VARCHAR(500));

INSERT INTO
	GOOGLE_WORD_LISTS (WORDS1, WORDS2)
VALUES
	('apple banana cherry', 'dog elephant fox'),
	('grape honeydew kiwi', 'lemon mango nectarine'),
	(
		'orange papaya quince',
		'raspberry strawberry tangerine'
	);

-- Query:
WITH
	ALL_WORDS AS (
		SELECT
			UNNEST(STRING_TO_ARRAY(LOWER(CONTENTS), ' ')) AS WORDS
		FROM
			GOOGLE_FILE_STORE
		UNION ALL
		SELECT
			UNNEST(STRING_TO_ARRAY(LOWER(WORDS1), ' ')) AS WORDS
		FROM
			GOOGLE_WORD_LISTS
		UNION ALL
		SELECT
			UNNEST(STRING_TO_ARRAY(LOWER(WORDS2), ' ')) AS WORDS
		FROM
			GOOGLE_WORD_LISTS
	),
	EXTRACT_LETTERS AS (
		SELECT
			REGEXP_SPLIT_TO_TABLE(WORDS, '') AS LETTER
		FROM
			ALL_WORDS
	),
	ONLY_LETTERS AS (
		SELECT
			LETTER
		FROM
			EXTRACT_LETTERS
		WHERE
			LETTER ~ '^[a-z]$'
	),
	LETTER_COUNTS AS (
		SELECT
			LETTER,
			COUNT(*) AS OCCURRENCES
		FROM
			ONLY_LETTERS
		GROUP BY
			LETTER
	)
SELECT
	LETTER,
	OCCURRENCES
FROM
	LETTER_COUNTS
ORDER BY
	OCCURRENCES DESC
LIMIT
	3;

-- Reset Database:
DROP TABLE GOOGLE_FILE_STORE;
DROP TABLE GOOGLE_WORD_LISTS;