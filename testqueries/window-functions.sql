USE STACKOVERFLOW2010;


/*
Definitions:

Window - refers to a set of rows that the window function operates over
	think of it like placing a frame over a larger set.
Partitioning - divides the data into separate groups
Ordering - specifies the order within each partition
Framing - controls the range of rows considered for calculations 
	(e.g., all rows before current one, or a specific number of preceding and following rows).

Window Functions

- Window functions operate on a set of rows and returns a value for each row.

e.g., RANK() OVER (ORDER BY Reputation DESC) AS ReputationRank

Here, the RANK function will assign a rank to each row based on the provided ordering (Reputation) and create a new column, ReputationRank.

NOTE: If there is a tie between 2 rows, for example for 1st place, the third row will be 3rd place;

OVER Clause
- This clause is what distinguishes window functions and aggregate functions, 
  and tells the previous function to be applied across a window of rows**.
  It DEFINES what the window should look like.

  Without the OVER clause in the previous example, SQL would calculate the rank 
  for the entire result set without considering individual row order.

**Window essentially means a group or range of rows related to the current row based on a given criteria.
  Unlike aggregate functions, which summarize entire groups of rows, window functions do NOT collapse the rows into a single result.

  You can also choose to partition, for example, by department.

  SELECT 
		UserId,
		DisplayName,
		Reputation,
		Department,
		RANK() OVER (PARTITION BY Department ORDER BY Reputation DESC) AS ReputationRank
	FROM Users;

  This would rank each user within their own department, and not ranked as part of the entire set, 
  e.g., HR Rank 1, HR Rank 2, Sales Rank 1, Sales Rank 2.



*/

/* Rank Users by Reputation
SELECT 
    Id,
    DisplayName,
    Reputation,
    RANK() OVER (ORDER BY Reputation DESC) AS ReputationRank
FROM Users;
*/

--Get Each User's Most Recent Post
SELECT *
FROM (
    SELECT 
        Id,
        OwnerUserId,
        Title,
        CreationDate,
        ROW_NUMBER() OVER (PARTITION BY OwnerUserId ORDER BY CreationDate DESC) AS rn
    FROM Posts
) AS RecentPosts
WHERE rn = 1;

/*
Running Total of Votes Per Post
SELECT 
    PostId,
    VoteTypeId,
    CreationDate,
    COUNT(*) OVER (PARTITION BY PostId ORDER BY CreationDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningVoteCount
FROM Votes;
*/


/*
Time Between Posts per User
SELECT 
    OwnerUserId,
    Id AS PostId,
    CreationDate,
    LAG(CreationDate) OVER (PARTITION BY OwnerUserId ORDER BY CreationDate) AS PrevPostDate,
    DATEDIFF(DAY, LAG(CreationDate) OVER (PARTITION BY OwnerUserId ORDER BY CreationDate), CreationDate) AS DaysBetweenPosts
FROM Posts
WHERE OwnerUserId IS NOT NULL;
*/


/*
Table of daily sales data for a retail store, track the running total of sales over the past week.

SELECT 
    SalesDate,
    SaleAmount,
    SUM(SaleAmount) OVER (ORDER BY SalesDate ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RunningTotal
FROM Sales
WHERE SalesDate BETWEEN '2025-06-01' AND '2025-06-07';

*/
