-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Cisco (Hard Level) #SQL Interview Question — Solution
-- Convert the first letter of each word found in content_text to uppercase, while keeping the 
-- rest of the letters lowercase. Your output should include the original text in one column and
-- the modified text in another column.

-- Database setup:
CREATE TABLE USER_CONTENT (
	CONTENT_ID INT PRIMARY KEY,
	CUSTOMER_ID INT,
	CONTENT_TYPE VARCHAR(50),
	CONTENT_TEXT VARCHAR(255)
);

INSERT INTO
	USER_CONTENT (
		CONTENT_ID,
		CUSTOMER_ID,
		CONTENT_TYPE,
		CONTENT_TEXT
	)
VALUES
	(1, 2, 'comment', 'hello world! this is a TEST.'),
	(2, 8, 'comment', 'what a great day'),
	(3, 4, 'comment', 'WELCOME to the event.'),
	(4, 2, 'comment', 'e-commerce is booming.'),
	(5, 6, 'comment', 'Python is fun!!'),
	(6, 6, 'review', '123 numbers in text.'),
	(7, 10, 'review', 'special chars: @#$$%^&*()'),
	(8, 4, 'comment', 'multiple CAPITALS here.'),
	(9, 6, 'review', 'sentence. and ANOTHER sentence!'),
	(10, 2, 'post', 'goodBYE!');

-- Query:
SELECT
	CONTENT_ID,
	CONTENT_TEXT AS ORIGINAL_TEXT,
	INITCAP(CONTENT_TEXT) AS MODIFIED_TEXT
FROM
	USER_CONTENT;

-- Reset Database:
DROP TABLE USER_CONTENT;