USE PersonalFinances;
/*
CREATE TABLE LivingExpenses (
	id INT NOT NULL IDENTITY(0,1) PRIMARY KEY,
	itemName VARCHAR(50) NOT NULL,
	itemCategory VARCHAR(50), -- 
	expenseFrequency VARCHAR(50), -- Continuous, one-time
	cost INT,
	date DATE
)

-- Current categories: rent, utilities, phone, food, car


INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('rent', 'rent', 'continuous');
INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('internet', 'utilities', 'continuous');
INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('electricity', 'utilities', 'continuous');
INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('heat', 'utilities', 'continuous');
INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('phone plan', 'phone', 'continuous');
INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('couch', 'furniture', 'one-time');
INSERT INTO LivingExpenses(itemName, itemCategory, expenseFrequency) VALUES ('toaster oven', 'appliances', 'one-time');
*/

/*
UPDATE LivingExpenses 
SET itemName = 'phone plan'
WHERE itemCategory = 'ph_ne'
*/

--Date formatted according to ISO 8601: YYYY-MM-DD

--EXEC countItemsByCategory;

--EXEC addNewItem 'ball', 'ball', 'one-time', 10, '2025-06-18';

SELECT * FROM LivingExpenses;