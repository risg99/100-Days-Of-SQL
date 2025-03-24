-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Airbnb(Medium Level) #SQL Interview Question — Solution
-- Find the total number of available beds per hosts' nationality.
-- Output the nationality along with the corresponding total number of available beds. 
-- Sort records by the total available beds in descending order.

-- Database setup:
CREATE TABLE AIRBNB_APARTMENTS (
	HOST_ID INT,
	APARTMENT_ID VARCHAR(5),
	APARTMENT_TYPE VARCHAR(10),
	N_BEDS INT,
	N_BEDROOMS INT,
	COUNTRY VARCHAR(20),
	CITY VARCHAR(20)
);

INSERT INTO
	AIRBNB_APARTMENTS
VALUES
	(0, 'A1', 'Room', 1, 1, 'USA', 'NewYork'),
	(0, 'A2', 'Room', 1, 1, 'USA', 'NewJersey'),
	(0, 'A3', 'Room', 1, 1, 'USA', 'NewJersey'),
	(1, 'A4', 'Apartment', 2, 1, 'USA', 'Houston'),
	(1, 'A5', 'Apartment', 2, 1, 'USA', 'LasVegas'),
	(3, 'A7', 'Penthouse', 3, 3, 'China', 'Tianjin'),
	(3, 'A8', 'Penthouse', 5, 5, 'China', 'Beijing'),
	(4, 'A9', 'Apartment', 2, 1, 'Mali', 'Bamako'),
	(5, 'A10', 'Room', 3, 1, 'Mali', 'Segou');

CREATE TABLE AIRBNB_HOSTS (
	HOST_ID INT,
	NATIONALITY VARCHAR(15),
	GENDER VARCHAR(5),
	AGE INT
);

INSERT INTO
	AIRBNB_HOSTS
VALUES
	(0, 'USA', 'M', 28),
	(1, 'USA', 'F', 29),
	(2, 'China', 'F', 31),
	(3, 'China', 'M', 24),
	(4, 'Mali', 'M', 30),
	(5, 'Mali', 'F', 30);

-- Query:
SELECT
	H.NATIONALITY,
	SUM(A.N_BEDS) AS TOTAL_BEDS_AVAILABLE
FROM
	AIRBNB_APARTMENTS A
	JOIN AIRBNB_HOSTS H ON A.HOST_ID = H.HOST_ID
GROUP BY
	H.NATIONALITY
ORDER BY
	TOTAL_BEDS_AVAILABLE DESC;

-- Reset Database:
DROP TABLE AIRBNB_APARTMENTS;
DROP TABLE AIRBNB_HOSTS;