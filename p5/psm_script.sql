USE P4C;
GO

-- Stored Procedures
--1. Customer Purchase History
CREATE PROCEDURE GetCustomerPurchaseHistory 
    @custID INT
AS
BEGIN
    BEGIN TRY
        SELECT * 
        FROM Sales 
        WHERE CustomerID = @custID;
    END TRY
    BEGIN CATCH
        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END;
GO

--2. Insert sale
CREATE PROCEDURE InsertSale 
    @custID INT, 
    @total DECIMAL(10,2), 
    @newID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        INSERT INTO Sales (CustomerID, TotalAmount) 
        VALUES (@custID, @total);

        SET @newID = SCOPE_IDENTITY();

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END;
GO

--Update Stock
CREATE PROCEDURE UpdateStock 
    @prodID INT, 
    @quantitySold INT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        UPDATE Products 
        SET StockLevel = StockLevel - @quantitySold 
        WHERE ProductID = @prodID;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END;
GO

--Process Sale
CREATE PROCEDURE ProcessSale
    @custID INT,
    @prodID INT,
    @quantity INT,
    @total DECIMAL(10,2),
    @saleID INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert Sale
        INSERT INTO Sales (CustomerID, TotalAmount) 
        VALUES (@custID, @total);
        SET @saleID = SCOPE_IDENTITY();

        -- Insert into SalesDetails
        INSERT INTO SalesDetails (SaleID, ProductID, Quantity) 
        VALUES (@saleID, @prodID, @quantity);

        -- Update Inventory
        UPDATE Products 
        SET StockLevel = StockLevel - @quantity 
        WHERE ProductID = @prodID;

        COMMIT;
    END TRY
    BEGIN CATCH
        ROLLBACK;

        DECLARE @ErrMsg NVARCHAR(4000), @ErrSeverity INT;
        SELECT @ErrMsg = ERROR_MESSAGE(), @ErrSeverity = ERROR_SEVERITY();
        RAISERROR(@ErrMsg, @ErrSeverity, 1);
    END CATCH
END;
GO


-- Views

GO
CREATE VIEW CustomerSales AS
SELECT c.Name, s.TotalAmount, s.InvoiceNumber
FROM Customers c
JOIN Sales s ON c.CustomerID = s.CustomerID;
GO

GO
CREATE VIEW InventoryStatus AS
SELECT p.Name, i.StockLevel 
FROM Products p
JOIN Inventory i ON p.ProductID = i.ProductID;
GO

GO
CREATE VIEW EmployeeSales AS
SELECT e.Name, COUNT(se.SaleID) AS SalesCount
FROM Employees e
JOIN SalesEmployee se ON e.EmployeeID = se.EmployeeID
GROUP BY e.Name;
GO

--USer-Defined Functions

CREATE FUNCTION GetTotalSales()
RETURNS DECIMAL(10,2)
AS
BEGIN
    DECLARE @total DECIMAL(10,2);
    SELECT @total = SUM(TotalAmount) FROM Sales;
    RETURN @total;
END;
GO

CREATE FUNCTION GetDiscountPrice(@price DECIMAL(10,2), @discount INT)
RETURNS DECIMAL(10,2)
AS
BEGIN
    RETURN @price - (@price * @discount / 100);
END;
GO

CREATE FUNCTION GetLoyaltyPoints(@custID INT)
RETURNS INT
AS
BEGIN
    DECLARE @points INT;
    SELECT @points = LoyaltyPoints FROM Customers WHERE CustomerID = @custID;
    RETURN @points;
END;
GO

-- Trigger

CREATE TRIGGER UpdateInventoryAfterSale
ON SalesDetails
AFTER INSERT
AS
BEGIN
    UPDATE Products
    SET StockLevel = StockLevel - i.Quantity
    FROM Products p
    JOIN inserted i ON p.ProductID = i.ProductID;
END;
GO

-- Indexes

CREATE INDEX idx_CustomerEmail ON Customers(Email);
GO
CREATE INDEX idx_ProductCategory ON Products(Category);
GO
CREATE INDEX idx_SupplierName ON Suppliers(Name);
GO








