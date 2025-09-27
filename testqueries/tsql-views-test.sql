/*
Useful for creating virtual tables. 
NOTE: They do not store data themselves, they work like subqueries.

1. Create View
CREATE VIEW VIEW_NAME AS
	...

2. "Delete" View
DROP VIEW VIEW_NAME

3. Change View
ALTER VIEW VIEW_NAME AS
	...

4. Insert, Update, Delete
- Can only perform these operations on simple views, where the resultant data 
is not sorted or filtered such as with TOP, ORDER BY, or aggregation (COUNT, MAX, etc.).

CREATE VIEW vw_AllUsers AS
	SELECT Id, DisplayName, Reputation
	FROM Users
	WHERE REPUTATION > 1000;

INSERT INTO vw_ALLUSERS (Id, DisplayName, Reputation) VALUES (999, 'NewUser', 1);

*/

USE STACKOVERFLOW2010;

/*
GO
CREATE VIEW Bottom10Users AS 
	SELECT TOP 10 * FROM USERS ORDER BY REPUTATION ASC;

SELECT * FROM Bottom10Users;
*/

--CTE

WITH AvgReputationByUser AS (
    SELECT DisplayName, AVG(Reputation) AS AvgReputation
    FROM Users
    GROUP BY DisplayName
)
/*
SELECT *
FROM AvgReputationByUser;
*/

SELECT u.Id, u.displayName, u.location,
AVG(REPUTATION) OVER (PARTITION BY location) AS AvgReputationByLocation
FROM USERS u;


SELECT u.Id, u.displayName, u.location,
       AVG(p.Score) OVER (PARTITION BY u.location) AS AvgReputationByLocation
FROM Users u
JOIN Posts p ON u.Id = p.OwnerUserId;