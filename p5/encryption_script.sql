USE P4C;
GO
-- Encryption

ALTER TABLE Customers ADD EncryptedEmail VARBINARY(256);
GO

UPDATE Customers
SET [EncryptedEmail] = ENCRYPTBYPASSPHRASE('encryption_key', Email);
GO

ALTER TABLE Customers DROP COLUMN Email;
GO

EXEC sp_rename 'Customers.EncryptedEmail', 'Email', 'COLUMN';
GO

EXEC GetCustomerPurchaseHistory @custID = 1;

-- View Customer Sales
SELECT * FROM CustomerSales;

-- View Inventory Status
SELECT * FROM InventoryStatus;

-- View Employee Sales
SELECT * FROM EmployeeSales;


-- Test GetTotalSales
SELECT dbo.GetTotalSales() AS TotalSales;

-- Test GetDiscountPrice
SELECT dbo.GetDiscountPrice(200.00, 10) AS DiscountedPrice;

-- Test GetLoyaltyPoints
SELECT dbo.GetLoyaltyPoints(1) AS LoyaltyPoints;

SELECT CustomerID, Email, CONVERT(VARCHAR(MAX), DECRYPTBYPASSPHRASE('encryption_key', Email)) AS DecryptedEmail
FROM Customers;