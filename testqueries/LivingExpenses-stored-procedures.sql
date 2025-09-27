-- Count all items by category
/*
GO
CREATE PROCEDURE countItemsByCategory
AS
BEGIN
	SELECT itemCategory, COUNT(*) AS numberOfItems
	FROM LivingExpenses
	GROUP BY itemCategory;
END;
*/

-- Add a new item
/*
GO
CREATE PROCEDURE addNewItem
(
	@itemName VARCHAR(50),
	@itemCategory VARCHAR(50),
	@expenseFrequency VARCHAR(50),
	@cost INT,
	@date DATE
)
AS
BEGIN
	IF @itemName IS NULL
	BEGIN
		RAISERROR('The parameter @itemName cannot be NULL.', 16, 1);
		RETURN;
	END
	
	-- Begin Transaction
	BEGIN TRANSACTION
	
	BEGIN TRY
		INSERT INTO LivingExpenses (itemName, itemCategory, expenseFrequency, cost, date) 
		VALUES (@itemName, @itemCategory, @expenseFrequency, @cost, @date)
		COMMIT
	END TRY
	
	BEGIN CATCH
		ROLLBACK
		PRINT ERROR_MESSAGE()
	END CATCH

END;
*/

-- Get total expenses for a given month

-- Show total of each category, put total expenses in last column

-- Delete most recent item

-- Delete item specified by name and date

-- Change name, category, expenseFrequency, cost, and date of item

