-- 𝐌𝐮𝐬𝐭 𝐓𝐫𝐲: Microsoft(Medium Level) #SQL Interview Question — Solution
-- Given a list of projects and employees mapped to each project, calculate by the amount of 
-- project budget allocated to each employee. The output should include the project title and the
-- project budget rounded to the closest integer. Order your list by projects with the highest budget
-- per employee first.

-- Database setup:
CREATE TABLE MS_PROJECTS (ID INT, TITLE VARCHAR(15), BUDGET INT);
INSERT INTO
	MS_PROJECTS
VALUES
	(1, 'Project1', 29498),
	(2, 'Project2', 32487),
	(3, 'Project3', 43909),
	(4, 'Project4', 15776),
	(5, 'Project5', 36268),
	(6, 'Project6', 41611),
	(7, 'Project7', 34003),
	(8, 'Project8', 49284),
	(9, 'Project9', 32341),
	(10, 'Project10', 47587),
	(11, 'Project11', 11705),
	(12, 'Project12', 10468),
	(13, 'Project13', 43238),
	(14, 'Project14', 30014),
	(15, 'Project15', 48116),
	(16, 'Project16', 19922),
	(17, 'Project17', 19061),
	(18, 'Project18', 10302),
	(19, 'Project19', 44986),
	(20, 'Project20', 19497);
CREATE TABLE MS_EMP_PROJECTS (EMP_ID INT, PROJECT_ID INT);
INSERT INTO
	MS_EMP_PROJECTS
VALUES
	(10592, 1),
	(10593, 2),
	(10594, 3),
	(10595, 4),
	(10596, 5),
	(10597, 6),
	(10598, 7),
	(10599, 8),
	(10600, 9),
	(10601, 10),
	(10602, 11),
	(10603, 12),
	(10604, 13),
	(10605, 14),
	(10606, 15),
	(10607, 16),
	(10608, 17),
	(10609, 18),
	(10610, 19),
	(10611, 20);

-- Query:
SELECT
	P.TITLE AS PROJECT_TITLE,
	ROUND(P.BUDGET / COUNT(E.EMP_ID)) AS BUDGET_PER_EMPLOYEE
FROM
	MS_PROJECTS P,
	MS_EMP_PROJECTS E
WHERE
	P.ID = E.PROJECT_ID
GROUP BY
	P.ID,
	P.TITLE,
	P.BUDGET
ORDER BY
	BUDGET_PER_EMPLOYEE DESC;

-- Reset Database:
DROP TABLE MS_PROJECTS;
DROP TABLE MS_EMP_PROJECTS;