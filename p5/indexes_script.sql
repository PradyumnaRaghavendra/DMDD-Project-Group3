USE P4C;
GO

--Non-clustered Indexes
-- Index 1: Speed up customer searches by Name
CREATE NONCLUSTERED INDEX idx_CustomerName 
ON Customers(Name);

-- Index 2: Optimize sales queries by Date
CREATE NONCLUSTERED INDEX idx_SalesDate 
ON Sales(SaleDate);

-- Index 3: Speed up product filtering by Category
CREATE NONCLUSTERED INDEX idx_Product_Category 
ON Products(Category);

--Verifying the usage
-- Check query plan for a search by customer name
SET STATISTICS IO ON;
SELECT * FROM Customers WHERE Name = 'John Doe';
SET STATISTICS IO OFF;

-- Check query plan for recent sales
SET STATISTICS IO ON;
SELECT * FROM Sales WHERE SaleDate > '2024-01-01';
SET STATISTICS IO OFF;

-- Check query plan for product filtering
SET STATISTICS IO ON;
SELECT * FROM Products WHERE Category = 'Electronics';
SET STATISTICS IO OFF;