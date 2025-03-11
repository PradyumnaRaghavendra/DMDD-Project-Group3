CREATE DATABASE P4C;

USE P4C;

-- Drop all existing objects if they exist
DROP TABLE IF EXISTS SalesDetails;
DROP TABLE IF EXISTS Sales;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS InventoryTransactions;
DROP TABLE IF EXISTS Inventory;
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Suppliers;
DROP TABLE IF EXISTS PurchaseOrderDetails;
DROP TABLE IF EXISTS PurchaseOrders;
DROP TABLE IF EXISTS SalesEmployee;

-- Create Suppliers table first to avoid FK issues
CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Contact NVARCHAR(15),
    Address NVARCHAR(255),
    ProductSupplied NVARCHAR(MAX)
);

-- Create Customers table
CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Contact NVARCHAR(15),
    Email NVARCHAR(100) CHECK (Email LIKE '_%@_%._%'), -- CHECK constraint for valid email format
    PurchaseHistory NVARCHAR(MAX),
    LoyaltyPoints INT DEFAULT 0
);

-- Create Products table
CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Category NVARCHAR(50),
    Price DECIMAL(10, 2) NOT NULL CHECK (Price >= 0),
    StockLevel INT NOT NULL CHECK (StockLevel >= 0),
    SupplierID INT,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create Sales table
CREATE TABLE Sales (
    SaleID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT,
    TotalAmount DECIMAL(10, 2) NOT NULL CHECK (TotalAmount > 0), -- CHECK constraint for valid TotalAmount
    SaleDate DATETIME DEFAULT GETDATE(),
    InvoiceNumber NVARCHAR(50),
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create SalesDetails table
CREATE TABLE SalesDetails (
    SaleID INT,
    ProductID INT,
    Quantity INT NOT NULL CHECK (Quantity > 0),
    Subtotal DECIMAL(10, 2) NOT NULL CHECK (Subtotal >= 0),
    PRIMARY KEY (SaleID, ProductID),
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create Employees table
CREATE TABLE Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Role NVARCHAR(50) NOT NULL,
    Contact NVARCHAR(15),
    Salary DECIMAL(10, 2) NOT NULL CHECK (Salary BETWEEN 1000 AND 10000) -- CHECK constraint for salary range
);

-- Create SalesEmployee table
CREATE TABLE SalesEmployee (
    SaleID INT,
    EmployeeID INT,
    PRIMARY KEY (SaleID, EmployeeID),
    FOREIGN KEY (SaleID) REFERENCES Sales(SaleID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

-- Create Inventory table
CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT NOT NULL,
    StockLevel INT NOT NULL CHECK (StockLevel >= 0),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);

-- Create InventoryTransactions table (for batch tracking)
CREATE TABLE InventoryTransactions (
    TransactionID INT IDENTITY(1,1) PRIMARY KEY,
    InventoryID INT NOT NULL,
    QuantityChanged INT NOT NULL,
    TransactionDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID)
);

-- Create PurchaseOrders table
CREATE TABLE PurchaseOrders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierID INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    ExpectedDelivery DATETIME,
    FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
);

-- Create PurchaseOrderDetails table
CREATE TABLE PurchaseOrderDetails (
    OrderID INT,
    ProductID INT,
    QuantityOrdered INT NOT NULL CHECK (QuantityOrdered > 0),
    PricePerUnit DECIMAL(10, 2) NOT NULL CHECK (PricePerUnit >= 0),
    PRIMARY KEY (OrderID, ProductID),
    FOREIGN KEY (OrderID) REFERENCES PurchaseOrders(OrderID),
    FOREIGN KEY (ProductID) REFERENCES Products(ProductID)
);