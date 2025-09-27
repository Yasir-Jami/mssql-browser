USE STACKOVERFLOW2010;

/* ###BEGINNER### */

/* 1. List the top 10 users by reputation. */
/*
SELECT TOP 10 * 
FROM USERS 
ORDER BY REPUTATION DESC;
*/

-- 2. Retrieve all questions created after January 1, 2010.
/*
SELECT * 
FROM Posts 
WHERE PostTypeId = 1 
	AND CreationDate > '2010-01-01';
*/

/* 3. Find the number of comments per post and show only posts with more than 5 comments.  */

/*
SELECT PostId, COUNT(*) AS CommentCount
FROM Comments
GROUP BY PostId
HAVING COUNT(*) > 5;
*/


/* 4. Get the top 5 most viewed questions. */

/*
SELECT TOP 5 * 
FROM POSTS
WHERE PostTypeId = 1
ORDER BY ViewCount DESC;
*/


/* ###INTERMEDIATE### */
/* 5. Show the average score per user and list the top 10 by average. */
/*
SELECT TOP 10 u.DisplayName, ROUND(AVG(p.Score), 2) as AVG_SCORE
FROM Users u
JOIN Posts p
	ON u.Id = p.OwnerUserId
GROUP BY u.DisplayName
ORDER BY AVG_SCORE DESC;
*/

-- Link user with ownerUserID


/* 6. Find users who have written more than 100 comments. */
/*
SELECT u.displayName, COUNT(c.userId) as commentCount
FROM Users u
JOIN Comments c
	ON c.userId = u.Id
GROUP BY u.displayName
HAVING COUNT(c.userId) >= 100;
*/

/* 7. List all questions that don’t have an accepted answer. */

/*
SELECT p.Title
FROM Posts p
WHERE PostTypeId = 1
	AND AcceptedAnswerId = 0 OR AcceptedAnswerId IS NULL;
*/

/* ###ADVANCED### */

/* 8. Identify users who posted both questions and answers in 2010. */
/*
WITH PostsQuestions AS 
(
	SELECT DISTINCT OwnerUserId
	FROM POSTS 
	WHERE PostTypeId = 1
),
PostsAnswers AS 
(
	SELECT DISTINCT OwnerUserId
	FROM POSTS 
	WHERE PostTypeId = 2
)
SELECT DISTINCT u.displayName, p1.CreationDate
FROM Posts p1
JOIN Posts p2 ON p1.OwnerUserId = p2.OwnerUserId
JOIN Users u ON u.Id = p1.OwnerUserId
WHERE p1.CreationDate >= '2010' 
	AND p1.CreationDate < '2011'
	AND p1.PostTypeId = 1 
	AND p2.PostTypeId = 2;
*/

/*
Show the users with both questions and answers
This user will have at least one post with PostTypeId = 1 AND PostTypeId = 2
How to identify if a user has posted a question and answer?

*/


/* 9. Find questions where the stored `AnswerCount` doesn't match the actual number of answers. */
SELECT 
	q.id AS QuestionId, 
	q.answerCount AS storedCount, 
	COUNT(a.id) AS actualAnswerCount,
	ABS(q.AnswerCount - COUNT(a.id)) AS countDiscrepancy
FROM POSTS q
LEFT JOIN Posts a ON q.id = a.parentId AND a.postTypeId = 2 -- Get only answers that are matched with a question
WHERE q.PostTypeId = 1 
GROUP BY q.id, q.answerCount
HAVING COUNT(a.id) != q.AnswerCount
ORDER BY ABS(q.AnswerCount - COUNT(a.id)) DESC;

/*
Q9 Breakdown

We need to find the questions where there are inconsistencies between answerCount in a record containing a question 
and the actual number of answers attached to a question
-- Headers: Question ID, storedCount, actualAnswerCount (number of answers)

1. a is a table where the post is attached to a question and it is an answer, left join to show all questions
2. Left table contains only posts that are questions using where clause (q.postTypeId = 1)
3. Group the data by the questions and the question's storedCount
	- This will group the answers that have that specific question ID as a parent (actualAnswerCount)
4. Having clause: filter to only the records where the actual number of answers attached to a question does not equal the stored count

Order by not necessary: orders by the questions with the greatest discrepancies

*/


/* 10. List the top 3 users by total upvotes received on their answers. */
/*
SELECT TOP 3 u.displayName, SUM(p.Score) AS TotalUpvotes
FROM Users u
JOIN Posts p ON u.id = p.OwnerUserId
WHERE p.PostTypeId = 2
GROUP BY u.displayName
ORDER BY TotalUpVotes DESC;
*/