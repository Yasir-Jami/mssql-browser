/*
GO
CREATE FUNCTION sumNumbers (@num1 INT, @num2 INT)
RETURNS INT
AS
BEGIN
	DECLARE @sum INT;
	SET @sum = @num1 + @num2;
	RETURN @sum;
END;

GO
CREATE FUNCTION getCurrentDateTime()
RETURNS DATETIME
AS
BEGIN
	RETURN GETDATE();
END;

*/

/*

DECLARE @OrderId INT;
DECLARE @TotalAmount DECIMAL(10, 2);
DECLARE @CustomerName NVARCHAR(100);

-- Simulating values for illustration
SET @OrderId = 1023;

-- Query to get data and assign it to variables
SELECT @TotalAmount = OrderAmount, @CustomerName = CustomerName
FROM Orders
WHERE OrderId = @OrderId;

PRINT 'Customer: ' + @CustomerName;
PRINT 'Total Amount: ' + CAST(@TotalAmount AS NVARCHAR(20));

*/

GO
DECLARE @FirstName NVARCHAR(50);
DECLARE @LastName NVARCHAR(50);
DECLARE @FullName NVARCHAR(100);

-- Assign values to the variables
SET @FirstName = 'John';
SET @LastName = 'Doe';

-- Concatenate the values into a full name
SET @FullName = @FirstName + ' ' + @LastName;

-- Print the full name
PRINT @FullName;


DECLARE @num1 INT = 50;
DECLARE @num2 INT = 39;

EXEC dbo.sumNumbers @num1, @num2;

--Table-Valued Function
USE STACKOVERFLOW2010;

GO
CREATE FUNCTION dbo.fn_GetAnswersByQuestion
(
    @QuestionID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        a.Id AS AnswerId,
        a.OwnerUserId AS UserId,
        u.Reputation,
        a.Score AS AnswerScore
    FROM
        Posts a
    INNER JOIN
        Users u ON a.OwnerUserId = u.Id
    WHERE
        a.ParentId = @QuestionID  -- Filter by Question ID for answers
        AND a.PostTypeId = 2      -- Ensure it's an answer (PostTypeId = 2)
);