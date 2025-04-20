-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Google (Hard Level) #SQL Interview Question — Solution
-- We want to identify the most suspicious claims in each state. We'll consider
-- the top 5 percentile of claims with the highest fraud scores in each state 
-- as potentially fraudulent. Your output should include the policy number, 
-- state, claim cost, and fraud score.

-- Database setup:
CREATE TABLE CLAIMS (
	POLICY_NUMBER VARCHAR(50),
	STATE VARCHAR(50),
	CLAIM_COST FLOAT,
	FRAUD_SCORE FLOAT
);

INSERT INTO
	CLAIMS (POLICY_NUMBER, STATE, CLAIM_COST, FRAUD_SCORE)
VALUES
	('POL123', 'CA', 10000.00, 85.5),
	('POL124', 'CA', 5000.00, 70.2),
	('POL125', 'CA', 20000.00, 92.8),
	('POL126', 'NY', 15000.00, 88.1),
	('POL127', 'NY', 8000.00, 65.4),
	('POL128', 'NY', 25000.00, 93.7),
	('POL129', 'TX', 12000.00, 75.3),
	('POL130', 'TX', 18000.00, 95.2),
	('POL131', 'TX', 9000.00, 60.0),
	('POL132', 'FL', 11000.00, 82.0),
	('POL133', 'FL', 14000.00, 87.5),
	('POL134', 'FL', 30000.00, 99.0);

-- Query:
WITH
	ALL_PERCENTILE_RANK AS (
		SELECT
			*,
			PERCENT_RANK() OVER (
				PARTITION BY
					STATE
				ORDER BY
					FRAUD_SCORE
			) AS P_RANK
		FROM
			CLAIMS
	)
SELECT
	POLICY_NUMBER,
	STATE,
	CLAIM_COST,
	FRAUD_SCORE
FROM
	ALL_PERCENTILE_RANK
WHERE
	P_RANK >= 0.95;

-- Reset Database:
DROP TABLE CLAIMS;