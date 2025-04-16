-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Walmart (Hard Level) #SQL Interview Question — Solution
-- Identify users who started a session and placed an order on the same day. 
-- For these users, calculate the total number of orders and the total order value
-- for that day. Your output should include the user, the session date, the total 
-- number of orders, and the total order value for that day.

-- Database setup:
CREATE TABLE SESSIONS (SESSION_ID INT, USER_ID INT, SESSION_DATE DATE);

INSERT INTO
	SESSIONS (SESSION_ID, USER_ID, SESSION_DATE)
VALUES
	(1, 1, '2024-01-01'),
	(2, 2, '2024-01-02'),
	(3, 3, '2024-01-05'),
	(4, 3, '2024-01-05'),
	(5, 4, '2024-01-03'),
	(6, 4, '2024-01-03'),
	(7, 5, '2024-01-04'),
	(8, 5, '2024-01-04'),
	(9, 3, '2024-01-05'),
	(10, 5, '2024-01-04');

CREATE TABLE ORDER_SUMMARY (
	ORDER_ID INT,
	USER_ID INT,
	ORDER_VALUE INT,
	ORDER_DATE DATE
);

INSERT INTO
	ORDER_SUMMARY (ORDER_ID, USER_ID, ORDER_VALUE, ORDER_DATE)
VALUES
	(1, 1, 152, '2024-01-01'),
	(2, 2, 485, '2024-01-02'),
	(3, 3, 398, '2024-01-05'),
	(4, 3, 320, '2024-01-05'),
	(5, 4, 156, '2024-01-03'),
	(6, 4, 121, '2024-01-03'),
	(7, 5, 238, '2024-01-04'),
	(8, 5, 70, '2024-01-04'),
	(9, 3, 152, '2024-01-05'),
	(10, 5, 171, '2024-01-04');

-- Query:
SELECT
	S.USER_ID,
	S.SESSION_DATE AS SESSION_DATE,
	COUNT(O.ORDER_ID) AS TOTAL_ORDERS,
	SUM(O.ORDER_VALUE) AS TOTAL_ORDER_VALUE
FROM
	SESSIONS S
	JOIN ORDER_SUMMARY O ON S.SESSION_DATE = O.ORDER_DATE
GROUP BY
	S.USER_ID,
	S.SESSION_DATE
ORDER BY
	S.USER_ID,
	S.SESSION_DATE;

-- Reset Database:
DROP TABLE SESSIONS;

DROP TABLE ORDER_SUMMARY;